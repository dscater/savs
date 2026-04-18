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

    protected $appends = ["fecha_t", "url", "icon", "hace"];

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function getHaceAttribute()
    {
        return $this->created_at->diffForHumans();
    }

    public function getUrlAttribute()
    {
        if ($this->tipo == 'COMPROBANTE') {
            return route('participantes.show', $this->registro_id);
        }

        if ($this->tipo == 'STOCK') {
            return route('productos.verProducto', $this->registro_id);
        }

        return route('notificacions.show', $this->id);
    }

    public function getIconAttribute()
    {
        if ($this->tipo == 'COMPROBANTE') {
            return 'fa fa-file-image';
        }

        if ($this->tipo == 'STOCK') {
            return 'fa fa-box';
        }

        return 'fa fa-envelope';
    }
}
