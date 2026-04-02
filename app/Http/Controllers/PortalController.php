<?php

namespace App\Http\Controllers;

use App\Models\Catalogo;
use App\Models\Pedido;
use App\Models\Producto;
use App\Models\Social;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use PDF;

class PortalController extends Controller
{
    public function index()
    {
        $catalogos = Catalogo::all();
        return inertia("Portal/Inicio", compact("catalogos"));
    }

    public function productos(Catalogo $catalogo, Request $request)
    {
        $page = $request->page ?? 1;
        $page = is_string($page) ? (int)$page : $page;
        $productos = Producto::where("catalogo_id", $catalogo->id)
            ->where("estado", "PÚBLICO")->paginate(1);
        return inertia("Portal/Productos", compact("catalogo", "productos", "page"));
    }

    public function verProducto(Producto $producto)
    {
        $catalogo = $producto->catalogo;
        return inertia("Portal/VerProducto", compact("producto", "catalogo"));
    }

    public function descargar_catalogo(Catalogo $catalogo)
    {
        $productos = Producto::where("catalogo_id", $catalogo->id)
            ->where("estado", "PÚBLICO")->get()->each->append('imagen_b64');;
        $pdf = PDF::loadView('reportes.catalogo', compact('catalogo', 'productos'));
        return $pdf->stream($catalogo->nombre . '.pdf');
    }

    public function miCatalogo()
    {
        return inertia("Portal/MiCatalogo");
    }

    public function crearPedido(Request $request)
    {
        $nuevo_pedido = Pedido::create([
            "ip_cliente" => $request->ip(),
            "fecha" => date("Y-m-d"),
            "hora" => date("H:i:s"),
        ]);

        foreach ($request->productos as $producto) {
            $nuevo_pedido->pedido_detalles()->create([
                "producto_id" => $producto["id"],
            ]);
        }

        // crear pdf con DOMPDF
        $pdf = PDF::loadView('reportes.pedido', compact('nuevo_pedido'));
        $pdf_path = public_path("pedidos/pedido_" . $nuevo_pedido->id . ".pdf");
        $pdf->save($pdf_path);
        $nuevo_pedido->pdf = "pedido_" . $nuevo_pedido->id . ".pdf";
        $nuevo_pedido->save();

        $social = Social::first();

        $whatsapp = "https://wa.me/" . $social->whatsapp . "?text=" . urlencode("Hola, me gustaría hacer un pedido. Mi pedido es el siguiente: " . asset("pedidos/pedido_" . $nuevo_pedido->id . ".pdf"));

        return response()->JSON([
            "message" => "Pedido creado exitosamente",
            "pedido_id" => $nuevo_pedido->id,
            "whatsapp" => $whatsapp
        ]);
    }
}
