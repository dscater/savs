<?php

use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\ImagenesPortalController;
use App\Http\Controllers\IngresoProductoController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\PortalController;
use App\Http\Controllers\ProductoController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\SalidaProductoController;
use App\Http\Controllers\SubastaController;
use App\Http\Controllers\TipoUsuarioController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use App\Http\Controllers\VentaController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;


// PORTAL
Route::get('/', [PortalController::class, 'index'])->name("portal.index");

Route::get('/imagenes_portal', [ImagenesPortalController::class, 'index'])->name("portal.imagenes_portal");



// LOGIN
Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("login");

Route::get("configuracions/getConfiguracion", [ConfiguracionController::class, 'getConfiguracion'])->name("configuracions.getConfiguracion");

Route::get('/clear-cache', function () {
    Artisan::call('config:cache');
    Artisan::call('config:clear');
    Artisan::call('optimize');
    return 'Cache eliminado <a href="/">Ir al inicio</a>';
})->name('clear.cache');

// ADMINISTRACION
Route::middleware(['auth', 'permisoUsuario'])->prefix("admin")->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');

    // CONFIGURACION
    Route::resource("configuracions", ConfiguracionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get("getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("permisosUsuario", [UserController::class, 'permisosUsuario']);

    // USUARIOS
    Route::put("usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // TIPO USUARIOS
    Route::get("tipo_usuarios/listado", [TipoUsuarioController::class, 'listado'])->name("tipo_usuarios.listado");

    // CATEGORIAS
    Route::get("categorias/paginado", [CategoriaController::class, 'paginado'])->name("categorias.paginado");
    Route::get("categorias/listado", [CategoriaController::class, 'listado'])->name("categorias.listado");
    Route::resource("categorias", CategoriaController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // CLIENTES
    Route::get("clientes/paginado", [ClienteController::class, 'paginado'])->name("clientes.paginado");
    Route::get("clientes/listado", [ClienteController::class, 'listado'])->name("clientes.listado");
    Route::resource("clientes", ClienteController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // PRODUCTOS
    Route::get("productos/paginado", [ProductoController::class, 'paginado'])->name("productos.paginado");
    Route::get("productos/listado", [ProductoController::class, 'listado'])->name("productos.listado");
    Route::get("productos/byCodigo", [ProductoController::class, 'byCodigo'])->name("productos.byCodigo");
    Route::resource("productos", ProductoController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // INGRESO DE PRODUCTOS
    Route::get("ingreso_productos/paginado", [IngresoProductoController::class, 'paginado'])->name("ingreso_productos.paginado");
    Route::get("ingreso_productos/listado", [IngresoProductoController::class, 'listado'])->name("ingreso_productos.listado");
    Route::resource("ingreso_productos", IngresoProductoController::class)->only(
        ["index", "edit", "store", "show", "update", "destroy"]
    );

    // SALIDA DE PRODUCTOS
    Route::get("salida_productos/paginado", [SalidaProductoController::class, 'paginado'])->name("salida_productos.paginado");
    Route::get("salida_productos/listado", [SalidaProductoController::class, 'listado'])->name("salida_productos.listado");
    Route::resource("salida_productos", SalidaProductoController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // VENTAS
    Route::get("ventas/paginado", [VentaController::class, 'paginado'])->name("ventas.paginado");
    Route::get("ventas/listado", [VentaController::class, 'listado'])->name("ventas.listado");
    Route::patch("ventas/revertirAnulado/{venta}", [VentaController::class, 'revertirAnulado'])->name("ventas.revertirAnulado");
    Route::get("ventas/verVenta/{venta}", [VentaController::class, 'verVenta'])->name("ventas.verVenta");
    Route::get("ventas/imprimir/{venta}", [VentaController::class, 'imprimir'])->name("ventas.imprimir");
    Route::resource("ventas", VentaController::class)->only(
        ["index", "store", "create", "edit", "show", "update", "destroy"]
    );

    // SUBASTAS
    Route::get("subastas/paginado", [SubastaController::class, 'paginado'])->name("subastas.paginado");
    Route::get("subastas/listado", [SubastaController::class, 'listado'])->name("subastas.listado");
    Route::resource("subastas", SubastaController::class)->only(
        ["index", "create", "store", "edit", "show", "update", "destroy"]
    );


    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");

    Route::get('reportes/clientes', [ReporteController::class, 'clientes'])->name("reportes.clientes");
    Route::get('reportes/r_clientes', [ReporteController::class, 'r_clientes'])->name("reportes.r_clientes");

    Route::get('reportes/ventas', [ReporteController::class, 'ventas'])->name("reportes.ventas");
    Route::get('reportes/r_ventas', [ReporteController::class, 'r_ventas'])->name("reportes.r_ventas");

    Route::get('reportes/kardex_productos', [ReporteController::class, 'kardex_productos'])->name("reportes.kardex_productos");
    Route::get('reportes/r_kardex_productos', [ReporteController::class, 'r_kardex_productos'])->name("reportes.r_kardex_productos");
});
require __DIR__ . '/auth.php';
