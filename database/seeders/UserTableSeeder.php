<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            "usuario" => "admin",
            "nombre" => "admin",
            "paterno" => "admin",
            "correo" => "admin@admin.com",
            "password" => "admin",
            "acceso" => 1,
            "fono" => "",
            "tipo" => "ADMINISTRADOR",
            "fecha_registro" => date("Y-m-d"),
            "status" => 1,
        ]);
    }
}
