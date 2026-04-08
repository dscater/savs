<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class IngresoProductoUpdateRequest extends FormRequest
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
            "cantidad" => "required|numeric|min:1",
            "descripcion" => "nullable",
        ];
    }

    public function messages(): array
    {
        return [
            "producto_id.required" => "Debes completar este campo",
            "cantidad.required" => "Debes completar este campo",
            "cantidad.numeric" => "Debes ingresar un valor númerico",
            "cantidad.min" => "Debes ingresar como mínimo :min",
        ];
    }
}
