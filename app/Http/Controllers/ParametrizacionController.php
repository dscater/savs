<?php

namespace App\Http\Controllers;

use App\Http\Requests\ParametrizacionUpdateRequest;
use App\Models\Parametrizacion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class ParametrizacionController extends Controller
{
    public function index()
    {
        $parametrizacion = Parametrizacion::first();
        return Inertia::render("Admin/Parametrizacions/Index", compact("parametrizacion"));
    }


    public function getParametrizacion()
    {
        $parametrizacion = Parametrizacion::first();
        return response()->JSON([
            "parametrizacion" => $parametrizacion
        ], 200);
    }

    public function update(ParametrizacionUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            Log::debug($request);

            $parametrizacion = Parametrizacion::first();
            $servidor_correo = [
                "host" => $request->host,
                "puerto" => $request->puerto,
                "encriptado" => $request->encriptado,
                "correo" => $request->correo,
                "nombre" => $request->nombre,
                "password" => $request->password,
                "driver" => $request->driver,
            ];
            // $servidor_correo = json_encode($servidor_correo);

            if (!$parametrizacion) {
                $datos_banco = [
                    "titular" => $request->titular,
                    "banco" => $request->banco,
                    "nro_cuenta" => $request->nro_cuenta,
                    "qr" => "qr.png",
                ];
            } else {
                $datos_banco = [
                    "titular" => $request->titular,
                    "banco" => $request->banco,
                    "nro_cuenta" => $request->nro_cuenta,
                    "qr" => $parametrizacion->datos_banco["qr"] ?? "qr.jpeg",
                ];
            }
            if (!is_string($request->qr) && $request->hasFile("qr")) {
                $file = $request->qr;
                $nom_qr = time() . '.' . $file->getClientOriginalExtension();
                $datos_banco["qr"] = $nom_qr;
                if ($parametrizacion && $parametrizacion->qr != 'qr.jpeg') {
                    \File::delete(public_path("imgs/" . $parametrizacion->qr));
                }
                $file->move(public_path("imgs/"), $nom_qr);
            }
            // $datos_banco = json_encode($datos_banco);

            $datos = [
                "servidor_correo" => $servidor_correo,
                "datos_banco" => $datos_banco,
                "tiempo_pub" => $request->tiempo_pub,
                "terminos_condiciones" => $request->terminos_condiciones,
                "verificar_comprobante" => $request->verificar_comprobante,
                "comp_rechazado" => $request->comp_rechazado,
            ];
            if (!$parametrizacion) {
                Parametrizacion::create($datos);
            } else {
                $parametrizacion->update($datos);
            }

            DB::commit();
            return redirect()->route("parametrizacions.index")->with("success", "Registro correcto");
        } catch (\Exception $e) {
            Log::debug($e->getMessage());
            DB::rollBack();
            return redirect()->back()->with("error", $e->getMessage());
        }
    }
}
