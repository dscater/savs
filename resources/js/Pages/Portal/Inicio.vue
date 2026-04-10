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
        <div class="container">
            <div class="row mt-3">
                <div class="col-12" data-aos="fade-up">
                    <div class="card">
                        <div class="card-body p-0 px-2">
                            <div class="row">
                                <div class="col-md-6 p-0 contenedor_img_inicio">
                                    <img
                                        class="img_inicio"
                                        :src="
                                            url_assets +
                                            'imgs/portal/inicio.jpg'
                                        "
                                        alt=""
                                    />
                                </div>
                                <div class="col-md-6 p-5">
                                    <h4 class="h5">What is Lorem Ipsum?</h4>
                                    <p class="text-sm text-justify">
                                        Lorem Ipsum is simply dummy text of the
                                        printing and typesetting industry. Lorem
                                        Ipsum has been the industry's standard
                                        dummy text ever since the 1500s, when an
                                        unknown printer took a galley of type
                                        and scrambled it to make a type specimen
                                        book. It has survived not only five
                                        centuries, but also the leap into
                                        electronic typesetting, remaining
                                        essentially unchanged.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12" data-aos="fade-up">
                    <div class="card">
                        <div class="card-body p-0 px-2">
                            <div class="row">
                                <div class="col-md-6 p-5">
                                    <h4 class="h5">What is Lorem Ipsum?</h4>
                                    <p class="text-sm text-justify">
                                        Lorem Ipsum is simply dummy text of the
                                        printing and typesetting industry. Lorem
                                        Ipsum has been the industry's standard
                                        dummy text ever since the 1500s, when an
                                        unknown printer took a galley of type
                                        and scrambled it to make a type specimen
                                        book. It has survived not only five
                                        centuries, but also the leap into
                                        electronic typesetting, remaining
                                        essentially unchanged.
                                    </p>
                                </div>
                                <div class="col-md-6 p-0 contenedor_img_inicio">
                                    <img
                                        class="img_inicio"
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
</template>
