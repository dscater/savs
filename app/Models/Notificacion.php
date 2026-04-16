<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notificacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "modulo",
        "registro_id",
        "descripcion",
        "fecha",
        "hora",
        "tipo",
    ];
}
