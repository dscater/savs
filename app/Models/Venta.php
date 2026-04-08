<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Venta extends Model
{
    use HasFactory;

    protected $fillable = [
        "cliente_id",
        "total",
        "fecha",
        "hora",
    ];

    protected $appends = ["fecha_t"];

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function venta_detalles()
    {
        return $this->hasMany(VentaDetalle::class, 'venta_id');
    }
}
