<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

class Parametrizacion extends Model
{
    protected $fillable = [
        "servidor_correo",
        "datos_banco",
        "tiempo_pub",
        "terminos_condiciones",
        "verificar_comprobante",
        "comp_rechazado",
    ];

    protected $appends = ["url_qr"];


    protected function casts(): array
    {
        return [
            'servidor_correo' => 'json',
            'datos_banco' => 'json',
        ];
    }

    public function getUrlQrAttribute()
    {
        $data = $this->datos_banco;
        return asset("imgs/" . $data["qr"]);
    }
}
