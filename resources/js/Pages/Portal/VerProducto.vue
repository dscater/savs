<script setup>
import Portal from "@/Layouts/Portal.vue";
import { usePage, router, Link } from "@inertiajs/vue3";
import {
    computed,
    onBeforeUnmount,
    onMounted,
    onUnmounted,
    ref,
    watch,
} from "vue";
defineOptions({ layout: Portal });
const propsPage = usePage().props;
const url_assets = ref(propsPage.url_assets);

const props = defineProps({
    catalogo: Object,
    producto: Object,
});

onMounted(() => {});

onBeforeUnmount(() => {});
</script>
<template>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="mx-auto col-md-9 text-center mt-3" v-if="catalogo">
                    <Link
                        class="text-dark"
                        :href="route('portal.productos', catalogo.id)"
                        ><i class="fa fa-arrow-left"></i> Volver a
                        Catálogo</Link
                    >
                </div>
                <div class="menu_inicio">
                    <div class="contenedor_producto">
                        <div
                            class="producto"
                            :style="{
                                backgroundImage: `url(${producto.url_imagen})`,
                                backgroundSize: 'contain',
                                backgroundRepeat: 'no-repeat',
                                backgroundPosition: 'center',
                            }"
                        ></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped></style>
