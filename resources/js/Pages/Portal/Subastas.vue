<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { onBeforeMount, onMounted, ref } from "vue";
import Publicacion from "@/Components/Publicacion.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
// importar estilos de AOS
import "aos/dist/aos.css";
import AOS from "aos";
import Seccion from "@/Layouts/includes_portal/Seccion.vue";

const appStore = useAppStore();
defineOptions({ layout: Portal });
const props = defineProps({
    subastas: {
        type: Array,
        default: [],
    },
});

const propsPage = usePage().props;
const url_assets = ref(propsPage.url_assets);
const listSubastas = ref([]);
const page = ref(1);
const last_page = ref(1);
const total = ref(0);

const obtenerVehiculos = () => {
    axios
        .get(route("subastas.portal"), {
            params: {
                page: page.value,
            },
        })
        .then((response) => {
            const registros = response.data.subastas;
            page.value = registros.current_page;
            last_page.value = registros.last_page;
            listSubastas.value = registros.data;
            total.value = registros.total;
        });
};

const updatePage = (value) => {
    page.value = page.value + value;
    if (page.value < 0) page.value = 1;
    if (page.value > total.value) page.value = last_page;
    obtenerVehiculos();
};

const cargarListas = () => {
    obtenerVehiculos();
};

onMounted(() => {
    cargarListas();

    appStore.stopLoading();
    AOS.init({
        duration: 1000,
        easing: "ease-in-out",
        once: false,
        mirror: false,
    });
});

onBeforeMount(() => {
    appStore.startLoading();
});
</script>
<template>
    <div class="container-fluid seccion">
        <Seccion :titulo="'Subastas'"></Seccion>

        <div class="container mt-4">
            <div class="row">
                <div class="col-12">
                    <h4 class="text-center h3">Subastas Actuales</h4>
                </div>
            </div>
            <div class="row" v-if="listSubastas.length > 0">
                <div
                    class="col-lg-6 col-md-6 col-sm-12"
                    v-for="item in listSubastas"
                >
                    <Publicacion
                        :publicacion="item"
                        :column="true"
                        :link="true"
                    ></Publicacion>
                </div>
            </div>
            <div class="row mb-3" v-if="listSubastas.length > 0">
                <div class="col-12 text-center font-weight-bold">
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
            <div class="row" v-if="listSubastas.length == 0">
                <div class="col-12">
                    <h5 class="text-muted text-md w-100 text-center">
                        Sin registros disponibles
                    </h5>
                </div>
            </div>
        </div>
    </div>
</template>
