<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { inject, onBeforeMount, onMounted, ref } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import SliderImagenes from "@/Components/SliderImagenes.vue";
// importar estilos de AOS
import "aos/dist/aos.css";
import AOS from "aos";
import Seccion from "@/Layouts/includes_portal/Seccion.vue";

const appStore = useAppStore();
defineOptions({ layout: Portal });
const props = defineProps({
    producto: {
        type: Object,
        default: null,
    },
});

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
        <Seccion :titulo="'Ver Producto'"></Seccion>

        <div class="container mt-4">
            <div id="product" class="section-container pt-20px">
                <div class="container">
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <SliderImagenes
                                :imagenes="producto.producto_imagens"
                                :height="'400px'"
                            ></SliderImagenes>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div
                                            class="col-5 font-weight-bold text-right"
                                        >
                                            Nombre del Producto:
                                        </div>
                                        <div class="col-7">
                                            {{ producto.nombre }}
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div
                                            class="col-5 font-weight-bold text-right"
                                        >
                                            Categoría:
                                        </div>
                                        <div class="col-7">
                                            {{ producto.categoria.nombre }}
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div
                                            class="col-5 font-weight-bold text-right"
                                        >
                                            Descripción:
                                        </div>
                                        <div class="col-7">
                                            <div
                                                class="ql-editor"
                                                v-html="producto.descripcion"
                                            ></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4 offset-md-4">
                                            <Link
                                                :href="route('portal.index')"
                                                class="text-gray"
                                                ><i
                                                    class="fa fa-arrow-left"
                                                ></i>
                                                Seguir viendo</Link
                                            >
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
