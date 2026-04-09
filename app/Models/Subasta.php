<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subasta extends Model
{
    use HasFactory;

    protected $fillable = [
        "producto_id",
        "estado_producto",
        "monto_inicial",
        "fecha_fin",
        "hora_fin",
        "publico",
        "estado_subasta", // 0: SIN PUBLICAR, 1: PUBLICADO, 2: FINALIZADO
        "fecha_registro",
    ];

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }
}
