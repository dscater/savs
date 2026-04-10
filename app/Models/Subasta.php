<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subasta extends Model
{
    use HasFactory;

    protected $fillable = [
        "producto_id",
        "estado_producto", //NUEVO, SEMINUEVO, USADO
        "monto_inicial",
        "fecha_fin",
        "hora_fin",
        "publico", // 0: SIN PUBLICAR, 1: PÚBLICO
        "estado_subasta", // 1: VIGENTE, 2: FINALIZADO
        "fecha_registro",
    ];
    protected $appends = ["fecha_registro_t", "fecha_fin_t", "c_participantes"];


    public function getCParticipantesAttribute()
    {
        return $this->participantes->count();
    }

    public function getFechaFinTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_fin));
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }

    public function participantes()
    {
        return $this->hasMany(Participante::class, 'subasta_id');
    }
}
