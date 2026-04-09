<?php

namespace App\Http\Controllers;

use App\Models\Catalogo;
use App\Models\Pedido;
use App\Models\Producto;
use App\Models\Social;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use PDF;

class PortalController extends Controller
{
    public function index()
    {
        return inertia("Portal/Inicio");
    }
}
