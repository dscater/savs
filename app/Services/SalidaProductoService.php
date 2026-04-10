<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\SalidaProducto;
use App\Models\Producto;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class SalidaProductoService
{
    private $modulo = "SALIDA DE PRODUCTOS";

    public function __construct(
        private HistorialAccionService $historialAccionService,
        private KardexProductoService $kardex_producto_service,
        private ProductoService $productoService,
    ) {}

    public function listado(): Collection
    {
        $salida_productos = SalidaProducto::with(["sucursal"])->select("salida_productos.*")->where("status", 1)->get();
        return $salida_productos;
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
        $salida_productos = SalidaProducto::with(["producto:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value) && trim($value) != '') {
                $salida_productos->where("salida_productos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $salida_productos->whereBetween("salida_productos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $salida_productos->where(function ($query) use ($search, $columnsSerachLike) {
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
                $salida_productos->orderBy($value[0], $value[1]);
            }
        }

        $salida_productos = $salida_productos->paginate($length, ['*'], 'page', $page);
        return $salida_productos;
    }


    /**
     * Crear salida_producto
     *
     * @param array $datos
     * @return SalidaProducto
     */
    public function crear(array $datos): SalidaProducto
    {
        $producto = Producto::findOrFail($datos["producto_id"]);

        // verificar stock
        $verificacion = $this->productoService->verificaStockCantidad($producto->id, (float)$datos["cantidad"]);
        if (!$verificacion[0]) {
            throw new Exception("La cantidad ingresada " . $datos["cantidad"] . " no puede ser superior al stock actual de " . $verificacion[1]);
        }

        $salida_producto = SalidaProducto::create([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_registro" => date("Y-m-d"),
        ]);

        // registrar kardex
        $producto = Producto::findOrFail($datos["producto_id"]);
        $this->kardex_producto_service->registroEgreso("SALIDA DE PRODUCTO", $producto, (float)$salida_producto->cantidad, (float)$producto->precio, $salida_producto->descripcion ?? '', "SalidaProducto", $salida_producto->id);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA SALIDA DE PRODUCTOS", $salida_producto, null);

        return $salida_producto;
    }

    /**
     * Actualizar salida_producto
     *
     * @param array $datos
     * @param SalidaProducto $salida_producto
     * @return SalidaProducto
     */
    public function actualizar(array $datos, SalidaProducto $salida_producto): SalidaProducto
    {
        $old_salida_producto = clone $salida_producto;

        $salida_producto->update([
            "producto_id" => $datos["producto_id"],
            "cantidad" => $datos["cantidad"],
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);

        // SI LA CANTIDAD O EL PRODUCTO ES DIFERENTE
        if ($old_salida_producto->cantidad != $salida_producto->cantidad || $old_salida_producto->producto_id != $salida_producto->producto_id) {
            // kardex
            $old_producto = Producto::findOrFail($old_salida_producto->producto_id);
            // ingreso
            $this->kardex_producto_service->registroIngreso("SALIDA DE PRODUCTO", $old_producto, $old_salida_producto->cantidad, $old_producto->precio, "POR MODIFICACIÓN DE SALIDA DE PRODUCTO", "SalidaProducto", $old_salida_producto->id);

            // egreso
            $producto = Producto::findOrFail($datos["producto_id"]);
            $this->kardex_producto_service->registroEgreso("SALIDA DE PRODUCTO", $producto, $datos["cantidad"], $producto->precio, $salida_producto->descripcion ?? 'SALIDA DE PRODUCTO', $salida_producto->id);
        }


        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA SALIDA DE PRODUCTOS", $old_salida_producto, $salida_producto);

        return $salida_producto;
    }

    /**
     * Eliminar salida_producto
     *
     * @param SalidaProducto $salida_producto
     * @return boolean
     */
    public function eliminar(SalidaProducto $salida_producto): bool
    {
        $old_salida_producto = clone $salida_producto;

        $old_producto = Producto::findOrFail($old_salida_producto->producto_id);
        // ingreso
        $this->kardex_producto_service->registroIngreso("SALIDA DE PRODUCTO", $old_producto, $old_salida_producto->cantidad, $old_producto->precio, "POR ELIMINACIÓN DE SALIDA DE PRODUCTO", "SalidaProducto", $old_salida_producto->id);

        $salida_producto->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA SALIDA DE PRODUCTOS", $old_salida_producto, $salida_producto);

        return true;
    }
}
