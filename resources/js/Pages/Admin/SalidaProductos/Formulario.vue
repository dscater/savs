<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useSalidaProductos } from "@/composables/salida_productos/useSalidaProductos";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
});

const { oSalidaProducto, limpiarSalidaProducto } = useSalidaProductos();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
const form = useForm(oSalidaProducto.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarProductos();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form.id = oSalidaProducto.value.id;
            form.producto_id = oSalidaProducto.value.producto_id;
            form.cantidad = oSalidaProducto.value.cantidad;
            form.descripcion = oSalidaProducto.value.descripcion;
            form.fecha_registro = oSalidaProducto.value.fecha_registro;
            form._method = oSalidaProducto.value._method;
        } else {
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    },
);
watch(
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
        if (accion_form.value == 0) {
            form["_method"] = "POST";
        }
    },
);

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nueva Salida de Producto`
        : `<i class="fa fa-edit"></i> Editar Salida de Producto`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-edit"></i> Actualizar`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form.id == 0
            ? route("salida_productos.store")
            : route("salida_productos.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: (response) => {
            console.log("correcto");
            const success =
                response.props.flash.success ?? "Proceso realizado con éxito";
            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `<strong>${success}</strong>`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-alert-success",
                },
            });
            form.reset();
            limpiarSalidaProducto();
            emits("envio-formulario");
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                const lista = Object.values(form.errors)
                    .map((error) => `<li>${error}</li>`)
                    .join("");

                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<ul class="pl-5 text-left">${lista}</ul>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            } else {
                const error =
                    "Ocurrió un error inesperado contactese con el Administrador";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            }
            console.log("error: " + err.error);
        },
        onFinish: () => {
            enviando.value = false;
        },
    });
};

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const archivo = ref(null);
const cargarArchivo = (e, key) => {
    form[key] = null;
    const file = e.target.files[0];
    if (file) {
        form[key] = e.target.files[0];
    }
};
const listProductos = ref([]);
const cargarProductos = () => {
    axios.get(route("productos.listado")).then((response) => {
        listProductos.value = response.data.productos;
    });
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
        :size="'modal-xl'"
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
            <form @submit.prevent="enviarFormulario()">
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row">
                    <div class="col-md-4 mt-2">
                        <label class="required">Seleccionar Producto</label>
                        <el-select
                            :class="{
                                'parsley-error': form.errors?.producto_id,
                            }"
                            v-model="form.producto_id"
                            filterable
                            placeholder="- Seleccione -"
                        >
                            <el-option
                                v-for="item in listProductos"
                                :key="item.id"
                                :value="item.id"
                                :label="`${item.codigo} - ${item.nombre}`"
                            ></el-option
                        ></el-select>
                        <ul
                            v-if="form.errors?.producto_id"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.producto_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Cantidad</label>
                        <input
                            type="number"
                            step="1"
                            min="1"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.cantidad,
                            }"
                            v-model="form.cantidad"
                            autosize
                        />
                        <ul
                            v-if="form.errors?.cantidad"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.cantidad }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Descripción</label>
                        <el-input
                            type="textarea"
                            :class="{
                                'parsley-error': form.errors?.descripcion,
                            }"
                            v-model="form.descripcion"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.descripcion"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.descripcion }}
                            </li>
                        </ul>
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
                class="btn btn-primary"
                :disabled="enviando"
                @click.prevent="enviarFormulario"
                v-html="textBtn"
            ></button>
        </template>
    </MiModal>
</template>
