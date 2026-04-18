<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\Parametrizacion;
use App\Models\Participante;
use App\Models\ParticipantePuja;
use App\Models\Venta;
use App\Models\VentaDetalle;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class InicioController extends Controller
{

    public function verificaLogin()
    {
        $sw = false;
        if (Auth::check()) {
            $sw = true;
        }

        return response()->JSON(["sw" => $sw]);
    }

    public function inicio()
    {
        $array_infos = UserController::getInfoBoxUser();

        return Inertia::render('Admin/Home', compact('array_infos'));
    }

    public function login()
    {
        return Inertia::render("Auth/Login");
    }

    public function getParcialDatosPago()
    {
        $parametrizacion = Parametrizacion::first();
        $html = view("parcials.datos_pago", compact("parametrizacion"))->render();

        return response()->JSON($html);
    }

    public function ventasLinea(Request $request)
    {
        $tipo =  $request->tipo;

        $recorrido = [];

        if ($tipo == 'semanal') {
            $fecha = Carbon::now("America/La_Paz");

            for ($i = 6; $i >= 0; $i--) {
                $recorrido[] = $fecha->copy()->subDays($i)->format("Y-m-d");
            }
        }
        if ($tipo == 'meses') {
            $fecha = Carbon::now("America/La_Paz");
            $mes_actual = $fecha->month;

            for ($i = 1; $i <= $mes_actual; $i++) {
                $recorrido[] = Carbon::create(null, $i, 1)->format("m");
            }
        }
        if ($tipo == 'gestion') {
            $recorrido = Venta::selectRaw("EXTRACT(YEAR FROM fecha)::int as gestion")
                ->where("status", 1)
                ->groupByRaw("EXTRACT(YEAR FROM fecha)")
                ->orderByRaw("EXTRACT(YEAR FROM fecha)")
                ->pluck("gestion")
                ->toArray();
        }

        $data = [];

        $categories = [];
        $array_meses = [
            "01" => "Enero",
            "02" => "Febrero",
            "03" => "Marzo",
            "04" => "Abril",
            "05" => "Mayo",
            "06" => "Junio",
            "07" => "Julio",
            "08" => "Agosto",
            "09" => "Septiembre",
            "10" => "Octubre",
            "11" => "Noviembre",
            "12" => "Diciembre",
        ];
        $total_final = 0;
        foreach ($recorrido as $item) {
            if ($tipo == 'semanal') {
                $total = Venta::whereDate('fecha', $item)
                    ->where("status", 1);
                $total = $total->count();
                $categories[] = date("d/m/Y", strtotime($item));
            }

            if ($tipo == 'meses') {
                $total = Venta::whereMonth('fecha', $item)
                    ->whereYear('fecha', Carbon::now()->year)
                    ->where("status", 1);
                $total = $total->count();
                $categories[] = $array_meses[$item];
            }

            if ($tipo == 'gestion') {
                $total = Venta::whereYear('fecha', $item)
                    ->where("status", 1);
                $total = $total->count();
                $categories[] = $item;
            }
            $total_final += (float)$total;
            $data[] = (float)$total;
        }

        return response()->JSON([
            "categories" => $categories,
            "data" => $data,
            "total_final" => $total_final
        ]);
    }

    public function pujasLinea(Request $request)
    {
        $tipo =  $request->tipo;

        $recorrido = [];

        if ($tipo == 'semanal') {
            $fecha = Carbon::now("America/La_Paz");

            for ($i = 6; $i >= 0; $i--) {
                $recorrido[] = $fecha->copy()->subDays($i)->format("Y-m-d");
            }
        }
        if ($tipo == 'meses') {
            $fecha = Carbon::now("America/La_Paz");
            $mes_actual = $fecha->month;

            for ($i = 1; $i <= $mes_actual; $i++) {
                $recorrido[] = Carbon::create(null, $i, 1)->format("m");
            }
        }
        if ($tipo == 'gestion') {
            $recorrido = ParticipantePuja::selectRaw("EXTRACT(YEAR FROM fecha)::int as gestion")
                ->groupByRaw("EXTRACT(YEAR FROM fecha)")
                ->orderByRaw("EXTRACT(YEAR FROM fecha)")
                ->pluck("gestion")
                ->toArray();
        }

        $data = [];

        $categories = [];
        $array_meses = [
            "01" => "Enero",
            "02" => "Febrero",
            "03" => "Marzo",
            "04" => "Abril",
            "05" => "Mayo",
            "06" => "Junio",
            "07" => "Julio",
            "08" => "Agosto",
            "09" => "Septiembre",
            "10" => "Octubre",
            "11" => "Noviembre",
            "12" => "Diciembre",
        ];
        $total_final = 0;
        foreach ($recorrido as $item) {
            if ($tipo == 'semanal') {
                $total = ParticipantePuja::whereDate('fecha', $item);
                $total = $total->count();
                $categories[] = date("d/m/Y", strtotime($item));
            }

            if ($tipo == 'meses') {
                $total = ParticipantePuja::whereMonth('fecha', $item)
                    ->whereYear('fecha', Carbon::now()->year);
                $total = $total->count();
                $categories[] = $array_meses[$item];
            }

            if ($tipo == 'gestion') {
                $total = ParticipantePuja::whereYear('fecha', $item);
                $total = $total->count();
                $categories[] = $item;
            }

            $total_final += (float)$total;
            $data[] = (float)$total;
        }

        return response()->JSON([
            "categories" => $categories,
            "data" => $data,
            "total_final" => $total_final
        ]);
    }

    public function ingresosVentasSubastas()
    {
        $ventas = Venta::where("status", 1)
            ->sum("total");

        $subastas = Participante::where("estado", 2)
            ->sum("monto_puja");
        $data = [
            ["name" => "VENTAS", "y" => (float)$ventas],
            ["name" => "SUBASTAS", "y" => (float)$subastas],
        ];

        $total_final = (float)$ventas + (float)$subastas;

        return response()->JSON([
            "data" => $data,
            "total_final" => $total_final
        ]);
    }

    public function ingresosCategorias()
    {
        $categorias = Categoria::all();
        $data = [];
        $total_final = 0;
        foreach ($categorias as $categoria) {
            $ventas = VentaDetalle::whereHas("venta", function ($q) {
                $q->where("status", 1);
            })
                ->whereHas("producto", function ($q) use ($categoria) {
                    $q->where("categoria_id", $categoria->id);
                })
                ->sum("subtotal");
            $subastas = Participante::where("estado", 2)
                ->whereHas("subasta", function ($q) use ($categoria) {
                    $q->whereHas("producto", function ($subq) use ($categoria) {
                        $subq->where("categoria_id", $categoria->id);
                    });
                })
                ->sum("monto_puja");
            $total_categoria = (float)$ventas + (float)$subastas;
            $total_final += (float)$total_categoria;
            $data[] = ["name" => $categoria->nombre, "y" => (float)$total_categoria];
        }


        return response()->JSON([
            "data" => $data,
            "total_final" => $total_final
        ]);
    }
}
