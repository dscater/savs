<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useProductos } from "@/composables/productos/useProductos";
import { watch, ref, computed, onMounted, nextTick } from "vue";
import { QuillEditor } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
import MiDropZone from "@/Components/MiDropZone.vue";
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

const { oProducto, limpiarProducto } = useProductos();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = useForm(oProducto.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarCategorias();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oProducto.value);
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

const listCategorias = ref([]);
const cargarCategorias = () => {
    axios.get(route("categorias.listado")).then((response) => {
        listCategorias.value = response.data.categorias;
    });
};

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Producto`
        : `<i class="fa fa-edit"></i> Editar Producto`;
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
        accion_form.value == 0
            ? route("productos.store")
            : route("productos.update", form.id);

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
            limpiarProducto();
            emits("envio-formulario");
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                const error =
                    "Existen errores en el formulario, por favor verifique";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
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

const detectaArchivos = (files) => {
    form.producto_imagens = files;
};

const detectaEliminados = (eliminados) => {
    form.eliminados_imagens = eliminados;
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
                        <label class="required">Seleccionar Categoría</label>
                        <el-select
                            :class="{
                                'parsley-error': form.errors?.categoria_id,
                            }"
                            placeholder="Seleccionar Categoría"
                            v-model="form.categoria_id"
                            filterable
                        >
                            <el-option
                                v-for="item in listCategorias"
                                :key="item.id"
                                :label="item.nombre"
                                :value="item.id"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.categoria_id"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.categoria_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Nombre de Producto</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.nombre,
                            }"
                            v-model="form.nombre"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.nombre"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.nombre }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Precio del Producto Bs.</label>
                        <input
                            type="number"
                            step="0.01"
                            min="0"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.precio,
                            }"
                            v-model="form.precio"
                        />
                        <ul
                            v-if="form.errors?.precio"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.precio }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-12 mt-2">
                        <label class="required">Cargar Imágenes</label>
                        <MiDropZone
                            :files="form.producto_imagens"
                            :maximo="50"
                            @UpdateFiles="detectaArchivos"
                            @addEliminados="detectaEliminados"
                        ></MiDropZone>
                        <ul
                            v-if="form.errors?.producto_imagens"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.producto_imagens }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-12 mt-3">
                        <label class="required">Descripción del producto</label>
                        <QuillEditor
                            v-model:content="form.descripcion"
                            contentType="html"
                            theme="snow"
                        />
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
