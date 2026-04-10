<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { onBeforeMount, onMounted, ref } from "vue";
import SliderImagenes from "@/Components/SliderImagenes.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
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
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">Subasta de Accesorios</div>
                        </div>
                        <div class="card-body">
                            What is Lorem Ipsum? Lorem Ipsum is simply dummy
                            text of the printing and typesetting industry. Lorem
                            Ipsum has been the industry's standard dummy text
                            ever since the 1500s, when an unknown printer took a
                            galley of type and scrambled it to make a type
                            specimen book. It has survived not only five
                            centuries, but also the leap into electronic
                            typesetting, remaining essentially unchanged.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
