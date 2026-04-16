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
        "garantia",
        "garantia",
        "fecha_fin",
        "hora_fin",
        "publico", // 0: SIN PUBLICAR, 1: PÚBLICO
        "estado_subasta", // 0:FINALIZADO SIN GANADOR , 1: VIGENTE, 2: FINALIZADO CON GANADOR
        "fecha_registro",
    ];
    protected $appends = ["fecha_registro_t", "fecha_fin_t", "fecha_hora_limite", "c_participantes", "esta_vigente"];

    public function getEstaVigenteAttribute()
    {
        return Subasta::verificaFechaLimitePublicacionBoolean($this);
    }


    public static function verificaFechaLimitePublicacionBoolean($publicacion)
    {
        $fecha_hora_fin = date("Y-m-d H:i", strtotime($publicacion->fecha_fin . ' ' . $publicacion->hora_fin));
        $fecha_hora_actual = date("Y-m-d H:i");

        if ($fecha_hora_actual < $fecha_hora_fin) {
            return true;
        }
        return false;
    }

    public function getFechaHoraLimiteAttribute()
    {
        return date("d/m/Y H:i:s", strtotime($this->fecha_fin . ' ' . $this->hora_fin));
    }

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

    public function participantes_puja()
    {
        return $this->hasMany(Participante::class, 'subasta_id')
            ->where("estado_comprobante", 1)
            ->where("monto_puja", ">", 0)
            ->orderBy("monto_puja", "desc")
            ->take(10);
    }
    public function participante_pujas()
    {
        return $this->hasMany(ParticipantePuja::class, 'subasta_id');
    }
}
