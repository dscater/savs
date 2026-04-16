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
        "estado", //0: PARTICIPANTE, 1:GANADOR PARCIAL, 2:GANADOR FINAL
        "garantia", // 0: NO REGISTRADO, 1: REGISTRADO
        "comprobante",
        "estado_comprobante", // 0:PENDIENTE, 1: VERIFICADO
        "fecha_comprobante",
        "hora_comprobante",
        "devolucion",
        "descripcion_devolucion",
        "fecha_devolucion",
        "hora_devolucion",
        "fecha",
        "hora",
        "monto_puja",
    ];

    protected $appends = ["estado_puja_t", "url_comprobante", "fecha_comprobante_t", "fecha_t", "fecha_devolucion_t", "tipo_comprobante"];

    public function getFechaComprobanteTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_comprobante));
    }

    public function getFechaDevolucionTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_devolucion));
    }

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function getTipoComprobanteAttribute()
    {
        $array_comprobante = explode(".", $this->comprobante);
        $extension = $array_comprobante[1];
        $array_imgs = ["jpg", "jpeg", "webp", "png"];

        if (in_array($extension, $array_imgs)) {
            return "imagen";
        }
        return "file";
    }

    public function getUrlComprobanteAttribute()
    {
        return asset("files/comprobantes/" . $this->comprobante);
    }


    public function getEstadoPujaTAttribute()
    {
        $estado = "PARTICIPANDO";

        if ($this->estado === 1) {
            $estado = 'PARTICIPANDO';
        }

        if ($this->estado === 2) {
            $estado = 'GANADOR';
        }

        if ($this->estado_comprobante === 0) {
            $estado = 'PENDIENTE';
        }

        return $estado;
    }

    public function subasta()
    {
        return $this->belongsTo(Subasta::class, 'subasta_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function participante_pujas()
    {
        return $this->hasMany(ParticipantePuja::class, 'participante_id');
    }
}
