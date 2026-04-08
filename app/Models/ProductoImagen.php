<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductoImagen extends Model
{
    use HasFactory;

    protected $fillable = [
        "producto_id",
        "imagen",
    ];

    protected $appends = ["url_imagen", "url_archivo", "url_file", "file", "name", "ext"];

    public function getExtAttribute()
    {
        return "";
    }

    public function getFileAttribute()
    {
        return $this->imagen;
    }

    public function getNameAttribute()
    {
        return $this->imagen;
    }

    public function getUrlArchivoAttribute()
    {
        return asset("imgs/productos/" . $this->imagen);
    }

    public function getUrlImagenAttribute()
    {
        $imagen = "default.png";
        if ($this->imagen) {
            $imagen = $this->imagen;
        }
        return asset("imgs/productos/" . $imagen);
    }

    public function getUrlFileAttribute()
    {
        $array_imgs = ["jpg", "jpeg", "png", "webp", "gif", "svg"];
        $ext = $this->getExtensionImagenDB($this->imagen);
        if (in_array($ext, $array_imgs)) {
            return asset("/imgs/productos/" . $this->imagen);
        }
        return asset("/imgs/attach.png");
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }

    public function getExtensionImagenDB($imagen)
    {
        $array = explode(".", $imagen);
        return $array[1];
    }
}
