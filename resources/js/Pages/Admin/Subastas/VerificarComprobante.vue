<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
    participante: {
        tpye: Object,
        default: null,
    },
});

const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const oParticipante = ref(props.participante);
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
        }
    },
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    },
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    },
);
watch(
    () => props.participante,
    (newValue) => {
        oParticipante.value = newValue;
    },
);

const { auth } = usePage().props;

const tituloDialog = computed(() => {
    return `<i class="fa fa-check-circle"></i> Verificar comprobante`;
});

const actualizando = ref(false);

const actualizarComprobante = (estado_comprobante) => {
    actualizando.value = true;
    let url = route("participantes.update", oParticipante.value.id);
    axios
        .post(url, {
            estado_comprobante,
            _method: "PUT",
        })
        .then((response) => {
            actualizando.value = false;
            dialog.value = false;
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `Proceso realizado`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            emits("envio-formulario", response.data);
        })
        .catch((error) => {
            actualizando.value = false;
            console.log("ERROR");
            console.log(error);
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `Ocurrió un error inesperado intente nuevamente`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        });
};

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    // oParticipante.value = null;
    dialog.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

// const cargarListas = () => {};

onMounted(() => {});
</script>

<template>
    <div
        class="modal fade"
        :class="{
            show: dialog,
        }"
        id="modal-dialog-form"
        :style="{
            display: dialog ? 'block' : 'none',
        }"
    >
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h4 class="modal-title" v-html="tituloDialog"></h4>
                    <button type="button" class="close" @click="cerrarDialog()">
                        <i class="fa fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row" v-if="oParticipante">
                        <div class="col-12">
                            <template
                                v-if="oParticipante.tipo_comprobante == 'file'"
                            >
                                <iframe
                                    :src="oParticipante.url_comprobante"
                                    frameborder="0"
                                    height="600px"
                                ></iframe>
                            </template>
                            <template v-else>
                                <img
                                    :src="oParticipante.url_comprobante"
                                    alt=""
                                    width="100%"
                                />
                            </template>
                            <a
                                :href="oParticipante.url_comprobante"
                                target="_blank"
                                class="btn btn-primary ml-auto"
                                >Abrir archivo
                                <i class="fa fa-external-link"></i
                            ></a>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-end">
                    <a
                        href="javascript:;"
                        class="btn btn-default"
                        @click="cerrarDialog()"
                        ><i class="fa fa-times"></i> Cerrar</a
                    >
                    <button
                        v-if="
                            auth?.user.permisos == '*' ||
                            auth?.user.permisos.includes(
                                'subastas.rechazar_comprobante',
                            )
                        "
                        type="button"
                        @click="actualizarComprobante(2)"
                        class="btn btn-danger"
                        :disabled="actualizando"
                    >
                        <i class="fa fa-times"></i>
                        Rechazar comprobante
                    </button>
                    <button
                        v-if="
                            auth?.user.permisos == '*' ||
                            auth?.user.permisos.includes(
                                'subastas.aprobar_comprobante',
                            )
                        "
                        type="button"
                        @click="actualizarComprobante(1)"
                        class="btn btn-success"
                        :disabled="actualizando"
                    >
                        <i class="fa fa-check"></i>
                        Aprobar comproabante
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped>
iframe {
    width: 100%;
}
</style>
