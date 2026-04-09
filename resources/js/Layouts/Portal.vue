<script setup>
// includes
import { ref, onMounted, onBeforeMount, watch } from "vue";
import { Link, router, usePage } from "@inertiajs/vue3";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
import NavBar from "./includes_portal/NavBar.vue";
import Footer from "./includes_portal/Footer.vue";
const configuracionStore = useConfiguracionStore();
const { auth } = usePage().props;
const propsPage = usePage().props;

const listBusqueda = ref([]);
const txtSearch = ref("");
const buscarProducto = () => {
    axios
        .get(route("productos.buscar"), {
            params: {
                search: txtSearch.value,
            },
        })
        .then((res) => {
            listBusqueda.value = res.data.productos ?? [];
        });
};

const onSearch = () => {
    if (!txtSearch.value) {
        listBusqueda.value = [];
    }
};

onMounted(() => {
    configuracionStore.initConfiguracion();
});

const cerrarMenu = () => {
    listBusqueda.value = [];
    txtSearch.value = "";
    document.getElementById("navbarNav").classList.remove("show");
};

const formatUrl = (url) => {
    if (!url) return "#";
    return url.startsWith("http") ? url : `https://${url}`;
};

onBeforeMount(() => {});
</script>
<template>
    <div class="min-h-screen bg-gray-100">
        <NavBar></NavBar>
        <slot></slot>
        <Footer></Footer>
    </div>
</template>
