<?php

namespace App\Http\Controllers;

use App\Mail\MensajeComprobanteMail;
use App\Models\Parametrizacion;
use App\Models\Participante;
use App\Models\Subasta;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class ParticipanteController extends Controller
{
    public function verificaParticipante(Request $request)
    {
        $subasta = Subasta::find($request->publicacion_id);

        $user = User::where("id", $request->user_id)->get()->first();
        $participante = null;
        if ($user && $subasta) {
            $participante = Participante::where("user_id", $user->id)
                ->where("subasta_id", $subasta->id)
                ->get()
                ->first();
            if ($participante) {
                $participante = $participante->load(["participante_pujas"]);
            }
        }

        return response()->JSON([
            "user" => $user,
            "participante" => $participante
        ]);
    }

    public function show(Participante $participante, Request $request)
    {
        $notificacionUserId = $request->input('notificacion_user_id');
        if ($notificacionUserId) {
            $notificacion_user = NotificacionUser::find($notificacionUserId);
            $notificacion_user->visto = 1;
            $notificacion_user->save();
        }

        $participante = $participante->load(["subasta.producto.producto_imagens", "participante_pujas", "user.user_dato"]);
        return Inertia::render("Admin/Subastas/Participante", compact("participante"));
    }

    public function getInfo(Participante $participante)
    {
        return response()->JSON($participante);
    }

    public function update(Participante $participante, Request $request)
    {
        $participante->estado_comprobante = $request->estado_comprobante;
        if ($request->estado_comprobante == 0) {
            $participante->estado = 0;
        }

        $participante->save();
        // enviar mensaje segun el caso
        $parametrizacion = Parametrizacion::first();
        if ($parametrizacion) {
            // enviar correo
            $servidor_correo = $parametrizacion->servidor_correo;
            Config::set(
                [
                    'mail.default' => $servidor_correo["driver"],
                    'mail.mailers.smtp.host' => $servidor_correo["host"],
                    'mail.mailers.smtp.port' => $servidor_correo["puerto"],
                    'mail.mailers.smtp.encryption' => $servidor_correo["encriptado"],
                    'mail.mailers.smtp.username' => $servidor_correo["correo"],
                    'mail.mailers.smtp.password' => $servidor_correo["password"],
                    'mail.from.address' => $servidor_correo["correo"],
                    'mail.from.name' => $servidor_correo["nombre"],
                ]
            );

            $subasta = $participante->subasta;
            $url =  route('portal.subasta', $subasta->id);

            $mensaje = 'Tu comprobante ha sido verificado. Ahora puedes realizar tus ofertas/pujas en esta  <a href="' . $url . '">PUBLICACIÓN</a>';

            if ($participante->estado_comprobante == 2) {
                $mensaje = 'Tu comprobante ha sido rechazado. Por favor verifica que no vea un problema con tu banco o que el monto de garantía sea correcto en la siguiente  <a href="' . $url . '">PUBLICACIÓN</a>';
                if ($parametrizacion->comp_rechazado) {
                    $mensaje = $parametrizacion->comp_rechazado;
                    $mensaje .= '<br/><a href="' . $url . '">Ver publicación</a>';
                }
            }

            $datos = [
                "mensaje" =>  $mensaje,
            ];

            // Log::debug($participante->user->user_dato->email);

            Mail::to($participante->user->user_dato->email)
                ->send(new MensajeComprobanteMail($datos));
        }

        return response()->JSON($participante->load(["subasta.producto.producto_imagens", "participante_pujas"]));
    }

    public function registrarDevolucion(Participante $participante, Request $request)
    {

        $validacion = [
            "fecha_devolucion" => "required|date",
            "hora_devolucion" => "required|date_format:H:i",
        ];
        if ($request->descripcion_devolucion && trim($request->descripcion_devolucion) != '') {
            $validacion["descripcion_devolucion"] = "string|min:2";
        }

        $mensajes = [
            "fecha_devolucion.required" => "Esta campo es obligatorio",
            "fecha_devolucion.date" => "Debes ingresar una fecha valida",
            "hora_devolucion.required" => "Esta campo es obligatorio",
            "hora_devolucion.date_format" => "Debes ingresar una hora valida",
            "descripcion_devolucion.string" => "Debes ingresar texto",
            "descripcion_devolucion.min" => "Debes ingresar al menos :min caracteres",
        ];

        $request->validate($validacion, $mensajes);

        $participante->update([
            "devolucion" => 1,
            "descripcion_devolucion" => (trim($request->descripcion_devolucion) != '' ? mb_strtoupper($request->descripcion_devolucion) : NULL),
            "fecha_devolucion" => (trim($request->fecha_devolucion) != '' ? $request->fecha_devolucion : NULL),
            "hora_devolucion" => (trim($request->hora_devolucion) != '' ? $request->hora_devolucion : NULL),
        ]);
        // enviar mensaje de devolución
        $parametrizacion = Parametrizacion::first();
        if ($parametrizacion) {
            // enviar correo
            $servidor_correo = $parametrizacion->servidor_correo;
            Config::set(
                [
                    'mail.default' => $servidor_correo["driver"],
                    'mail.mailers.smtp.host' => $servidor_correo["host"],
                    'mail.mailers.smtp.port' => $servidor_correo["puerto"],
                    'mail.mailers.smtp.encryption' => $servidor_correo["encriptado"],
                    'mail.mailers.smtp.username' => $servidor_correo["correo"],
                    'mail.mailers.smtp.password' => $servidor_correo["password"],
                    'mail.from.address' => $servidor_correo["correo"],
                    'mail.from.name' => $servidor_correo["nombre"],
                ]
            );

            $subasta = $participante->subasta;
            $url =  route('portal.subasta', $subasta->id);

            $monto = number_format($participante->subasta->garantia, 2, ".", ",");
            $moneda = "Bs.";

            $txt_monto = $moneda . ' ' . $monto;

            $txt_banco = $participante->user->user_dato->nro_cuenta . ' (' . $participante->user->user_dato->banco . ')';

            $mensaje = 'Se acaba de realizar la devolución de <b>' . $txt_monto . '</b>; en tu cuenta ' . $txt_banco . '<br/>Puedes ver la publicación de la cual se realizó la devolución <a href="' . $url . '">aquí</a>';

            $datos = [
                "mensaje" =>  $mensaje,
            ];

            Mail::to($participante->user->user_dato->email)
                ->send(new MensajeComprobanteMail($datos));
        }

        return response()->JSON($participante->load(["user.user_dato", "subasta.producto.producto_imagens", "participante_pujas"]));
    }

    public function historialOfertas(Request $request)
    {
        $subasta_id = $request->publicacion_id;
        $user = Auth::user();
        $cliente = $user->cliente;
        $participante_pujas = [];
        if ($cliente) {
            $subasta = Publicacion::find($subasta_id);
            if ($subasta && $subasta) {
                $subasta = $subasta;
                $participante_pujas = HistorialOferta::where("subasta_id", $subasta->id)
                    ->where("cliente_id", $cliente->id)->orderBy("created_at", "desc")->get();
            }
        }

        return response()->JSON($participante_pujas);
    }
}
