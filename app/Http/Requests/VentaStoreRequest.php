<?php

namespace App\Http\Requests;

use App\Rules\VentaDetalleRule;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class VentaStoreRequest extends FormRequest
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
            "cliente_id" => "required",
            "nit_ci" => "nullable",
            "total" => "required",
            "venta_detalles" => ["required", "array", "min:1", new VentaDetalleRule()]
        ];
    }

    public function messages(): array
    {
        return [
            "cliente_id.required" => "Debes seleccionar un cliente",
            "total.required" => "No se registro el total de la venta",
            "venta_detalles.required" => "Debes agregar al menos un producto",
            "venta_detalles.array" => "Debes agregar una lista de productos",
            "venta_detalles.min" => "Debes agregar al menos un producto ",
        ];
    }
}
