<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Translation\PotentiallyTranslatedString;
use Illuminate\Http\UploadedFile;

class ProductoImagenRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  Closure(string, ?string=): PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        // Validar que sea un array
        if (!is_array($value)) {
            $fail('Debes ingresar al menos 1 imagen');
            return;
        }
        $extensionesPermitidas = ['jpg', 'jpeg', 'png', 'webp', 'svg'];

        foreach ($value as $index => $item) {
            // Validar estructura básica
            if (!isset($item['file'])) {
                $fail("El campo imagen en la posición " . ($index + 1) . " es requerido.");
                continue;
            }

            $imagen = $item['file'];

            // Si es archivo (nuevo upload)
            if ($imagen instanceof UploadedFile) {
                // Validar tamaño (4MB = 4096 KB)
                if ($imagen->getSize() > 4 * 1024 * 1024) {
                    $fail("El archivo en la posición " . ($index + 1) . " supera los 4MB.");
                }

                // Validar extensión
                $extension = strtolower($imagen->getClientOriginalExtension());

                if (!in_array($extension, $extensionesPermitidas)) {
                    $fail("El archivo en la posición " . ($index + 1) . " tiene un formato inválido. Solo puedes cargar jpg, jpeg, png, webp, svg");
                }
            }
        }
    }
}
