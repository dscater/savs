<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useSubastas } from "@/composables/subastas/useSubastas";
import {
    watch,
    ref,
    computed,
    defineEmits,
    onMounted,
    nextTick,
    onBeforeMount,
} from "vue";
import axios from "axios";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
import SliderImagenes from "@/Components/SliderImagenes.vue";

import { QuillEditor } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
const props = defineProps({
    subasta: {
        type: Object,
        default: null,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
});

const { oSubasta, setSubasta, limpiarSubasta } = useSubastas();
const accion_form = ref(props.accion_formulario);
const enviando = ref(false);
let form = useForm(props.subasta);
watch(
    () => props.subasta,
    (newValue) => {
        form = useForm(newValue);
        setSubasta(newValue);
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

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        accion_form.value == 0
            ? route("subastas.store")
            : route("subastas.update", form.id);

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
            limpiarSubasta();
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

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Registrar subasta`;
    }
    return `<i class="fa fa-edit"></i> Actualizar Subasta`;
});

const oProducto = ref(null);
const listProductos = ref([]);
const cargarProductos = () => {
    axios.get(route("productos.listado")).then((response) => {
        listProductos.value = response.data.productos;
    });
};

const asigarProducto = (value) => {
    oProducto.value = null;
    form.producto_id = "";
    if (!value) {
        return;
    }
    oProducto.value = listProductos.value.filter((item) => item.id == value)[0];
    form.producto_id = oProducto.value.id;
};
const listEstadoProductos = ref([
    {
        value: "NUEVO",
        label: "NUEVO",
    },
    {
        value: "SEMINUEVO",
        label: "SEMINUEVO",
    },
    {
        value: "USADO",
        label: "USADO",
    },
]);

const listEstadoPublicacion = ref([
    {
        value: 0,
        label: "SIN PUBLICAR",
    },
    {
        value: 1,
        label: "PÚBLICO",
    },
]);

onMounted(() => {
    console.log(form);
    if (form.id != 0) {
        oProducto.value = form.producto;
    }
});
onBeforeMount(() => {
    cargarProductos();
});
</script>

<template>
    <form @submit.prevent="enviarFormulario()">
        <div class="row mb-0">
            <div class="col-md-12 col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fa fa-box"></i> Datos del producto
                        </h5>
                    </div>
                    <div class="card-body pt-1">
                        <div class="row">
                            <div class="col-12">
                                <small
                                    class="text-muted text-xs font-weight-bold required"
                                    >Seleccionar Producto</small
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-boxes"></i>
                                        </span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <el-select
                                            class="el-select-input-group-right"
                                            size="large"
                                            v-model="form.producto_id"
                                            filterable
                                            clereable
                                            placeholder="Seleccionar"
                                            no-data-text="Sin resultados"
                                            no-match-text="No se encontrarón coincidencias"
                                            @change="asigarProducto"
                                        >
                                            <el-option
                                                v-for="item in listProductos"
                                                :key="item.id"
                                                :value="item.id"
                                                :label="`${item.nombre} - ${item.codigo}`"
                                            ></el-option>
                                        </el-select>
                                    </div>
                                </div>
                                <ul
                                    v-if="form.errors?.producto_id"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.producto_id }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-12 mt-2">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{
                                                oProducto
                                                    ? oProducto.codigo
                                                    : "-"
                                            }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Código
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{
                                                oProducto
                                                    ? oProducto.nombre
                                                    : "-"
                                            }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Nombre
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{
                                                oProducto
                                                    ? oProducto.categoria
                                                          ?.nombre
                                                    : "-"
                                            }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Categoría
                                        </div>
                                    </div>
                                </div>
                                <div class="row" v-if="oProducto">
                                    <div class="col-12">
                                        <slider-imagenes
                                            :imagenes="
                                                oProducto.producto_imagens
                                            "
                                            :height="'230px'"
                                        ></slider-imagenes>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12">
                                <small
                                    class="text-muted text-xs font-weight-bold required"
                                    >Seleccionar Estado</small
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-tag"></i>
                                        </span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <el-select
                                            class="el-select-input-group-right"
                                            size="large"
                                            v-model="form.estado_producto"
                                            filterable
                                            clereable
                                            placeholder="Seleccionar"
                                            no-data-text="Sin resultados"
                                            no-match-text="No se encontrarón coincidencias"
                                        >
                                            <el-option
                                                v-for="item in listEstadoProductos"
                                                :key="item.value"
                                                :value="item.value"
                                                :label="`${item.label}`"
                                            ></el-option>
                                        </el-select>
                                    </div>
                                </div>
                                <ul
                                    v-if="form.errors?.estado_producto"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.estado_producto }}
                                    </li>
                                </ul>
                            </div>

                            <div class="col-md-12 mt-3">
                                <label class="required">Descripción</label>
                                <div>
                                    <QuillEditor
                                        v-model:content="form.descripcion"
                                        contentType="html"
                                        style="height: 130px"
                                        theme="snow"
                                    />
                                </div>
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
                    </div>
                </div>
            </div>
            <div class="col-md-12 col-lg-6 pb-0">
                <div class="card mb-0">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fa fa-gavel"></i> Datos de la Subasta
                        </h5>
                    </div>
                    <div class="card-body pt-1 overflow-auto">
                        <div class="row">
                            <div class="col-md-6">
                                <small
                                    class="text-muted text-xs font-weight-bold required"
                                    >Oferta inicial Bs.</small
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-money-bill"></i>
                                        </span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <input
                                            type="number"
                                            step="0.01"
                                            min="0"
                                            class="form-control"
                                            v-model="form.monto_inicial"
                                        />
                                    </div>
                                </div>
                                <ul
                                    v-if="form.errors?.monto_inicial"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.monto_inicial }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <small
                                    class="text-muted text-xs font-weight-bold required"
                                    >Monto de garantía Bs.</small
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-money-bill"></i>
                                        </span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <input
                                            type="number"
                                            step="0.01"
                                            min="0"
                                            class="form-control"
                                            v-model="form.garantia"
                                        />
                                    </div>
                                </div>
                                <ul
                                    v-if="form.errors?.garantia"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.garantia }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <small
                                    class="text-muted text-xs font-weight-bold required"
                                    >Fecha Finalización</small
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-calendar-alt"></i>
                                        </span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <input
                                            type="date"
                                            class="form-control"
                                            v-model="form.fecha_fin"
                                        />
                                    </div>
                                </div>
                                <ul
                                    v-if="form.errors?.fecha_fin"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fecha_fin }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <small
                                    class="text-muted text-xs font-weight-bold required"
                                    >Hora Finalización</small
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-clock"></i>
                                        </span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <input
                                            type="time"
                                            class="form-control"
                                            v-model="form.hora_fin"
                                        />
                                    </div>
                                </div>
                                <ul
                                    v-if="form.errors?.hora_fin"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.hora_fin }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-12">
                                <small
                                    class="text-muted text-xs font-weight-bold required"
                                    >Publicación</small
                                >
                                <el-radio-group v-model="form.publico">
                                    <el-radio
                                        v-for="item in listEstadoPublicacion"
                                        :value="item.value"
                                        size="large"
                                        border
                                    >
                                        {{ item.label }}
                                        <i
                                            class="fa"
                                            :class="{
                                                'fa-eye-slash': item.value == 0,
                                                'fa-eye': item.value == 1,
                                            }"
                                        ></i
                                    ></el-radio>
                                </el-radio-group>
                                <ul
                                    v-if="form.errors?.publico"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.publico }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 mt-1 mb-3 text-center">
                        <button
                            type="button"
                            class="btn btn-primary w-100"
                            :disabled="enviando"
                            @click.prevent="enviarFormulario"
                            v-html="textBtn"
                        ></button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</template>
<style scoped>
span.seleccionado,
input.seleccionado {
    background-color: var(--bg4) !important;
}
</style>
