<?php

namespace App\Http\Controllers;

use App\Http\Requests\SalidaProductoStoreRequest;
use App\Http\Requests\SalidaProductoUpdateRequest;
use App\Models\HistorialAccion;
use App\Models\SalidaProducto;
use App\Models\KardexProducto;
use App\Models\Producto;
use App\Services\HistorialAccionService;
use App\Services\SalidaProductoService;
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

class SalidaProductoController extends Controller
{
    public function __construct(private HistorialAccionService $historialAccionService, private SalidaProductoService $salidaProductoService) {}

    /**
     * Página index
     *
     * @return InertiaResponse
     */
    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/SalidaProductos/Index");
    }

    /**
     * Lista de registros
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "salida_productos" => $this->salidaProductoService->listado()
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = [
            "codigo",
            "modelo",
            "marca",
            "talla",
            "nombre"
        ];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $categorias = $this->salidaProductoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
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
        return Inertia::render("Admin/SalidaProductos/Create");
    }

    /**
     * Registrar un nuevo salida de producto
     *
     * @param ProductoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(SalidaProductoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el SalidaProducto
            $this->salidaProductoService->crear($request->validated());
            DB::commit();
            return redirect()->route("salida_productos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(SalidaProducto $salida_producto) {}


    /**
     * Página edit
     *
     * @return InertiaResponse
     */
    public function edit(SalidaProducto $salida_producto): InertiaResponse
    {
        $salida_producto = $salida_producto->load(["producto"]);
        return Inertia::render("Admin/SalidaProductos/Edit", compact('salida_producto'));
    }

    public function update(SalidaProducto $salida_producto, SalidaProductoUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar el SalidaProducto
            $this->salidaProductoService->actualizar($request->validated(), $salida_producto);

            DB::commit();
            return redirect()->route("salida_productos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
    public function destroy(SalidaProducto $salida_producto)
    {
        DB::beginTransaction();
        try {
            // eliminar SalidaProducto
            $this->salidaProductoService->eliminar($salida_producto);
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
