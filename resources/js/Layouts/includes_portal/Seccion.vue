<script setup>
import { Link, usePage } from "@inertiajs/vue3";
import { ref } from "vue";
const propsPage = usePage().props;
const url_assets = ref(propsPage.url_assets);

const props = defineProps({
    titulo: {
        type: String,
        default: "Sección",
    },
});
</script>
<template>
    <div class="row">
        <div class="col-12 p-0">
            <div class="contenedor">
                <div
                    class="imagen"
                    :style="{
                        backgroundImage: `url(${url_assets + 'imgs/portal/pagetitle.jpg'})`,
                    }"
                ></div>
                <div class="capa">
                    {{ titulo }}
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped>
.contenedor {
    height: 20vh;
    position: relative;
}
.contenedor .imagen {
    height: 100%;
    background-position: center center;
    background-size: cover;
    background-repeat: no-repeat;
}
.contenedor .capa {
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    background-color: var(--bgDarkt);
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-size: 2.8em;
}
</style>
