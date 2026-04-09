<?php

namespace App\Rules;

use App\Models\Producto;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Translation\PotentiallyTranslatedString;

class VentaDetalleRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  Closure(string, ?string=): PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if (empty($value)) {
            $fail("No se encontró ningun producto agregado");
        }
        foreach ($value as $key => $item) {
            // $arrayDetalle = json_decode($item, true);
            $arrayDetalle = $item;
            $producto = Producto::select("nombre")->where("id", $arrayDetalle["producto_id"])->get()->first();
            if (!$producto) {
                $fail("El producto " . ($key + 1) . " no se encuentra en nuestro registros");
            }
            if (trim('' . $arrayDetalle["cantidad"]) == '' || (float)$arrayDetalle["cantidad"] <= 0) {
                $fail("No se ingreso ninguna cantidad del producto $producto->nombre");
            }
            if (trim('' . $arrayDetalle["precio"]) == '' || (float)$arrayDetalle["precio"] < 0) {
                $fail("No se ingreso ningún precio en el producto $producto->nombre");
            }
            if (trim('' . $arrayDetalle["subtotal"]) == '' || (float)$arrayDetalle["subtotal"] < 0) {
                $fail("El subtotal del producto $producto->nombre no puede ser menor a 0");
            }
        }
    }
}
