<script setup>
// includes
import { ref, provide, onMounted, onBeforeMount, watch } from "vue";
import { Link, router, usePage } from "@inertiajs/vue3";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
import NavBar from "./includes_portal/NavBar.vue";
import Footer from "./includes_portal/Footer.vue";
const configuracionStore = useConfiguracionStore();
const { auth } = usePage().props;
const propsPage = usePage().props;
const user = ref(propsPage.auth.user);
const dialog_atencion = ref(false);
const verificaUser = () => {
    if (user.value) {
        // console.log("LOGEADO");
        document.getElementsByTagName("body")[0].classList.remove("modal-open");
        return true;
    }

    dialog_atencion.value = true;
    document.getElementsByTagName("body")[0].classList.add("modal-open");
    // console.log("SIN LOGEAR");
    return false;
};

const verificarPujaUser = async (user_id, publicacion_id) => {
    try {
        const response = await axios.get(
            route("participantes.verificaParticipante"),
            {
                params: {
                    user_id,
                    publicacion_id,
                },
            },
        );

        return response.data;
    } catch (error) {
        console.log(error);
        throw error;
    }
};

provide("verificaUser", verificaUser);
provide("verificarPujaUser", verificarPujaUser);

const cerrarLogin = () => {
    dialog_atencion.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
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
        <div class="portal_content">
            <slot></slot>
        </div>
        <Footer></Footer>
        <div
            class="modal fade"
            :class="{
                show: dialog_atencion,
            }"
            id="modal-dialog-info"
            :style="{
                display: dialog_atencion ? 'block' : 'none',
            }"
        >
            <div class="modal-dialog my-5">
                <div class="modal-content">
                    <div class="modal-body bg-principal border rounded">
                        <button
                            class="btnCerrarLoginRegistro close text-white"
                            @click="cerrarLogin()"
                        >
                            X
                        </button>
                        <div class="row mt-3">
                            <div class="col-12 text-center">
                                <h4 class="w-100 text-center font-weight-bold">
                                    Debes iniciar sesión o registrarte
                                </h4>
                                <a
                                    :href="route('login')"
                                    class="btn btn-primary mb-2"
                                    >Ir al login</a
                                ><br />
                                <a
                                    :href="route('registro')"
                                    class="btn btn-success"
                                    >Registrarse</a
                                >
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
