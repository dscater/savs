<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserDato extends Model
{
    protected $fillable = [
        "user_id",
        "email",
        "ci",
        "ci_exp",
        "dpto_residencia",
        "complemento",
        "foto_ci_anverso",
        "foto_ci_reverso",
        "banco",
        "nro_cuenta",
    ];
    protected $appends = ["full_ci", "url_ci_anverso", "url_ci_reverso"];

    public function getUrlCiAnversoAttribute()
    {
        return asset("imgs/users/" . $this->foto_ci_anverso);
    }

    public function getUrlCiReversoAttribute()
    {
        return asset("imgs/users/" . $this->foto_ci_reverso);
    }

    public function getFullCiAttribute()
    {
        return $this->ci . ' ' . $this->complemento . ' ' . $this->ci_exp;
    }


    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
