<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { onBeforeMount, onMounted, ref } from "vue";
import SliderImagenes from "@/Components/SliderImagenes.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";

// importar estilos de AOS
import "aos/dist/aos.css";
import AOS from "aos";
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

onBeforeMount(() => {
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
                                        ? 'bg-principal'
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
                                        <div class="card-body">
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
                                                    <Link
                                                        :href="
                                                            route(
                                                                'portal.producto',
                                                                item.id,
                                                            )
                                                        "
                                                        >{{ item.nombre }}</Link
                                                    >
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
