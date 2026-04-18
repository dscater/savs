<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ImagenesPortalController extends Controller
{
    public function index()
    {
        return [
            [
                "tipo" => "img",
                "url_imagen" => asset("imgs/portal/1.jpg"),
                'html' => '
                <div class="w-100 text-center">
                <h1 class="h1">Autopartes Rudje Kaizen Group</h1>
                <p class="text-lg">Todo lo que necesitas en un solo lugar</p></div>'
            ],
            [
                "tipo" => "img",
                "url_imagen" => asset("imgs/portal/2.png")
            ]
        ];
    }
}
