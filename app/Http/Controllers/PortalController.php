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

    public function subastas()
    {
        return inertia("Portal/Subastas");
    }

    public function subasta(Subasta $subasta)
    {
        $subasta = $subasta->load(["producto.producto_imagens", "participantes_puja"]);
        return Inertia::render("Portal/Subasta", compact("subasta"));
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
