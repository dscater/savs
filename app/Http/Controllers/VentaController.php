<?php

namespace App\Http\Controllers;

use App\Http\Requests\VentaStoreRequest;
use App\Http\Requests\VentaUpdateRequest;
use App\Models\Venta;
use App\Services\VentaService;
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
use PDF;

class VentaController extends Controller
{
    public function __construct(private VentaService $ventaService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Ventas/Index");
    }

    /**
     * Listado de ventas sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "ventas" => $this->ventaService->listado()
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

        $ventas = $this->ventaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $ventas->items(),
            "total" => $ventas->total(),
            "lastPage" => $ventas->lastPage()
        ]);
    }

    public function create()
    {
        return Inertia::render("Admin/Ventas/Create");
    }

    /**
     * Registrar un nuevo venta
     *
     * @param VentaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(VentaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Venta
            $this->ventaService->crear($request->validated());
            DB::commit();
            return redirect()->route("ventas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Imprimir un venta
     *
     * @param Venta $venta
     */
    public function imprimir(Venta $venta)
    {
        $nro_venta = $venta->id;
        if ($nro_venta < 10) {
            $nro_venta = "00000" . $nro_venta;
        } elseif ($nro_venta < 100) {
            $nro_venta = "0000" . $nro_venta;
        } elseif ($nro_venta < 1000) {
            $nro_venta = "000" . $nro_venta;
        } elseif ($nro_venta < 10000) {
            $nro_venta = "00" . $nro_venta;
        } elseif ($nro_venta < 100000) {
            $nro_venta = "0" . $nro_venta;
        }

        $pdf = PDF::loadView('reportes.recibo', compact('venta', 'nro_venta'))->setPaper('letter', 'portrait');
        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));
        return $pdf->stream('usuarios.pdf');
    }

    /**
     * Mostrar un venta
     *
     * @param Venta $venta
     * @return ResponseInertia
     */
    public function verVenta(Venta $venta): ResponseInertia
    {
        $venta = $venta->load(["cliente", "venta_detalles.producto", "user"]);
        return Inertia::render("Admin/Ventas/Show", compact("venta"));
    }

    /**
     * Mostrar un venta
     *
     * @param Venta $venta
     * @return JsonResponse
     */
    public function show(Venta $venta): JsonResponse
    {
        return response()->JSON($venta->load(["venta_detalles.producto"]));
    }

    public function edit(Venta $venta)
    {
        $venta = $venta->load(["venta_detalles.producto"]);
        return Inertia::render("Admin/Ventas/Edit", compact("venta"));
    }

    public function update(Venta $venta, VentaUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar venta
            $this->ventaService->actualizar($request->validated(), $venta);
            DB::commit();
            return redirect()->route("ventas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar venta
     *
     * @param Venta $venta
     * @return JsonResponse|Response
     */
    public function destroy(Venta $venta): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->ventaService->eliminar($venta);
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

    /**
     * Revertir Anulado
     *
     * @param Venta $venta
     * @return JsonResponse|Response
     */
    public function revertirAnulado(Venta $venta): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->ventaService->revertirAnulado($venta);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se actualizó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
