<?php

namespace App\Http\Controllers;

use App\Http\Requests\SubastaStoreRequest;
use App\Http\Requests\SubastaUpdateRequest;
use App\Models\Subasta;
use App\Services\SubastaService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Response;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response as ResponseInertia;

class SubastaController extends Controller
{
    public function __construct(private SubastaService $subastaService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Subastas/Index");
    }

    /**
     * Listado de subastas sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "subastas" => $this->subastaService->listado()
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

        $subastas = $this->subastaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $subastas->items(),
            "total" => $subastas->total(),
            "lastPage" => $subastas->lastPage()
        ]);
    }

    public function create()
    {
        return Inertia::render("Admin/Subastas/Create");
    }

    /**
     * Registrar un nuevo subasta
     *
     * @param SubastaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(SubastaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Subasta
            $this->subastaService->crear($request->validated());
            DB::commit();
            return redirect()->route("subastas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un subasta
     *
     * @param Subasta $subasta
     * @return JsonResponse
     */
    public function show(Subasta $subasta): JsonResponse
    {
        return response()->JSON($subasta);
    }

    public function edit(Subasta $subasta)
    {
        $subasta = $subasta->load(["producto.producto_imagens", "producto.categoria"]);
        return Inertia::render("Admin/Subastas/Edit", compact("subasta"));
    }

    public function update(Subasta $subasta, SubastaUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar subasta
            $this->subastaService->actualizar($request->validated(), $subasta);
            DB::commit();
            return redirect()->route("subastas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar subasta
     *
     * @param Subasta $subasta
     * @return JsonResponse|Response
     */
    public function destroy(Subasta $subasta): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->subastaService->eliminar($subasta);
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
