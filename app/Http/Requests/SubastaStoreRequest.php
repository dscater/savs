<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class SubastaStoreRequest extends FormRequest
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
        return [
            "producto_id" => "required",
            "estado_producto" => "required",
            "monto_inicial" => "required|numeric|decimal:0,2|min:1",
            "garantia" => "required|numeric|decimal:0,2|min:1",
            "fecha_fin" => "required|date",
            "hora_fin" => "required",
            "publico" => "required",
        ];
    }

    public function messages()
    {
        return [
            "producto_id.required" => "Debes completar este campo",
            "estado_producto.required" => "Debes completar este campo",
            "monto_inicial.required" => "Debes completar este campo",
            "monto_inicial.numeric" => "Debes ingresar un valor númerico",
            "monto_inicial.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",
            "monto_inicial.min" => "Debes ingresar como mínimo :min",
            "garantia.required" => "Debes completar este campo",
            "garantia.numeric" => "Debes ingresar un valor númerico",
            "garantia.decimal" => "Debes ingresar un valor númerico con hasta 2 decimales",
            "garantia.min" => "Debes ingresar como mínimo :min",
            "fecha_fin.required" => "Debes completar este campo",
            "fecha_fin.date" => "Debes ingresar una fecha valida",
            "hora_fin.required" => "Debes completar este campo",
            "hora_fin.date_format" => "Debes ingresar una hora valida",
            "publico.required" => "Debes completar este campo",
        ];
    }
}
