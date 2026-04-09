<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Subasta;
use App\Models\Producto;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class SubastaService
{
    private $modulo = "SUBASTAS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $subastas = Subasta::select("subastas.*")->get();
        return $subastas;
    }
    /**
     * Lista de subastas paginado con filtros
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
        $subastas = Subasta::select("subastas.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $subastas->where("subastas.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $subastas->whereBetween("subastas.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $subastas->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $subastas->orderBy($value[0], $value[1]);
            }
        }


        $subastas = $subastas->paginate($length, ['*'], 'page', $page);
        return $subastas;
    }

    /**
     * Crear subasta
     *
     * @param array $datos
     * @return Subasta
     */
    public function crear(array $datos): Subasta
    {
        $subasta = Subasta::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_registro" => date("Y-m-d")
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA SUBASTA", $subasta);

        return $subasta;
    }


    /**
     * Actualizar subasta
     *
     * @param array $datos
     * @param Subasta $subasta
     * @return Subasta
     */
    public function actualizar(array $datos, Subasta $subasta): Subasta
    {
        $old_subasta = clone $subasta;

        $subasta->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"])
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA SUBASTA", $old_subasta, $subasta->withoutRelations());

        return $subasta;
    }

    /**
     * Eliminar subasta
     *
     * @param Subasta $subasta
     * @return boolean
     */
    public function eliminar(Subasta $subasta): bool|Exception
    {
        $old_subasta = clone $subasta;

        $usos = Producto::where("subasta_id", $subasta->id)->count();
        if ($usos > 0) {
            throw new Exception("No se puede eliminar este registro porque esta siendo utilizado");
        }

        $subasta->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA SUBASTA", $old_subasta, $subasta);

        return true;
    }
}
