<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class ClienteStoreRequest extends FormRequest
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
            "nombre" => "required|string",
            "nit_ci" => "nullable|string",
            "cel" => "nullable",
            "correo" => "nullable|email",
        ];
    }

    public function messages(): array
    {
        return [
            "nombre.required" => "Debes completar este campo",
            "nombre.string" => "Debes ingresar un texto valido",
            "nit_ci.string" => "Debes ingresar un texto valido",
            "correo.email" => "Debes ingresar un correo valido",
        ];
    }
}
