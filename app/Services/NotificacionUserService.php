<?php

namespace App\Services;

use App\Models\NotificacionUser;
use App\Models\User;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class NotificacionUserService
{
    public function crearNotificacionUsers($notificacion_id, $tipos)
    {
        $users = User::whereIn("tipo", $tipos)->get();

        foreach ($users as $user) {
            NotificacionUser::create([
                "notificacion_id" => $notificacion_id,
                "user_id" => $user->id,
            ]);
        }
    }
}
