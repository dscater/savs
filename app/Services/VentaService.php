<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Venta;
use App\Models\Producto;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class VentaService
{
    private $modulo = "VENTAS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $ventas = Venta::select("ventas.*")->get();
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
        $ventas = Venta::select("ventas.*");

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
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_registro" => date("Y-m-d")
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA VENTA", $venta);

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
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"])
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA VENTA", $old_venta, $venta->withoutRelations());

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

        $usos = Producto::where("venta_id", $venta->id)->count();
        if ($usos > 0) {
            throw new Exception("No se puede eliminar este registro porque esta siendo utilizado");
        }

        $venta->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA VENTA", $old_venta, $venta);

        return true;
    }
}
