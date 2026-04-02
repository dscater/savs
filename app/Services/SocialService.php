<?php

namespace App\Services;

use App\Models\Social;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class SocialService
{
    public function __construct(private CargarArchivoService $cargarArchivoService) {}

    /**
     * Actualizar social
     *
     * @param array $datos
     * @param Social $social
     * @return Social
     */
    public function actualizar(array $datos, Social $social): Social
    {
        $old_social = clone $social;

        $social = Social::first();
        if (!$social) {
            $social = Social::create([
                "whatsapp" => $datos["whatsapp"],
                "facebook" => $datos["facebook"],
                "tiktok" => $datos["tiktok"],
                "instagram" => $datos["instagram"],
                "youtube" => $datos["youtube"],
                "x" => $datos["x"],
                "web" => $datos["web"],
                "correo" => $datos["correo"],
            ]);
        } else {
            $social->update([
                "whatsapp" => $datos["whatsapp"],
                "facebook" => $datos["facebook"],
                "tiktok" => $datos["tiktok"],
                "instagram" => $datos["instagram"],
                "youtube" => $datos["youtube"],
                "x" => $datos["x"],
                "web" => $datos["web"],
                "correo" => $datos["correo"],
            ]);
        }

        return $social;
    }
}
