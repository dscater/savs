<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ParticipantePuja extends Model
{
    use HasFactory;

    protected $fillable  = [
        "user_id",
        "participante_id",
        "subasta_id",
        "monto",
        "fecha",
        "hora",
    ];

    protected $appends = ["fecha_t"];

    public function getFechaAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function participante()
    {
        return $this->belongsTo(Participante::class, 'participante_id');
    }

    public function subasta()
    {
        return $this->belongsTo(Subasta::class, 'subasta_id');
    }
}
