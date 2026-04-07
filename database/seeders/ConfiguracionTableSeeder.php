<?php

namespace Database\Seeders;

use App\Models\Configuracion;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ConfiguracionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Configuracion::create([
            "nombre_sistema" => "SAVS",
            "alias" => "SAVS",
            "razon_social" => "SAVS S.A.",
            "logo" => "logo.jpg"
        ]);
    }
}
