<?php

namespace App\Http\Controllers;

use App\Http\Requests\IngresoProductoStoreRequest;
use App\Http\Requests\IngresoProductoUpdateRequest;
use App\Models\IngresoProducto;
use App\Services\HistorialAccionService;
use App\Services\IngresoProductoService;
use Illuminate\Http\Request;
use Illuminate\Http\Client\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Log;
use Inertia\Response as InertiaResponse;
use Inertia\Inertia;

class IngresoProductoController extends Controller
{
    public function __construct(private HistorialAccionService $historialAccionService, private IngresoProductoService $ingresoProductoService) {}

    /**
     * Página index
     *
     * @return InertiaResponse
     */
    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/IngresoProductos/Index");
    }

    /**
     * Lista de registros
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "ingreso_productos" => $this->ingresoProductoService->listado()
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = [];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $categorias = $this->ingresoProductoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $categorias->items(),
            "total" => $categorias->total(),
            "lastPage" => $categorias->lastPage()
        ]);
    }

    /**
     * Página create
     *
     * @return InertiaResponse
     */
    public function create(): InertiaResponse
    {
        return Inertia::render("Admin/IngresoProductos/Create");
    }

    /**
     * Registrar un nuevo ingreso de producto
     *
     * @param ProductoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(IngresoProductoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el IngresoProducto
            $this->ingresoProductoService->crear($request->validated());
            DB::commit();
            return redirect()->route("ingreso_productos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(IngresoProducto $ingreso_producto)
    {
        $ingreso_producto = $ingreso_producto->load(["ingreso_detalles.producto", "ingreso_detalles.ubicacion_producto", "sucursal"]);
        return Inertia::render("Admin/IngresoProductos/Show", compact("ingreso_producto"));
    }

    /**
     * Página edit
     *
     * @return InertiaResponse
     */
    public function edit(IngresoProducto $ingreso_producto): InertiaResponse
    {
        $ingreso_producto = $ingreso_producto->load(["ingreso_detalles.producto"]);
        return Inertia::render("Admin/IngresoProductos/Edit", compact('ingreso_producto'));
    }

    public function update(IngresoProducto $ingreso_producto, IngresoProductoUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar el IngresoProducto
            $this->ingresoProductoService->actualizar($request->validated(), $ingreso_producto);

            DB::commit();
            return redirect()->route("ingreso_productos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
    public function destroy(IngresoProducto $ingreso_producto)
    {
        DB::beginTransaction();
        try {
            // eliminar IngresoProducto
            $this->ingresoProductoService->eliminar($ingreso_producto);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
