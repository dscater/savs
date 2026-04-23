<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
import { usePedidoStore } from "@/stores/pedido/pedidoStore";
const pedidoStore = usePedidoStore();

const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    producto: {
        type: Object,
        default: null,
    },
});

const oProducto = ref(props.producto);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
const oAgregar = ref({
    cantidad: 1,
});
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
        } else {
            oAgregar.value.cantidad = 1;
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    },
);
watch(
    () => props.producto,
    (newValue) => {
        oProducto.value = newValue;
    },
);

const tituloDialog = computed(() => {
    return `<i class="fa fa-cart-plus"></i> Agregar producto`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    return `<i class="fa fa-plus"></i> Agregar`;
});

const enviarFormulario = () => {
    if (!oAgregar.value.cantidad || parseFloat(oAgregar.value.cantidad) < 1) {
        toast.error("Debes ingresar una cantidad valida");
        return;
    }

    enviando.value = true;
    pedidoStore.agregarProducto(oProducto.value, oAgregar.value.cantidad);

    enviando.value = false;
    emits("cerrar-formulario");
};

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const disminuir = () => {
    if (oAgregar.value.cantidad < 2) {
        return;
    }
    oAgregar.value.cantidad--;
};
const aumentar = () => {
    oAgregar.value.cantidad++;
};

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

onMounted(() => {});
</script>

<template>
    <MiModal
        :open_modal="muestra_form"
        @close="cerrarFormulario"
        :size="''"
        :header-class="'bg-principal'"
        :footer-class="'justify-content-end'"
    >
        <template #header>
            <h4 class="modal-title text-white" v-html="tituloDialog"></h4>
            <button
                type="button"
                class="close"
                @click.prevent="cerrarFormulario()"
            >
                <span aria-hidden="true">×</span>
            </button>
        </template>

        <template #body>
            <form @submit.prevent="enviarFormulario()" v-if="oProducto">
                <div class="row">
                    <div class="col-12">
                        <img
                            :src="oProducto.producto_imagens[0].url_imagen"
                            alt=""
                            class="w-100"
                        />
                    </div>
                    <div class="col-12">
                        <h4
                            class="card-title font-weight-bold text-center w-100"
                        >
                            {{ oProducto.nombre }}
                        </h4>
                    </div>
                    <div class="col-12">
                        <h4
                            class="card-title font-weight-bold text-center w-100"
                        >
                            {{ oProducto.moneda }} {{ oProducto.precio }}
                        </h4>
                    </div>
                    <div class="col-md-12 mt-2">
                        <label>Cantidad</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button
                                    class="btn btn-default"
                                    @click.prevent="disminuir"
                                >
                                    -
                                </button>
                            </div>
                            <input
                                type="number"
                                step="1"
                                class="form-control text-center"
                                v-model="oAgregar.cantidad"
                            />
                            <div class="input-group-append">
                                <button
                                    class="btn btn-default"
                                    @click.prevent="aumentar"
                                >
                                    +
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </template>
        <template #footer>
            <button
                type="button"
                class="btn btn-default"
                @click.prevent="cerrarFormulario()"
            >
                Cerrar
            </button>
            <button
                type="button"
                class="btn btn-success"
                :disabled="enviando"
                @click.prevent="enviarFormulario"
                v-html="textBtn"
            ></button>
        </template>
    </MiModal>
</template>
