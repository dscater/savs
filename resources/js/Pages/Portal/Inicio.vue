<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { onBeforeMount, onMounted, ref } from "vue";
import SliderImagenes from "@/Components/SliderImagenes.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Agregar from "./Agregar.vue";

// importar estilos de AOS
import "aos/dist/aos.css";
import AOS from "aos";
import axios from "axios";
const appStore = useAppStore();
defineOptions({ layout: Portal });
const propsPage = usePage().props;
const url_assets = ref(propsPage.url_assets);

const listImagenesPortal = ref([]);
const cargarImagenePortal = () => {
    axios.get(route("portal.imagenes_portal")).then((response) => {
        listImagenesPortal.value = response.data;
    });
};

const listProductos = ref([]);
const page = ref(1);
const last_page = ref(1);
const total = ref(0);
const filtroProductos = ref({
    categoria_id: "todos",
});

const filtrarPorCategoria = (categoria_id) => {
    filtroProductos.value.categoria_id = categoria_id;
    obternerProductos();
};

const obternerProductos = () => {
    axios
        .get(route("productos.portal"), {
            params: {
                page: page.value,
                categoria_id: filtroProductos.value.categoria_id,
            },
        })
        .then((response) => {
            const registros = response.data.productos;
            page.value = registros.current_page;
            last_page.value = registros.last_page;
            listProductos.value = registros.data;
            total.value = registros.total;
        });
};

const updatePage = (value) => {
    page.value = page.value + value;
    if (page.value < 0) page.value = 1;
    if (page.value > total.value) page.value = last_page;
    obternerProductos();
};

const listCategorias = ref([]);
const obtenerCategorias = () => {
    axios.get(route("categorias.listadoPortal")).then((response) => {
        listCategorias.value = response.data.categorias;
        listCategorias.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};

const muestra_agregar = ref(false);
const oProducto = ref(null);
const agregarAlPedido = (producto) => {
    oProducto.value = producto;
    muestra_agregar.value = true;
};

const cargarListas = () => {
    obternerProductos();
    obtenerCategorias();
};

onBeforeMount(() => {
    cargarListas();
});

onMounted(() => {
    AOS.init({
        duration: 1000,
        easing: "ease-in-out",
        once: false,
        mirror: false,
    });
    appStore.stopLoading();
});

const listImagen360 = ref([]);
const cargarImagenes360 = () => {
    axios.get(route("prueba360")).then((response) => {
        listImagen360.value = response.data;
    });
};

onBeforeMount(() => {
    cargarImagenes360();
    cargarImagenePortal();
    appStore.startLoading();
});
</script>
<template>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 p-0" v-if="listImagenesPortal.length > 0">
                <SliderImagenes
                    :imagenes="listImagenesPortal"
                    :height="'90vh'"
                    :interval="4000"
                    :muestra_pc="false"
                ></SliderImagenes>
            </div>
        </div>
        <div class="row seccion_portal">
            <div class="col-12">
                <div class="container">
                    <Agregar
                        :muestra_formulario="muestra_agregar"
                        :producto="oProducto"
                        @envio-formulario="muestra_agregar = false"
                        @cerrar-formulario="muestra_agregar = false"
                    ></Agregar>
                    <div class="row mt-3">
                        <div class="col-12">
                            <h4 class="title-seccion">Nuestros Productos</h4>
                        </div>
                        <div class="col-12 overflow-auto mb-2">
                            <button
                                v-for="item in listCategorias"
                                class="btn btn-sm"
                                :class="[
                                    item.id == filtroProductos.categoria_id
                                        ? 'bg-principal-portal'
                                        : 'btn-default',
                                ]"
                                @click="filtrarPorCategoria(item.id)"
                            >
                                {{ item.nombre }}
                            </button>
                        </div>
                        <div class="col-12" data-aos="fade-up">
                            <div class="row" v-if="listProductos.length > 0">
                                <div
                                    class="col-lg-3 col-md-4 col-sm-12"
                                    v-for="item in listProductos"
                                >
                                    <div class="card producto-portal">
                                        <Link
                                            :href="
                                                route(
                                                    'portal.producto',
                                                    item.id,
                                                )
                                            "
                                            class="card-body pb-1"
                                        >
                                            <div class="row">
                                                <div
                                                    class="col-12 imagen-producto"
                                                >
                                                    <img
                                                        :src="
                                                            item
                                                                .producto_imagens[0]
                                                                .url_imagen
                                                        "
                                                        alt=""
                                                    />
                                                </div>
                                                <div class="col-12 nombre">
                                                    {{ item.nombre }}
                                                </div>
                                            </div>
                                        </Link>
                                        <div class="card-footer bg-white">
                                            <div class="row">
                                                <div class="col-7 categoria">
                                                    <span
                                                        class="text-xs text-muted"
                                                    >
                                                        {{
                                                            item.categoria
                                                                .nombre
                                                        }}
                                                    </span>
                                                    <br />
                                                    <span
                                                        class="precio text-sm text-dark font-weight-600"
                                                        >Bs.
                                                        {{ item.precio }}</span
                                                    >
                                                </div>
                                                <div
                                                    class="col-5 d-flex justify-content-end align-items-center"
                                                >
                                                    <button
                                                        class="btn btn-primary btn-sm"
                                                        @click="
                                                            agregarAlPedido(
                                                                item,
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-plus"
                                                        ></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="row mb-3"
                                v-if="listProductos.length > 0"
                            >
                                <div
                                    class="col-12 text-center font-weight-bold"
                                >
                                    <button
                                        class="btn bg-dark text-white mx-1"
                                        v-if="page > 1"
                                        @click.prevent="updatePage(-1)"
                                    >
                                        <i class="fa fa-angle-left"></i>
                                    </button>
                                    Pág. {{ page }}/{{ last_page }}
                                    <button
                                        class="btn bg-dark text-white mx-1"
                                        v-if="page < last_page"
                                        @click.prevent="updatePage(1)"
                                    >
                                        <i class="fa fa-angle-right"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="row" v-if="listProductos.length == 0">
                                <div class="col-12">
                                    <h5
                                        class="text-muted text-md w-100 text-center"
                                    >
                                        Sin registros disponibles
                                    </h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row seccion_portal dark">
            <div class="col-12">
                <div class="container">
                    <div class="row">
                        <div class="col-12" data-aos="fade-up">
                            <div class="card">
                                <div class="card-body p-0 px-2">
                                    <div class="row">
                                        <div
                                            class="col-md-6 p-0 contenedor_img_inicio"
                                        >
                                            <img
                                                class="img_inicio left"
                                                :src="
                                                    url_assets +
                                                    'imgs/portal/inicio.jpg'
                                                "
                                                alt=""
                                            />
                                        </div>
                                        <div class="col-md-6 p-5">
                                            <h4 class="h5">
                                                What is Lorem Ipsum?
                                            </h4>
                                            <p class="text-sm text-justify">
                                                Lorem Ipsum is simply dummy text
                                                of the printing and typesetting
                                                industry. Lorem Ipsum has been
                                                the industry's standard dummy
                                                text ever since the 1500s, when
                                                an unknown printer took a galley
                                                of type and scrambled it to make
                                                a type specimen book. It has
                                                survived not only five
                                                centuries, but also the leap
                                                into electronic typesetting,
                                                remaining essentially unchanged.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row seccion_portal">
            <div class="col-12">
                <div class="container">
                    <div class="col-12" data-aos="fade-up">
                        <div class="card">
                            <div class="card-body p-0 px-2">
                                <div class="row">
                                    <div class="col-md-6 p-5">
                                        <h4 class="h5">What is Lorem Ipsum?</h4>
                                        <p class="text-sm text-justify">
                                            Lorem Ipsum is simply dummy text of
                                            the printing and typesetting
                                            industry. Lorem Ipsum has been the
                                            industry's standard dummy text ever
                                            since the 1500s, when an unknown
                                            printer took a galley of type and
                                            scrambled it to make a type specimen
                                            book. It has survived not only five
                                            centuries, but also the leap into
                                            electronic typesetting, remaining
                                            essentially unchanged.
                                        </p>
                                    </div>
                                    <div
                                        class="col-md-6 p-0 contenedor_img_inicio"
                                    >
                                        <img
                                            class="img_inicio right"
                                            :src="
                                                url_assets +
                                                'imgs/portal/inicio.jpg'
                                            "
                                            alt=""
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
