<script>
import Portal from "@/Layouts/Portal.vue";
import Publicacion from "@/Components/Publicacion.vue";
export default {
    layout: Portal,
};
</script>
<script setup>
import { usePage, Head, router, Link } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";
const { props: props_page } = usePage();
const user = ref(props_page.auth?.user);
const url_asset = ref(props_page.url_assets);
const listSubastas = ref([]);
const page = ref(1);
const last_page = ref(1);
const total = ref(0);

const obtenerRegistros = () => {
    axios
        .get(route("subastas.porClientePaginado"), {
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
    obtenerRegistros();
};

const cargarListas = () => {
    obtenerRegistros();
};

onMounted(() => {
    cargarListas();
});
</script>
<template>
    <!-- BEGIN container -->
    <div class="container">
        <div class="row mt-4">
            <div class="col-12">
                <h4 class="h3 font-weight-bold w-100 text-center">
                    Mis Subastas
                </h4>
            </div>
        </div>
        <!-- BEGIN row -->
        <div class="row">
            <!-- BEGIN col-2 -->
            <div class="col-12" v-for="item in listSubastas">
                <Publicacion
                    :publicacion="item"
                    :link="true"
                    :column="true"
                    :detalle_lista="true"
                ></Publicacion>
            </div>
            <!-- END col-2 -->
        </div>
        <!-- END row -->
        <div class="row mb-3" v-if="page >= 1 && listSubastas.length > 0">
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
    </div>
    <!-- END container -->
</template>
<style scoped>
.container {
    min-height: 79.3vh;
}
</style>
