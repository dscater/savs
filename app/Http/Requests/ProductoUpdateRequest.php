<?php

namespace App\Http\Requests;

use App\Rules\HtmlNotEmpty;
use App\Rules\ProductoImagenRule;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class ProductoUpdateRequest extends FormRequest
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
            "nombre" => "required|string|unique:productos,nombre," . $this->producto->id,
            "descripcion" => ["required", new HtmlNotEmpty],
            "precio" => "required|numeric|decimal:0,2|min:0",
            "categoria_id" => "required",
            "producto_imagens" => ["required", "array", "min:1", new ProductoImagenRule],
            "eliminados_imagens" => "nullable|array"
        ];
    }

    public function messages()
    {
        return [
            "nombre.required" => "Debes completar este campo",
            "nombre.string" => "Debes completar este campo",
            "descripcion.required" => "Debes completar este campo",
            "precio.required" => "Debes completar este campo",
            "precio.numeric" => "Debes ingresar un valor númerico",
            "precio.decimal" => "Debes ingresar un valor con hasta 2 decimales",
            "precio.min" => "Debes ingresar como mínimo :min",
            "categoria_id.required" => "Debes completar este campo",
            "producto_imagens.required" => "Debes completar este campo",
            "producto_imagens.array" => "Debes enviar una lista de imagenes",
            "producto_imagens.min" => "Debes agregar al menos :min imagen",
        ];
    }
}
