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
                // 'html' => '
                // <div class="w-100 text-center">
                // <h1 class="h1">Autopartes Rudje Kaizen Group</h1>
                // <p class="text-lg">Todo lo que necesitas en un solo lugar</p></div>'
            ],
            [
                "tipo" => "img",
                "url_imagen" => asset("imgs/portal/2.jpg")
            ],
            [
                "tipo" => "img",
                "url_imagen" => asset("imgs/portal/3.jpg")
            ]
        ];
    }

    public function prueba360()
    {
        return [
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car0.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car1.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car2.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car3.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car4.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car5.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car6.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car7.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car8.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car9.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car10.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car11.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car12.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car13.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car14.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car15.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car16.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car17.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car18.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car19.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car20.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car21.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car22.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car23.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car24.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car25.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car26.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car27.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car28.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car29.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car30.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car31.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car32.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car33.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car34.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car35.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car36.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car37.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car38.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car39.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car40.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car41.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car42.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car43.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car44.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car45.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car46.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car47.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car48.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car49.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car50.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car51.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car52.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car53.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car54.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car55.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car56.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car57.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car58.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car59.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car60.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car61.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car62.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car63.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car64.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car65.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car66.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car67.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car68.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car69.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car70.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car71.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car72.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car73.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car74.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car75.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car76.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car77.jpg")],
            ["url_imagen" => asset("imgs/360/car1/360-degree-view-of-car78.jpg")],
        ];
    }
}
