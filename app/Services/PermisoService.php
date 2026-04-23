<?php

namespace App\Services;

use App\Models\Permiso;
use App\Models\Role;
use Illuminate\Support\Facades\Auth;

class PermisoService
{
    protected $arrayPermisos = [
        "ADMINISTRADOR" => [
            "usuarios.paginado",
            "usuarios.index",
            "usuarios.listado",
            "usuarios.create",
            "usuarios.store",
            "usuarios.edit",
            "usuarios.show",
            "usuarios.update",
            "usuarios.destroy",
            "usuarios.password",

            "tipo_usuarios.listado",

            "categorias.paginado",
            "categorias.index",
            "categorias.listado",
            "categorias.create",
            "categorias.store",
            "categorias.edit",
            "categorias.show",
            "categorias.update",
            "categorias.destroy",

            "clientes.paginado",
            "clientes.index",
            "clientes.listado",
            "clientes.create",
            "clientes.store",
            "clientes.edit",
            "clientes.show",
            "clientes.update",
            "clientes.destroy",

            "productos.paginado",
            "productos.index",
            "productos.listado",
            "productos.byCodigo",
            "productos.create",
            "productos.store",
            "productos.edit",
            "productos.show",
            "productos.verProducto",
            "productos.update",
            "productos.destroy",

            "ingreso_productos.paginado",
            "ingreso_productos.index",
            "ingreso_productos.listado",
            "ingreso_productos.create",
            "ingreso_productos.store",
            "ingreso_productos.edit",
            "ingreso_productos.show",
            "ingreso_productos.update",
            "ingreso_productos.destroy",

            "salida_productos.paginado",
            "salida_productos.index",
            "salida_productos.listado",
            "salida_productos.create",
            "salida_productos.store",
            "salida_productos.edit",
            "salida_productos.show",
            "salida_productos.update",
            "salida_productos.destroy",

            "ventas.paginado",
            "ventas.index",
            "ventas.listado",
            "ventas.create",
            "ventas.store",
            "ventas.edit",
            "ventas.show",
            "ventas.verVenta",
            "ventas.imprimir",
            "ventas.update",
            "ventas.destroy",
            "ventas.revertirAnulado",

            "subastas.paginado",
            "subastas.index",
            "subastas.listado",
            "subastas.create",
            "subastas.store",
            "subastas.edit",
            "subastas.show",
            "subastas.update",
            "subastas.destroy",
            "subastas.participantes",
            "subastas.infoSubastaPorPublicacion",
            "subastas.participantes",
            "subastas.getParticipantesApi",
            "subastas.devolucions",

            "subastas.rechazar_comprobante",
            "subastas.aprobar_comprobante",

            "participantes.historialOfertas",
            "participantes.verificaSubastaCliente",
            "participantes.show",
            "participantes.getInfo",
            "participantes.update",
            "participantes.registrarDevolucion",

            "notificacion_users.index",
            "notificacion_users.paginado",
            "notificacion_users.getNotificacions",

            "configuracions.index",
            "configuracions.create",
            "configuracions.edit",
            "configuracions.update",
            "configuracions.destroy",

            "parametrizacions.index",
            "inicio.getParcialDatosPago",
            "parametrizacion.edit",
            "parametrizacions.getParametrizacion",
            "parametrizacions.update",

            "ventasLinea",
            "pujasLinea",
            "ingresosVentasSubastas",
            "ingresosCategorias",

            "reportes.usuarios",
            "reportes.r_usuarios",
            "reportes.clientes",
            "reportes.r_clientes",
            "reportes.ventas",
            "reportes.r_ventas",
            "reportes.stock_productos",
            "reportes.r_stock_productos",
            "reportes.kardex_productos",
            "reportes.r_kardex_productos",
            "reportes.ingreso_productos",
            "reportes.r_ingreso_productos",
            "reportes.salida_productos",
            "reportes.r_salida_productos",
            "reportes.participantes",
            "reportes.r_participantes",
            "reportes.subastas",
            "reportes.r_subastas",

        ],
        "AUXILIAR" => [],
        "PARTICIPANTE" => [
            "inicio.getParcialDatosPago",

            "subastas.infoSubastaPorPublicacion",
            "subastas.registrarPuja",
            "subastas.registrarComprobante",

            "participantes.historialOfertas",
            "participantes.verificaParticipante",
            "participantes.show",
            "participantes.getInfo",
            "participantes.update",
            "participantes.registrarDevolucion",

        ],
    ];


    public function getTiposUsuarios()
    {
        return array_keys($this->arrayPermisos);
    }

    /**
     * Obtener permisos de usuario logeado
     *
     * @return array
     */
    public function getPermisosUser(): array|string
    {
        $user = Auth::user();
        $permisos = [];
        if ($user) {
            return $this->arrayPermisos[$user->tipo];
        }

        return $permisos;
    }
}
