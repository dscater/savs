<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { inject, onBeforeMount, onMounted, ref } from "vue";
import DetalleSubasta from "@/Components/DetalleSubasta.vue";
import ModalComprobante from "@/Components/ModalComprobante.vue";
import ModalPuja from "@/Components/ModalPuja.vue";
import Publicacion from "@/Components/Publicacion.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
// importar estilos de AOS
import "aos/dist/aos.css";
import AOS from "aos";
import Seccion from "@/Layouts/includes_portal/Seccion.vue";

const appStore = useAppStore();
defineOptions({ layout: Portal });
const props = defineProps({
    subasta: {
        type: Object,
        default: null,
    },
});

const verificaUser = inject("verificaUser");
const verificarPujaUser = inject("verificarPujaUser");
const oPublicacion = ref(props.subasta);
const oSubastaCliente = ref(null);

const modal_dialog = ref(false);
const modal_dialog_comprobante = ref(false);
const modal_dialog_puja = ref(false);
const data_puja = ref(null);

const muestraFormPuja = (participante) => {
    oSubastaCliente.value = participante;
    modal_dialog_comprobante.value = false;
    modal_dialog_puja.value = true;
};

const obtieneInfoSubastaCliente = async () => {
    if (props.auth && props.auth.user) {
        data_puja.value = await verificarPujaUser(
            props_page.auth.user.id,
            oPublicacion.value.id,
        );
        if (data_puja.value && data_puja.value.participante) {
            oSubastaCliente.value = data_puja.value.participante;
        } else {
            oSubastaCliente.value = null;
        }
    }
};

const actualizaPublicacion = (newVal) => {
    oPublicacion.value = newVal;
};

onMounted(() => {
    obtieneInfoSubastaCliente();

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
        <Seccion :titulo="'Ver Subasta'"></Seccion>

        <div class="container mt-4">
            <DetalleSubasta
                :open_dialog="modal_dialog"
                :publicacion="oPublicacion"
                @cerrar-dialog="modal_dialog = false"
            ></DetalleSubasta>
            <ModalComprobante
                :open_dialog="modal_dialog_comprobante"
                :publicacion="oPublicacion"
                :participante="oSubastaCliente"
                @cerrar-dialog="modal_dialog_comprobante = false"
                @envio-formulario="muestraFormPuja"
            ></ModalComprobante>
            <ModalPuja
                :open_dialog="modal_dialog_puja"
                :publicacion="oPublicacion"
                :participante="oSubastaCliente"
                @cerrar-dialog="modal_dialog_puja = false"
                @envio-formulario="actualizaPublicacion"
            ></ModalPuja>

            <div id="product" class="section-container pt-20px">
                <div class="container">
                    <div class="row mb-2">
                        <div class="col-12">
                            <Link
                                :href="route('portal.subastas')"
                                class="btn btn-link text-dark"
                                ><i class="fa fa-arrow-left"></i> Volver a
                                Subastas</Link
                            >
                        </div>
                    </div>
                    <Publicacion
                        :publicacion="oPublicacion"
                        :detalle_lista="true"
                    ></Publicacion>
                </div>
            </div>
        </div>
    </div>
</template>
