<?php

namespace App\Http\Requests;

use App\Models\Parametrizacion;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class ParametrizacionUpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $parametrizacion = Parametrizacion::first();

        $rules = [
            "tiempo_pub" => "required|int|min:1",
            "terminos_condiciones" => "required|string|min:4",
            "verificar_comprobante" => "required|string|min:4",
            "comp_rechazado" => "required|string|min:4",
            "host" => "required",
            "puerto" => "required|int",
            "encriptado" => "required",
            "correo" => "required|email",
            "nombre" => "required",
            "password" => "required",
            "driver" => "required",
            "titular" => "required",
            "banco" => "required",
            "nro_cuenta" => "required",
        ];

        if (!$parametrizacion) {
            $rules["qr"] = "required|image|mimes:jpeg,jpg,png,web,svg|max:4096";
        }

        return $rules;
    }

    public function messages()
    {
        return [
            "servidor_correo.required" => "Este campo es obligatorio",
            "tiempo_pub.required" => "Este campo es obligatorio",
            "tiempo_pub.int" => "Debes ingresar un valor entero",
            "tiempo_pub.min" => "Debes ingresar al menos :min",
            "terminos_condiciones.required" => "Este campo es obligatorio",
            "terminos_condiciones.string" => "Debes ingresar solo texto",
            "terminos_condiciones.min" => "Debes ingresar al menos :min caracteres",
            "verificar_comprobante.required" => "Este campo es obligatorio",
            "verificar_comprobante.string" => "Debes ingresar solo texto",
            "verificar_comprobante.min" => "Debes ingresar al menos :min caracteres",
            "comp_rechazado.required" => "Este campo es obligatorio",
            "comp_rechazado.string" => "Debes ingresar solo texto",
            "comp_rechazado.min" => "Debes ingresar al menos :min caracteres",
            "host.required" => "Este campo es obligatorio",
            "puerto.required" => "Este campo es obligatorio",
            "puerto.int" => "Ingresa un valor entero",
            "encriptado.required" => "Este campo es obligatorio",
            "correo.required" => "Este campo es obligatorio",
            "correo.email" => "Debes ingresar un correo valido",
            "nombre.required" => "Este campo es obligatorio",
            "password.required" => "Este campo es obligatorio",
            "driver.required" => "Este campo es obligatorio",
            "titular.required" => "Este campo es obligatorio",
            "banco.required" => "Este campo es obligatorio",
            "nro_cuenta.required" => "Este campo es obligatorio",
        ];
    }
}
