<?php

namespace App\Http\Controllers;

use App\Models\Catalogo;
use App\Models\Parametrizacion;
use App\Models\Pedido;
use App\Models\Producto;
use App\Models\Social;
use App\Models\Subasta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;

class PortalController extends Controller
{
    public function index()
    {
        return inertia("Portal/Inicio");
    }

    public function contacto()
    {
        return Inertia::render("Portal/Contacto");
    }

    public function subastas()
    {
        return inertia("Portal/Subastas");
    }

    public function pedido()
    {
        return inertia("Portal/Pedido");
    }

    public function crearPedido(Request $request)
    {
        $productos_txt  = "";
        $total = 0;
        foreach ($request->productos as $item) {
            $productos_txt .= "\nCódigo de Producto: " . $item["producto"]["codigo"] .
                ", Producto: " . $item["producto"]["nombre"] .
                ", Precio: " . number_format($item["producto"]["precio"], 2, ".", ",") . " Bs." .
                ", Cantidad: " . $item["cantidad"] .
                ", Total: " . number_format($item["subtotal"], 2, ".", ",");

            $total += (float)$item["subtotal"];
        }

        $productos_txt .= "\n\nPedido Total: " . number_format($total, 2, ".", ",") . " Bs.";

        $nro_whatsapp = "+59177710866";
        $mensaje = "Hola, me interesan los siguientes productos:" . $productos_txt;
        $whatsapp = "https://wa.me/" . $nro_whatsapp . "?text=" . urlencode($mensaje);

        return response()->JSON([
            "message" => "Pedido realizado exitosamente",
            "whatsapp" => $whatsapp
        ]);
    }

    public function subasta(Subasta $subasta)
    {
        $subasta = $subasta->load(["producto.producto_imagens", "participantes_puja"]);
        return Inertia::render("Portal/Subasta", compact("subasta"));
    }

    public function producto(Producto $producto)
    {
        $producto = $producto->load(["producto_imagens", "categoria"]);
        return Inertia::render("Portal/Producto", compact("producto"));
    }

    public function mis_subastas()
    {
        return Inertia::render("Portal/MisSubastas");
    }

    public function getTerminosCondiciones()
    {
        // $terminos_condiciones = view("parcials.terminos")->render();
        $terminos_condiciones = "";
        $parametrizacion = Parametrizacion::first();
        if ($parametrizacion) {
            $terminos_condiciones = $parametrizacion->terminos_condiciones;
        }

        return response()->JSON($terminos_condiciones);
    }


    public function getMensajeVerificaComprobante()
    {
        $verificar_comprobante = "";
        $parametrizacion = Parametrizacion::first();
        if ($parametrizacion) {
            $verificar_comprobante = $parametrizacion->verificar_comprobante;
        }

        return response()->JSON($verificar_comprobante);
    }

    public function getMensajesParametrizacion()
    {
        $verificar_comprobante = "";
        $comp_rechazado = "";
        $parametrizacion = Parametrizacion::first();
        if ($parametrizacion) {
            $verificar_comprobante = $parametrizacion->verificar_comprobante;
            $comp_rechazado = $parametrizacion->comp_rechazado;
        }

        return response()->JSON([
            "verificar_comprobante" => $verificar_comprobante,
            "comp_rechazado" => $comp_rechazado,
        ]);
    }
}
