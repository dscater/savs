<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
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

const { oCliente, limpiarCliente } = useClientes();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
const form = useForm(oCliente.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form.id = oCliente.value.id;
            form.nombre = oCliente.value.nombre;
            form.nit_ci = oCliente.value.nit_ci;
            form.cel = oCliente.value.cel;
            form.correo = oCliente.value.correo;
            form.fecha_registro = oCliente.value.fecha_registro;
            form._method = oCliente.value._method;
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
        ? `<i class="fa fa-plus"></i> Nuevo Cliente`
        : `<i class="fa fa-edit"></i> Editar Cliente`;
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
            ? route("clientes.store")
            : route("clientes.update", form.id);

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
            limpiarCliente();
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
                        <label class="required">Nombre/Razón Social</label>
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
                        <label class="">NIT/C.I.</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.nit_ci,
                            }"
                            v-model="form.nit_ci"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.nit_ci"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.nit_ci }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Teléfono/Celular</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.cel,
                            }"
                            v-model="form.cel"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.cel"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.cel }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Correo electrónico</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.correo,
                            }"
                            v-model="form.correo"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.correo"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.correo }}
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
