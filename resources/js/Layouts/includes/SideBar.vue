<script setup>
import { onMounted, onUnmounted, ref, nextTick } from "vue";
import { router, usePage, Link } from "@inertiajs/vue3";
import ItemMenu from "@/Components/ItemMenu.vue";
import { useSideBar } from "@/composables/useSidebar.js";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
const { closeSidebar, toggleSubMenuELem } = useSideBar();
const { auth } = usePage().props;
const configuracionStore = useConfiguracionStore();
const appStore = useAppStore();
const usuario = ref(null);
const permisos = ref([]);
const toggleSubMenu = (e) => {
    e.stopPropagation();
    const elem = e.currentTarget;
    if (
        elem.classList.contains("menu-is-opening") &&
        elem.classList.contains("menu-open")
    ) {
        elem.classList.remove("menu-is-opening");
        elem.classList.remove("menu-open");
        toggleSubMenuELem(elem, false);
    } else {
        elem.classList.add("menu-is-opening");
        elem.classList.add("menu-open");
        toggleSubMenuELem(elem, true);
    }
};

const route_current = ref("");
router.on("navigate", (event) => {
    route_current.value = route().current();
    closeSidebar();
});

onMounted(() => {
    configuracionStore.initConfiguracion();
    usuario.value = appStore.getUsuario;
    permisos.value = auth.user.permisos;
    // Selecciona el elemento del widget
    var sidebarSearchElement = $('[data-widget="sidebar-search"]');
    // Configura manualmente el texto de "no encontrado"
    sidebarSearchElement.data("notFoundText", "Sin resultados");
});

const salir = () => {
    Swal.fire({
        icon: "question",
        title: "Cerrar sesión",
        html: `¿Esta seguro(a) de cerrar sesión?`,
        showCancelButton: true,
        confirmButtonText: "Si, salir",
        cancelButtonText: "Cancelar",
        denyButtonText: `Cancelar`,
        customClass: {
            confirmButton: "btn-success",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            axios
                .post(route("logout"))
                .then((response) => {})
                .finally(() => {
                    window.location.href = "/";
                });
        }
    });
};

onUnmounted(() => {});
</script>
<template>
    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-light-primary elevation-1">
        <!-- Brand Logo -->
        <a :href="route('inicio')" class="brand-link">
            <img
                :src="configuracionStore.oConfiguracion.url_logo"
                alt="Logo"
                class="brand-image img-circle elevation-3"
                style="opacity: 0.8"
            />
            <span
                class="brand-text font-weight-light title_Chau_Philomene_One"
                >{{ configuracionStore.oConfiguracion.nombre_sistema }}</span
            >
        </a>

        <!-- Sidebar -->
        <div class="sidebar p-0">
            <!-- Sidebar user panel (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="image">
                    <img
                        :src="usuario?.url_foto"
                        class="img-circle elevation-2"
                        alt="User Image"
                    />
                </div>
                <div class="info">
                    <Link :href="route('profile.edit')" class="d-block">
                        {{ usuario?.usuario }}
                    </Link>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul
                    class="nav nav-pills nav-sidebar flex-column"
                    data-widget="treeview"
                    role="menu"
                    data-accordion="false"
                >
                    <ItemMenu
                        :label="'Inicio'"
                        :ruta="'inicio'"
                        :icon="'fa fa-home'"
                    ></ItemMenu>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos == '*' ||
                            permisos.includes('usuarios.index') ||
                            permisos.includes('ventas.index') ||
                            permisos.includes('productos.index') ||
                            permisos.includes('clientes.index') ||
                            permisos.includes('ingreso_productos.index') ||
                            permisos.includes('salida_productos.index')
                        "
                    >
                        ADMINISTRACIÓN
                    </li>
                    <ItemMenu
                        v-if="
                            permisos == '*' || permisos.includes('ventas.index')
                        "
                        :arrayRutaClassActive="[
                            'ventas.index',
                            'ventas.create',
                            'ventas.edit',
                            'ventas.show',
                            'ventas.verVenta',
                        ]"
                        :label="'Ventas'"
                        :ruta="'ventas.index'"
                        :icon="'fa fa-cash-register'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('clientes.index')
                        "
                        :label="'Clientes'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-user-friends'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('ingreso_productos.index')
                        "
                        :label="'Ingreso de Productos'"
                        :ruta="'ingreso_productos.index'"
                        :icon="'fa fa-arrow-circle-right'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('salida_productos.index')
                        "
                        :label="'Salida de Productos'"
                        :ruta="'salida_productos.index'"
                        :icon="'fa fa-arrow-circle-left'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('productos.index')
                        "
                        :arrayRutaClassActive="[
                            'productos.index',
                            'productos.create',
                            'productos.edit',
                            'productos.show',
                            'productos.verProducto',
                        ]"
                        :label="'Productos'"
                        :ruta="'productos.index'"
                        :icon="'fa fa-box'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('categorias.index')
                        "
                        :label="'Categoría'"
                        :ruta="'categorias.index'"
                        :icon="'fa fa-list'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('usuarios.index')
                        "
                        :label="'Usuarios'"
                        :ruta="'usuarios.index'"
                        :icon="'fa fa-users'"
                    ></ItemMenu>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos == '*' ||
                            permisos.includes('subastas.index')
                        "
                    >
                        PORTAL
                    </li>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('subastas.index')
                        "
                        :array-ruta-class-active="[
                            'subastas.index',
                            'participantes.show',
                            'subastas.participantes',
                        ]"
                        :label="'Subastas'"
                        :ruta="'subastas.index'"
                        :icon="'fa fa-gavel'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('subastas.devolucions')
                        "
                        :label="'Devolución de garantías'"
                        :ruta="'subastas.devolucions'"
                        :icon="'fa fa-clipboard-check'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('parametrizacions.index')
                        "
                        :label="'Parametrización'"
                        :ruta="'parametrizacions.index'"
                        :icon="'fa fa-list'"
                    ></ItemMenu>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.usuarios') ||
                            permisos.includes('reportes.ventas') ||
                            permisos.includes('reportes.clientes') ||
                            permisos.includes('reportes.stock_productos') ||
                            permisos.includes('reportes.kardex_productos') ||
                            permisos.includes('reportes.subastas') ||
                            permisos.includes('reportes.participantes') ||
                            permisos.includes('reportes.ingreso_productos') ||
                            permisos.includes(
                                'reportes.participante_subastas',
                            ) ||
                            permisos.includes('reportes.cliente_compras') ||
                            permisos.includes('reportes.log_users')
                        "
                    >
                        REPORTES
                    </li>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.subastas')
                        "
                        :label="'Lista de Subastas'"
                        :ruta="'reportes.subastas'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.participantes')
                        "
                        :label="'Lista de Participantes por Subasta'"
                        :ruta="'reportes.participantes'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.participante_subastas')
                        "
                        :label="'Historial de Subastas por Participante'"
                        :ruta="'reportes.participante_subastas'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.stock_productos')
                        "
                        :label="'Stock de Productos'"
                        :ruta="'reportes.stock_productos'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.kardex_productos')
                        "
                        :label="'Kardex de Productos'"
                        :ruta="'reportes.kardex_productos'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.ventas')
                        "
                        :label="'Ventas'"
                        :ruta="'reportes.ventas'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.cliente_compras')
                        "
                        :label="'Historial de Compras Clientes'"
                        :ruta="'reportes.cliente_compras'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.ingreso_productos')
                        "
                        :label="'Ingreso de Productos'"
                        :ruta="'reportes.ingreso_productos'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.salida_productos')
                        "
                        :label="'Salida de Productos'"
                        :ruta="'reportes.salida_productos'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.clientes')
                        "
                        :label="'Lista de Clientes'"
                        :ruta="'reportes.clientes'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.log_users')
                        "
                        :label="'Log de Usuarios'"
                        :ruta="'reportes.log_users'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.usuarios')
                        "
                        :label="'Lista de Usuarios'"
                        :ruta="'reportes.usuarios'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <li class="nav-header font-weight-bold">OTROS</li>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('notificacion_users.index')
                        "
                        :label="'Notificaciones'"
                        :ruta="'notificacion_users.index'"
                        :icon="'fa fa-bell'"
                    ></ItemMenu>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('configuracions.index')
                        "
                        :label="'Configuración Sistema'"
                        :ruta="'configuracions.index'"
                        :icon="'fa fa-cog'"
                    ></ItemMenu>
                    <!-- <ItemMenu
                        :label="'Perfil'"
                        :ruta="'profile.edit'"
                        :icon="'fa fa-id-card'"
                    ></ItemMenu> -->
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link"
                            @click.prevent="salir()"
                            ref="link"
                        >
                            <i class="nav-icon fa fa-power-off"></i>
                            <p>Salir</p>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
</template>
<style scoped></style>
