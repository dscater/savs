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
                <h4>What is Lorem Ipsum?</h4>
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry
                </div>'
            ],
            [
                "tipo" => "img",
                "url_imagen" => asset("imgs/portal/2.png")
            ]
        ];
    }
}
