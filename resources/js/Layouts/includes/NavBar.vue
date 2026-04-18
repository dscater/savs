<script setup>
// Composables
import { usePage, Link } from "@inertiajs/vue3";
import { onMounted, onUnmounted, ref } from "vue";
import { useSideBar } from "@/composables/useSidebar.js";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
import axios from "axios";
const configuracionStore = useConfiguracionStore();

const { props } = usePage();
const { toggleSidebar } = useSideBar();

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

const intervalNotifaciones = ref(null);
const listNotificacionUsers = ref([]);
const getNotificacionUsers = () => {
    axios.get(route("notificacion_users.getNotificacions")).then((response) => {
        if (
            response.data.notificacion_users.length !=
            listNotificacionUsers.value.length
        )
            listNotificacionUsers.value = response.data.notificacion_users;
    });
};

onMounted(() => {
    getNotificacionUsers();
    intervalNotifaciones.value = setInterval(() => {
        getNotificacionUsers();
    }, 1500);
});

onUnmounted(() => {});
</script>
<template>
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-dark bg-principal">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a
                    class="nav-link toggleButton"
                    href="#"
                    role="button"
                    @click="toggleSidebar"
                    ><i class="fas fa-bars"></i
                ></a>
            </li>
            <!-- <li class="nav-item d-none d-sm-inline-block">
                <Link :href="route('pagos.create')" class="nav-link">Nuevo Pago</Link>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <Link :href="route('trabajos.create')" class="nav-link">Nuevo Trabajo</Link>
            </li> -->
        </ul>

        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a
                    class="nav-link"
                    data-toggle="dropdown"
                    href="#"
                    aria-expanded="true"
                >
                    <i class="far fa-bell"></i>
                    <span
                        class="badge badge-warning navbar-badge"
                        v-if="listNotificacionUsers.length > 0"
                        >{{ listNotificacionUsers.length }}</span
                    >
                </a>
                <div
                    class="dropdown-menu dropdown-menu-lg dropdown-menu-right"
                    style="left: inherit; right: 0px"
                >
                    <span class="dropdown-item dropdown-header border-bottom"
                        >{{ listNotificacionUsers.length }} Notificationes</span
                    >
                    <div class="contenedor_notificaciones">
                        <div
                            class="item_notificacion"
                            v-for="item in listNotificacionUsers"
                        >
                            <Link
                                :href="
                                    item.notificacion.url +
                                    '?notificacion_user_id=' +
                                    item.id
                                "
                                class="dropdown-item"
                            >
                                <div class="icon">
                                    <i
                                        class="mr-2"
                                        :class="[item.notificacion.icon]"
                                    ></i>
                                </div>
                                <div class="descripcion_notificacion">
                                    {{ item.notificacion.descripcion }}
                                </div>
                                <div
                                    class="tiempo float-right text-muted text-sm"
                                >
                                    {{ item.notificacion.hace }}
                                </div>
                            </Link>
                        </div>
                    </div>
                    <Link
                        :href="route('notificacion_users.index')"
                        class="dropdown-item dropdown-footer border-top"
                        >Ver todas</Link
                    >
                </div>
            </li>
            <li class="nav-item">
                <a
                    class="nav-link"
                    data-widget="fullscreen"
                    href="#"
                    role="button"
                    @click.prevent="salir"
                >
                    <i class="fas fa-power-off"></i>
                </a>
            </li>
        </ul>
    </nav>
    <!-- /.navbar -->
</template>
