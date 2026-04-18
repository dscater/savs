<?php

namespace App\Http\Controllers;


use App\Http\Requests\ProductoStoreRequest;
use App\Http\Requests\ProductoUpdateRequest;
use App\Models\NotificacionUser;
use App\Models\Producto;
use App\Services\ProductoService;
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

class ProductoController extends Controller
{
    public function __construct(private ProductoService $productoService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Productos/Index");
    }

    public function buscar(Request $request)
    {
        $search = $request->input("search", "");
        $productos = [];
        if ($search) {
            $productos = Producto::where("nombre", "like", "%$search%")
                ->get();
        }
        return response()->JSON([
            "productos" => $productos
        ]);
    }

    public function portal(Request $request)
    {
        $categoria_id = $request->input("categoria_id", "todos");

        $productos = Producto::with(["producto_imagens"])
            ->select("productos.*");

        if ($categoria_id != 'todos') {
            $productos->where("categoria_id", $categoria_id);
        }


        $productos = $productos->orderBy("created_at", "desc")
            ->paginate(9);

        return response()->JSON([
            "productos" => $productos,
        ]);
    }

    /**
     * Listado de productos sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "productos" => $this->productoService->listado()
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

        $productos = $this->productoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $productos->items(),
            "total" => $productos->total(),
            "lastPage" => $productos->lastPage()
        ]);
    }


    /**
     * Endpoint para obtener la lista de productos paginado para datatable
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function api(Request $request): JsonResponse
    {

        return response()->JSON([]);
    }

    /**
     * Registrar un nuevo producto
     *
     * @param ProductoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(ProductoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Producto
            $this->productoService->crear($request->validated());
            DB::commit();
            return redirect()->route("productos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function verProducto(Producto $producto, Request $request)
    {

        $notificacionUserId = $request->input('notificacion_user_id');
        if ($notificacionUserId) {
            $notificacion_user = NotificacionUser::find($notificacionUserId);
            $notificacion_user->visto = 1;
            $notificacion_user->save();
        }

        $producto = $producto->load(["categoria", "producto_imagens"]);
        return Inertia::render("Admin/Productos/Show", compact("producto"));
    }

    /**
     * Mostrar un producto
     *
     * @param Producto $producto
     * @return JsonResponse
     */
    public function show(Producto $producto): JsonResponse
    {
        return response()->JSON($producto->load(["producto_imagens"]));
    }

    public function byCodigo(Request $request): JsonResponse
    {
        try {
            $codigo = mb_strtoupper($request->codigo);
            $producto = Producto::where("codigo", $codigo)->get()->first();

            if (!$producto) {
                throw new Exception("No hay ningún producto con ese código");
            }

            return response()->JSON($producto->load(["categoria"]));
        } catch (\Exception $e) {
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }


    public function update(Producto $producto, ProductoUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            Log::debug($request->validated());
            // actualizar producto
            $this->productoService->actualizar($request->validated(), $producto);
            DB::commit();
            return redirect()->route("productos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar producto
     *
     * @param Producto $producto
     * @return JsonResponse|Response
     */
    public function destroy(Producto $producto): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->productoService->eliminar($producto);
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
