<?php

namespace App\Services;

use App\Models\Participante;
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

    public function __construct(private HistorialAccionService $historialAccionService, private KardexProductoService $kardex_producto_service) {}

    public function listado($con_subasta = null): Collection
    {
        $subastas = Subasta::select("subastas.*")
            ->with("producto");

        if ($con_subasta) {
            // verificar si existe en Subasta
            $subastas->whereNotIn("estado_subasta", [0, 5, 6]);
            $subastas->orderBy('fecha_fin', "desc");
        }

        $subastas = $subastas->get();
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
        $subastas = Subasta::select("subastas.*")
            ->with(["producto:id,nombre,codigo"]);

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
            "producto_id" => $datos["producto_id"],
            "estado_producto" => $datos["estado_producto"],
            "monto_inicial" => $datos["monto_inicial"],
            "garantia" => $datos["garantia"],
            "fecha_fin" => $datos["fecha_fin"],
            "hora_fin" => $datos["hora_fin"],
            "publico" => $datos["publico"],
            "descripcion" => $datos["descripcion"],
            "fecha_registro" => date("Y-m-d"),
        ]);

        // registrar kardex
        $producto = Producto::findOrFail($datos["producto_id"]);
        $this->kardex_producto_service->registroEgreso("SUBASTA", $producto, 1, (float)$producto->precio,  'EGRESO DE PRODUCTO PARA SUBASTA', "Subasta", $subasta->id);

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

        $usos = Participante::where("subasta_id", $subasta->id)->count();
        if ($usos > 0) {
            throw new Exception("No se puede modificar el registro porque ya hay participantes registrados");
        }

        $subasta->update([
            "producto_id" => $datos["producto_id"],
            "estado_producto" => $datos["estado_producto"],
            "monto_inicial" => $datos["monto_inicial"],
            "garantia" => $datos["garantia"],
            "fecha_fin" => $datos["fecha_fin"],
            "hora_fin" => $datos["hora_fin"],
            "descripcion" => $datos["descripcion"],
            "publico" => $datos["publico"],
        ]);

        // SI EL PRODUCTO ES DIFERENTE
        if ($old_subasta->producto_id != $subasta->producto_id) {
            // kardex
            $old_producto = Producto::findOrFail($old_subasta->producto_id);
            // ingreso
            $this->kardex_producto_service->registroIngreso("SUBASTA", $old_producto, 1, $old_producto->precio, "INGRESO POR MODIFICACIÓN DE SUBASTA", "Subasta", $old_subasta->id);

            // egreso
            $producto = Producto::findOrFail($datos["producto_id"]);
            $this->kardex_producto_service->registroEgreso("SUBASTA", $producto, 1, $producto->precio, 'EGRESO DE PRODUCTO PARA SUBASTA', "Subasta", $subasta->id);
        }

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

        $usos = Participante::where("subasta_id", $subasta->id)->count();
        if ($usos > 0) {
            throw new Exception("No se puede eliminar este registro porque existen participantes registrados");
        }

        $old_producto = Producto::findOrFail($old_subasta->producto_id);
        // ingreso
        $this->kardex_producto_service->registroIngreso("SUBASTA", $old_producto, 1, $old_producto->precio, "INGRESO POR ELIMINACIÓN DE SUBASTA", "Subasta", $old_subasta->id);


        $subasta->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA SUBASTA", $old_subasta, $subasta);

        return true;
    }

    // FUNCIONES
    public function actualizaPublicacionesEstado()
    {
        $dias_maximo = 8;
        $fecha_mostrar = date("Y-m-d", strtotime("-" . $dias_maximo . " days"));
        $subastas = Subasta::where("fecha_fin", "<=", $fecha_mostrar)
            ->whereIn("estado_subasta", [0, 2])
            ->get();
        foreach ($subastas as $item) {
            $item->estado_sub = 3;
            $item->save();
        }
        return true;
    }

    public static function getNroCorrelativo()
    {
        $nro = 1;
        $ultimo = Publicacion::orderBy("nro", "desc")->get()->first();
        if ($ultimo && $ultimo->nro) {
            $nro = (int)$ultimo->nro + 1;
        }

        return $nro;
    }

    function validarFechaHora($fecha, $hora)
    {
        $fechaHoraString = $fecha . ' ' . $hora;

        try {
            $fechaHora = Carbon::parse($fechaHoraString);
        } catch (\Exception $e) {
            // formatos invalidos
            return 1;
        }

        if ($fechaHora->isBefore(Carbon::now())) {
            // fecha menor a la actual
            return 2;
        }

        // sin errores
        return null;
    }

    public function verificaFechaLimitePublicacion($subasta)
    {
        $fecha_hora_fin = date("Y-m-d H:i", strtotime($subasta->fecha_fin . ' ' . $subasta->hora_fin));
        $fecha_hora_actual = date("Y-m-d H:i");

        if ($fecha_hora_actual < $fecha_hora_fin) {
            return true;
        }
        return throw new Exception("No se pudo completar el registro debido a que la fecha y hora de la subasta ya se vencio", 400);
    }
}
