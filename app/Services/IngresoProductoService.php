<?php

namespace App\Services;

use App\Models\IngresoDetalle;
use App\Services\HistorialAccionService;
use App\Models\IngresoProducto;
use App\Models\Producto;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class IngresoProductoService
{
    private $modulo = "INGRESO DE PRODUCTOS";

    public function __construct(
        private HistorialAccionService $historialAccionService,
        private KardexProductoService $kardex_producto_service
    ) {}

    public function listado(): Collection
    {
        $ingreso_productos = IngresoProducto::select("ingreso_productos.*");
        $ingreso_productos = $ingreso_productos->get();
        return $ingreso_productos;
    }

    /**
     * Lista de productos paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = []): LengthAwarePaginator
    {
        $ingreso_productos = IngresoProducto::with(["producto:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value) && trim($value) != '') {
                $ingreso_productos->where("ingreso_productos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $ingreso_productos->whereBetween("ingreso_productos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $ingreso_productos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    if ($col == 'fecha_registro') {
                        $array_fecha = explode("/", $search);
                        $array_fecha = array_reverse($array_fecha);
                        if (count($array_fecha) > 0) {
                            $search = "";
                            foreach ($array_fecha as $key => $text) {
                                $search .= $text . ($key < count($array_fecha) - 1 ? '-' : '');
                            }
                        }
                    }
                    $query->orWhere("productos.$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $ingreso_productos->orderBy($value[0], $value[1]);
            }
        }

        $ingreso_productos = $ingreso_productos->paginate($length, ['*'], 'page', $page);
        return $ingreso_productos;
    }


    /**
     * Crear ingreso_producto
     *
     * @param array $datos
     * @return IngresoProducto
     */
    public function crear(array $datos): IngresoProducto
    {
        $ingreso_producto = IngresoProducto::create([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_registro" => date("Y-m-d"),
        ]);

        // kardex
        $producto = Producto::findOrFail($datos["producto_id"]);
        $this->kardex_producto_service->registroIngreso("INGRESO DE PRODUCTO", $producto, $datos["cantidad"], $producto->precio, $ingreso_producto->descripcion ?? '', "IngresoProducto", $ingreso_producto->id);


        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN INGRESO DE PRODUCTOS", $ingreso_producto, null);

        return $ingreso_producto;
    }

    /**
     * Actualizar ingreso_producto
     *
     * @param array $datos
     * @param IngresoProducto $ingreso_producto
     * @return IngresoProducto
     */
    public function actualizar(array $datos, IngresoProducto $ingreso_producto): IngresoProducto
    {
        $old_ingreso_producto = clone $ingreso_producto;

        $ingreso_producto->update([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);

        // SI LA CANTIDAD O EL PRODUCTO ES DIFERENTE
        if ($old_ingreso_producto->cantidad != $ingreso_producto->cantidad || $old_ingreso_producto->producto_id != $ingreso_producto->producto_id) {
            // kardex
            $old_producto = Producto::findOrFail($old_ingreso_producto->producto_id);
            // egreso
            $this->kardex_producto_service->registroEgreso("INGRESO DE PRODUCTO", $old_producto, $old_ingreso_producto->cantidad, $old_producto->precio, "POR MODIFICACIÓN DE INGRESO DE PRODUCTO", "IngresoProducto", $old_ingreso_producto->id);

            // ingreso
            $producto = Producto::findOrFail($datos["producto_id"]);
            $this->kardex_producto_service->registroIngreso("INGRESO DE PRODUCTO", $producto, $datos["cantidad"], $producto->precio, $ingreso_producto->descripcion ?? '', "IngresoProducto", $ingreso_producto->id);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN INGRESO DE PRODUCTOS", $old_ingreso_producto, $ingreso_producto);

        return $ingreso_producto;
    }

    /**
     * Eliminar ingreso_producto
     *
     * @param IngresoProducto $ingreso_producto
     * @return boolean
     */
    public function eliminar(IngresoProducto $ingreso_producto): bool
    {
        $old_ingreso_producto = clone $ingreso_producto;
        // egreso
        $producto = Producto::find($old_ingreso_producto->producto_id);
        $this->kardex_producto_service->registroEgreso("INGRESO DE PRODUCTO", $producto, $old_ingreso_producto->cantidad, $producto->precio, "POR ELIMINACIÓN DE INGRESO DE PRODUCTO", "IngresoProducto", $old_ingreso_producto->id);

        $ingreso_producto->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN INGRESO DE PRODUCTOS", $old_ingreso_producto, $ingreso_producto);

        return true;
    }
}
