<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { onBeforeMount, onMounted, ref } from "vue";
import SliderImagenes from "@/Components/SliderImagenes.vue";
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

onMounted(() => {
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
            <div class="row" v-if="subastas.length > 0"></div>
            <div class="row" v-else>
                <div class="col-12">
                    <h5 class="text-muted text-md w-100 text-center">
                        Sin registros disponibles
                    </h5>
                </div>
            </div>
        </div>
    </div>
</template>
