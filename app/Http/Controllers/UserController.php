<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use App\Models\User;
use App\Models\Venta;
use App\Services\PermisoService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class UserController extends Controller
{

    public function permisosUsuario(Request $request)
    {
        $permisoService = new PermisoService();
        return response()->JSON([
            "permisos" => $permisoService->getPermisosUser()
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()
        ]);
    }

    public static function getInfoBoxUser()
    {
        $permisos = [];
        $array_infos = [];
        if (Auth::check()) {
            $oUser = new User();
            $permisos = $oUser->permisos;
            if ($permisos == '*' || (is_array($permisos) && in_array('usuarios.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'USUARIOS',
                    'cantidad' => User::where('id', '!=', 1)->count(),
                    'color' => 'bg-principal',
                    'icon' => "text-white fa-users",
                    "url" => "usuarios.index"
                ];
            }
            if ($permisos == '*' || (is_array($permisos) && in_array('productos.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'PRODUCTOS',
                    'cantidad' => Producto::count(),
                    'color' => 'bg-principal',
                    'icon' => "text-white fa-box",
                    "url" => "productos.index"
                ];
            }
            if ($permisos == '*' || (is_array($permisos) && in_array('ventas.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'VENTAS',
                    'cantidad' => Venta::where("status", 1)->count(),
                    'color' => 'bg-principal',
                    'icon' => "text-white fa-cash-register",
                    "url" => "ventas.index"
                ];
            }
        }


        return $array_infos;
    }
}
