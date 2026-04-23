<?php

namespace App\Services;

use App\Models\Producto;
use App\Models\ProductoImagen;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class ProductoImagenService
{
    private $modulo = "PRODUCTOS IMAGENES";

    public function __construct(private  CargarArchivoService $cargarArchivoService) {}

    /**
     * Cargar imagenes
     *
     * @param Producto $producto
     * @param Array $files
     * @return void
     */
    public function cargarImagenes(Producto $producto, array $files, array $eliminados = []): void
    {
        Log::debug($files);
        foreach ($files as $key => $file) {
            $imagen = $file["file"];
            if ($imagen instanceof UploadedFile) {
                $producto_imagen = ProductoImagen::create([
                    "producto_id" => $producto->id,
                    // "imagen" => "default.jpg"
                ]);
                $this->subirImagen($producto_imagen, $imagen, $key);
            }
        }

        if (isset($eliminados) && is_array($eliminados) && count($eliminados) > 0) {
            foreach ($eliminados as $e) {
                $producto_imagen = ProductoImagen::find($e);
                if ($producto_imagen && $producto_imagen->imagen) {
                    $this->eliminar($producto_imagen->imagen);
                }
                $producto_imagen->delete();
            }
        }
    }

    /**
     * Subir imagen
     *
     * @param ProductoImagen $producto_imagen
     * @param UploadedFile $imagen
     * @return void
     */
    public function subirImagen(ProductoImagen $producto_imagen, UploadedFile $imagen, $key = null): void
    {
        if ($producto_imagen->imagen && $producto_imagen->imagen != "default.jpg") {
            \File::delete(public_path("imgs/productos/" . $producto_imagen->imagen));
        }

        $nombre = ($key ? $key : '') . $producto_imagen->id . time();
        $producto_imagen->imagen = $this->cargarArchivoService->cargarArchivo($imagen, public_path("imgs/productos"), $nombre);
        $producto_imagen->save();
    }

    public function eliminar($nombre)
    {
        \File::delete(public_path("imgs/productos/" . $nombre));
    }
}
