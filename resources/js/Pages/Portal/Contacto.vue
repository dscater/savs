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

const formatUrl = (url) => {
    if (!url) return "#";
    return url.startsWith("http") ? url : `https://${url}`;
};

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
        <Seccion :titulo="'Contacto'"></Seccion>

        <div class="container mt-4">
            <div id="product" class="section-container pt-20px">
                <div class="container">
                    <div class="row mb-2">
                        <div class="col-12">
                            <iframe
                                src="https://www.google.com/maps/embed?pb=!1m17!1m12!1m3!1d4716.624880063206!2d-68.15847992485448!3d-16.521143984225752!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMTbCsDMxJzE2LjEiUyA2OMKwMDknMjEuMyJX!5e1!3m2!1ses-419!2sbo!4v1776553757792!5m2!1ses-419!2sbo"
                                width="100%"
                                height="450"
                                style="border: 0"
                                allowfullscreen=""
                                loading="lazy"
                                referrerpolicy="no-referrer-when-downgrade"
                            ></iframe>
                        </div>
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12 text-center">
                                            <h4 class="font-weight-bold">
                                                Comunicate con nosotros
                                            </h4>
                                        </div>
                                        <div
                                            class="col-12 text-center pb-0 mb-0 mt-2"
                                        >
                                            <a
                                                :href="`https://wa.me/+59169796503?text=Hola%20deseo%20mas%20informacion`"
                                                target="_blank"
                                                class="mx-2 text-dark text-lg"
                                            >
                                                <i class="fab fa-whatsapp"></i>
                                                69796503
                                            </a>
                                            <a
                                                :href="`https://wa.me/+59178815163?text=Hola%20deseo%20mas%20informacion`"
                                                target="_blank"
                                                class="mx-2 text-dark text-lg"
                                            >
                                                <i class="fab fa-whatsapp"></i>
                                                78815163
                                            </a>
                                            <a
                                                :href="`https://wa.me/+59177710866?text=Hola%20deseo%20mas%20informacion`"
                                                target="_blank"
                                                class="mx-2 text-dark text-lg"
                                            >
                                                <i class="fab fa-whatsapp"></i>
                                                77710866
                                            </a>
                                        </div>
                                        <div class="col-12 text-center mt-3">
                                            <a
                                                :href="
                                                    formatUrl(
                                                        'https://www.facebook.com/people/Autopartes-Rudje-Kaizen-Group/100092425002265/',
                                                    )
                                                "
                                                target="_blank"
                                                class="mx-2 text-dark text-md"
                                            >
                                                <i class="fab fa-facebook"></i>
                                                Facebook
                                            </a>
                                            <a
                                                :href="`mailto:www.autopartesrudjekaizengroup@gmail.com`"
                                                target="_blank"
                                                class="mx-2 text-dark text-md"
                                            >
                                                <i class="fa fa-envelope"></i>
                                                www.autopartesrudjekaizengroup@gmail.com`
                                            </a>
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
