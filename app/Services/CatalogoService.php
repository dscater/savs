<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Catalogo;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class CatalogoService
{
    private $modulo = "CATALOGOS";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $catalogos = Catalogo::select("catalogos.*")->get();
        return $catalogos;
    }
    /**
     * Lista de catalogos paginado con filtros
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
        $catalogos = Catalogo::select("catalogos.*");

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $catalogos->where("catalogos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $catalogos->whereBetween("catalogos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $catalogos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $catalogos->orderBy($value[0], $value[1]);
            }
        }


        $catalogos = $catalogos->paginate($length, ['*'], 'page', $page);
        return $catalogos;
    }

    /**
     * Crear catalogo
     *
     * @param array $datos
     * @return Catalogo
     */
    public function crear(array $datos): Catalogo
    {
        $catalogo = Catalogo::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descargar" => $datos["descargar"]
        ]);

        // cargar imagen
        if ($datos["imagen"] && !is_string($datos["imagen"])) {
            $this->cargarFoto($catalogo, $datos["imagen"]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CATALOGO", $catalogo);

        return $catalogo;
    }


    /**
     * Actualizar catalogo
     *
     * @param array $datos
     * @param Catalogo $catalogo
     * @return Catalogo
     */
    public function actualizar(array $datos, Catalogo $catalogo): Catalogo
    {
        $old_catalogo = clone $catalogo;

        $catalogo->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descargar" => $datos["descargar"]
        ]);

        // cargar imagen
        if ($datos["imagen"] && !is_string($datos["imagen"])) {
            $this->cargarFoto($catalogo, $datos["imagen"]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CATALOGO", $old_catalogo, $catalogo->withoutRelations());

        return $catalogo;
    }

    /**
     * Eliminar catalogo
     *
     * @param Catalogo $catalogo
     * @return boolean
     */
    public function eliminar(Catalogo $catalogo): bool|Exception
    {
        $old_catalogo = clone $catalogo;

        $catalogo->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CATALOGO", $old_catalogo, $catalogo);

        return true;
    }

    /**
     * Cargar imagen
     *
     * @param Catalogo $catalogo
     * @param UploadedFile $imagen
     * @return void
     */
    public function cargarFoto(Catalogo $catalogo, UploadedFile $imagen): void
    {
        if ($catalogo->imagen) {
            \File::delete(public_path("imgs/catalogos/" . $catalogo->imagen));
        }

        $nombre = $catalogo->id . time();
        $catalogo->imagen = $this->cargarArchivoService->cargarArchivo($imagen, public_path("imgs/catalogos"), $nombre);
        $catalogo->save();
    }
}
