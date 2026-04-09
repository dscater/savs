<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Venta;
use App\Models\Producto;
use App\Models\VentaDetalle;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class VentaService
{
    private $modulo = "VENTAS";

    public function __construct(private HistorialAccionService $historialAccionService, private KardexProductoService $kardex_producto_service) {}

    public function listado(): Collection
    {
        $ventas = Venta::select("ventas.*")
            ->where("status", 1)
            ->get();
        return $ventas;
    }
    /**
     * Lista de ventas paginado con filtros
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
        $ventas = Venta::select("ventas.*")
            ->with(["cliente:id,nombre"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $ventas->where("ventas.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $ventas->whereBetween("ventas.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $ventas->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $ventas->orderBy($value[0], $value[1]);
            }
        }


        $ventas = $ventas->paginate($length, ['*'], 'page', $page);
        return $ventas;
    }

    /**
     * Crear venta
     *
     * @param array $datos
     * @return Venta
     */
    public function crear(array $datos): Venta
    {
        $venta = Venta::create([
            "cliente_id" => $datos["cliente_id"],
            "nit_ci" => $datos["nit_ci"],
            "total" => $datos["total"],
            "fecha" => date("Y-m-d"),
            "hora" => date("H:i:s")
        ]);

        // detalles
        foreach ($datos["venta_detalles"] as $item) {
            $venta_detalle = $venta->venta_detalles()->create([
                "producto_id" => $item["producto_id"],
                "precio" => $item["precio"],
                "cantidad" => $item["cantidad"],
                "subtotal" => $item["subtotal"],
            ]);

            // registrar kardex
            $producto = Producto::findOrFail($item["producto_id"]);
            $this->kardex_producto_service->registroEgreso("VENTAS", $producto, $item["cantidad"], $item["precio"], "VENTA DE PRODUCTO", "VentaDetalle", $venta_detalle->id);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA VENTA", $venta, null, ["venta_detalles"]);

        return $venta;
    }


    /**
     * Actualizar venta
     *
     * @param array $datos
     * @param Venta $venta
     * @return Venta
     */
    public function actualizar(array $datos, Venta $venta): Venta
    {
        $old_venta = clone $venta;

        $venta->update([
            "cliente_id" => $datos["cliente_id"],
            "nit_ci" => $datos["nit_ci"],
            "total" => $datos["total"],
        ]);


        // detalles
        foreach ($datos["venta_detalles"] as $item) {
            if ($item["id"] == 0) {
                $venta_detalle = $venta->venta_detalles()->create([
                    "producto_id" => $item["producto_id"],
                    "precio" => $item["precio"],
                    "cantidad" => $item["cantidad"],
                    "subtotal" => $item["subtotal"],
                ]);

                // registrar kardex
                $producto = Producto::findOrFail($item["producto_id"]);
                $this->kardex_producto_service->registroEgreso("VENTAS", $producto, $item["cantidad"], $item["precio"], "VENTA DE PRODUCTO", "VentaDetalle", $venta_detalle->id);
            } else {
                $venta_detalle = VentaDetalle::findOrFail($item["id"]);
                $cantidad_anterior = $venta_detalle->cantidad;
                $cantidad_nuevo = $item["cantidad"];
                if ($cantidad_anterior != $cantidad_nuevo) {
                    // solo si la cantidad se modifico
                    // ingreso
                    $this->kardex_producto_service->registroIngreso("VENTAS", $venta_detalle->producto, $cantidad_anterior, $venta_detalle->precio, "INGRESO POR MODIFICACIÓN DE CANTIDAD DE VENTA", "VentaDetalle", $venta_detalle->id);

                    $venta_detalle->cantidad = $cantidad_nuevo;
                    $venta_detalle->subtotal = $item["subtotal"];
                    $venta_detalle->save();

                    // egreso nueva cantidad
                    $this->kardex_producto_service->registroEgreso("VENTAS", $venta_detalle->producto, $cantidad_nuevo, $venta_detalle->precio, "EGRESO POR MODIFICACIÓN DE VENTA", "VentaDetalle", $venta_detalle->id);
                }
            }
        }

        // eliminados
        if (isset($datos["detalle_eliminados"])) {
            foreach ($datos["detalle_eliminados"] as $value) {
                $venta_detalle = VentaDetalle::findOrFail($value);
                //kardex ingreso por eliminacion
                $producto = Producto::findOrFail($venta_detalle->producto_id);
                $this->kardex_producto_service->registroIngreso("VENTAS", $producto, $venta_detalle->cantidad, $venta_detalle->precio, "INGRESO POR ELIMINACIÓN DE VENTA", "VentaDetalle", $venta_detalle->id);
            }
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA VENTA", $old_venta, $venta, ["venta_detalles"]);

        return $venta;
    }

    /**
     * Eliminar venta
     *
     * @param Venta $venta
     * @return boolean
     */
    public function eliminar(Venta $venta): bool|Exception
    {
        $old_venta = clone $venta;

        // ingreso kardex
        foreach ($venta->venta_detalles as $venta_detalle) {
            $producto = Producto::findOrFail($venta_detalle->producto_id);
            $this->kardex_producto_service->registroIngreso("VENTAS", $producto, $venta_detalle->cantidad, $venta_detalle->precio, "INGRESO POR ANULACIÓN DE VENTA", "VentaDetalle", $venta_detalle->id);
        }

        $venta->status = 0;
        $venta->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA VENTA", $old_venta, $venta, ["venta_detalles"]);

        return true;
    }
}
