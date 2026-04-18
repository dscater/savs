<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RecuperarPassword extends Model
{

    protected $fillable = [
        "cod",
        "user_id",
        "status",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
