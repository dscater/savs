<script setup>
// includes
import { ref, onMounted, onBeforeMount, watch } from "vue";
import { Link, router, usePage } from "@inertiajs/vue3";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
const configuracionStore = useConfiguracionStore();
import { useSocialStore } from "@/stores/social/socialStore";
const socialStore = useSocialStore();
import { useCatalogoStore } from "@/stores/catalogo/catalogoStore";
const catalogoStore = useCatalogoStore();
const { auth } = usePage().props;
const propsPage = usePage().props;

const listBusqueda = ref([]);
const txtSearch = ref("");
const buscarProducto = () => {
    axios
        .get(route("productos.buscar"), {
            params: {
                search: txtSearch.value,
            },
        })
        .then((res) => {
            listBusqueda.value = res.data.productos ?? [];
        });
};

const onSearch = () => {
    if (!txtSearch.value) {
        listBusqueda.value = [];
    }
};

onMounted(() => {
    configuracionStore.initConfiguracion();
    socialStore.initSocial();
});

const cerrarMenu = () => {
    listBusqueda.value = [];
    txtSearch.value = "";
    document.getElementById("navbarNav").classList.remove("show");
};

const formatUrl = (url) => {
    if (!url) return "#";
    return url.startsWith("http") ? url : `https://${url}`;
};

onBeforeMount(() => {});
</script>
<template>
    <div class="min-h-screen bg-gray-100">
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
            <div class="container-fluid">
                <Link class="navbar-brand" href="/">
                    <img
                        :src="configuracionStore.oConfiguracion.url_logo"
                        alt="Logo"
                        height="40px"
                    />
                    {{ configuracionStore.oConfiguracion.alias }}</Link
                >
                <button
                    class="navbar-toggler"
                    type="button"
                    data-toggle="collapse"
                    data-target="#navbarNav"
                    aria-controls="navbarNav"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                >
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div
                    class="collapse navbar-collapse justify-content-end"
                    id="navbarNav"
                >
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <Link
                                class="nav-link"
                                :href="route('portal.miCatalogo')"
                                >Mi Pedido
                                <span
                                    class="badge"
                                    :class="{
                                        'bg-orange text-white':
                                            catalogoStore.getListaProductos
                                                .length > 0,
                                        'badge-secondary':
                                            catalogoStore.getListaProductos
                                                .length === 0,
                                    }"
                                    >{{
                                        catalogoStore.getListaProductos.length
                                    }}</span
                                ></Link
                            >
                        </li>
                        <li class="nav-item">
                            <Link
                                class="nav-link"
                                :href="route('login')"
                                v-if="!auth.user"
                            >
                                <i class="fa fa-sign-in-alt"></i>
                            </Link>
                            <Link
                                class="nav-link"
                                :href="route('inicio')"
                                v-else
                            >
                                <i class="fa fa-user"></i>
                            </Link>
                        </li>
                    </ul>
                    <form class="form-inline formBusqueda">
                        <div class="input-group">
                            <input
                                class="form-control mr-sm-2"
                                type="search"
                                placeholder="Buscar"
                                aria-label="Buscar"
                                v-model="txtSearch"
                                @search="onSearch"
                                @keypress.enter.prevent="buscarProducto"
                            />
                            <div class="input-group-append">
                                <button
                                    class="btn btn-outline-info"
                                    @click.prevent="buscarProducto"
                                    type="submit"
                                >
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <div
                            class="contenedor_busqueda_producto"
                            v-if="listBusqueda.length > 0"
                        >
                            <div class="resultado_busqueda">
                                <div class="w-100 text-center mb-2">
                                    {{ listBusqueda.length }} resultados
                                    encontrados
                                </div>
                                <div
                                    class="item_resultado"
                                    v-for="item in listBusqueda"
                                >
                                    <Link
                                        @click="cerrarMenu"
                                        :href="
                                            route('portal.verProducto', item.id)
                                        "
                                    >
                                        <img
                                            :src="item.url_imagen"
                                            alt="Imagen"
                                        />
                                    </Link>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </nav>
        <slot></slot>

        <!-- REDES SOCIALES -->
        <div class="container mt-5 mb-0 pb-0">
            <div class="row">
                <div class="col-12 text-center">
                    <h4 class="text-dark font-weight-bold">
                        Comunicate con nosotros
                    </h4>
                </div>
                <div
                    class="col-12 text-center pb-0 mb-0"
                    v-if="socialStore.oSocial"
                >
                    <a
                        :href="`https://wa.me/${socialStore.oSocial.whatsapp}?text=Hola%20deseo%20mas%20informacion`"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fab fa-whatsapp"></i>
                    </a>
                    <a
                        v-if="socialStore.oSocial.facebook"
                        :href="formatUrl(socialStore.oSocial.facebook)"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a
                        v-if="socialStore.oSocial.tiktok"
                        :href="formatUrl(socialStore.oSocial.tiktok)"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fab fa-tiktok"></i>
                    </a>
                    <a
                        v-if="socialStore.oSocial.instagram"
                        :href="formatUrl(socialStore.oSocial.instagram)"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a
                        v-if="socialStore.oSocial.youtube"
                        :href="formatUrl(socialStore.oSocial.youtube)"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fab fa-youtube"></i>
                    </a>
                    <a
                        v-if="socialStore.oSocial.x"
                        :href="formatUrl(socialStore.oSocial.x)"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a
                        v-if="socialStore.oSocial.web"
                        :href="formatUrl(socialStore.oSocial.web)"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fa fa-globe"></i>
                    </a>
                    <a
                        v-if="socialStore.oSocial.correo"
                        :href="`mailto:${socialStore.oSocial.correo}`"
                        target="_blank"
                        class="btn btn-outline-dark m-1"
                    >
                        <i class="fa fa-envelope"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>
