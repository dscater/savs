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
                                            class="card-body p-0"
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
                                        <div
                                            class="card-footer bg-principal-portal"
                                        >
                                            <div class="row">
                                                <div class="col-7 categoria">
                                                    <span
                                                        class="text-xs text-white"
                                                    >
                                                        {{
                                                            item.categoria
                                                                .nombre
                                                        }}
                                                    </span>
                                                    <br />
                                                    <span
                                                        class="precio text-sm text-white font-weight-600"
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
                                                    'imgs/portal/subastas.jpeg'
                                                "
                                                alt=""
                                            />
                                        </div>
                                        <div
                                            class="col-md-6 p-5 bg-dark d-flex flex-column justify-content-center align-items-center"
                                        >
                                            <h4 class="title-seccion">
                                                Subastas
                                            </h4>
                                            <p class="descripcion-seccion">
                                                Participa de nuestras subastas y
                                                adquiere productos a precios
                                                increíbles. Cada semana,
                                                ofrecemos una selección de
                                                artículos exclusivos que puedes
                                                pujar para ganar.
                                            </p>
                                            <Link
                                                :href="route('portal.subastas')"
                                                class="btn btn-primary mx-auto d-block mt-3"
                                            >
                                                Ver Subastas
                                                <i
                                                    class="fa fa-arrow-right"
                                                ></i>
                                            </Link>
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
                                    <div
                                        class="col-md-6 p-5 d-flex flex-column justify-content-center align-items-center"
                                    >
                                        <h4 class="title-seccion">
                                            AUTOPARTES
                                        </h4>
                                        <p class="descripcion-seccion">
                                            La empresa ofrece autopartes de
                                            vehículos en general (como ser
                                            faroles, parachoques, stop,
                                            retrovisores, puertas, halógenos,
                                            máscaras, guardafangos, capo,
                                            ECU-Computadora de Motor, etc.)
                                            Incluye asesoramiento al cliente
                                            para que puedan encontrar el
                                            repuesto deseado para sus vehículos.
                                        </p>
                                    </div>
                                    <div
                                        class="col-md-6 p-0 contenedor_img_inicio"
                                    >
                                        <img
                                            class="img_inicio right"
                                            :src="
                                                url_assets +
                                                'imgs/portal/autopartes.jpeg'
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
                                                    'imgs/portal/mision.jpeg'
                                                "
                                                alt=""
                                            />
                                        </div>
                                        <div
                                            class="col-md-6 p-5 d-flex flex-column justify-content-center align-items-center"
                                        >
                                            <h4
                                                class="title-seccion w-100 text-center"
                                            >
                                                Misión
                                            </h4>
                                            <p class="descripcion-seccion">
                                                Priorizar la calidad del
                                                producto, también buscar la
                                                satisfacción del cliente
                                                ofreciendo una rápida y
                                                eficiente entrega de nuestras
                                                autopartes, así como el soporte
                                                técnico para cualquier consulta.
                                            </p>
                                            <h4
                                                class="title-seccion w-100 text-center"
                                            >
                                                Visión
                                            </h4>
                                            <p class="descripcion-seccion">
                                                Ser reconocida como una empresa
                                                líder en distribución y
                                                comercialización de autopartes
                                                para vehículos, destacando por
                                                la calidad de sus productos de
                                                autopartes y servicios, también
                                                innovando y desarrollando nuevas
                                                tecnologías para mejorar la
                                                eficiencia de la empresa.
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
    </div>
</template>
