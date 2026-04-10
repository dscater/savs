<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Participante extends Model
{
    use HasFactory;

    protected $fillable = [
        "subasta_id",
        "user_id",
        "estado",
        "fecha",
        "hora",
        "monto_puja",
    ];
}
