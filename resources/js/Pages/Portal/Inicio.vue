<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { ref } from "vue";
defineOptions({ layout: Portal });
const propsPage = usePage().props;
const url_assets = ref(propsPage.url_assets);

const props = defineProps({
    catalogos: Array,
    page: Number,
});
</script>
<template>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="menu_inicio">
                    <div class="portada">
                        <img :src="url_assets + '/imgs/portada.jpg'" alt="" />
                    </div>
                    <div class="menu">
                        <div class="opcion" v-for="item in catalogos">
                            <Link
                                :href="
                                    route('portal.productos', { id: item.id })
                                "
                            >
                                <img :src="item.url_imagen" alt="" />
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
