<script>
import "@/assets/css/variables.css";
import Login from "@/Layouts/Login.vue";
import TerminosCondiciones from "./TerminosCondiciones.vue";
import { onMounted, ref, computed } from "vue";
export default {
    layout: Login,
};
</script>
<script setup>
import { Head, Link, useForm, usePage, router } from "@inertiajs/vue3";

import { useConfiguracion } from "@/composables/configuracion/useConfiguracion";
const { props } = usePage();
const { oConfiguracion } = useConfiguracion();
const form = useForm({
    nombre: "",
    paterno: "",
    materno: "",
    ci: "",
    complemento: "",
    ci_exp: "",
    fono: "",
    dpto_residencia: "",
    email: "",
    foto_ci_anverso: "",
    foto_ci_reverso: "",
    banco: "",
    nro_cuenta: "",
    moneda: "BOLIVIANOS",
    password: "",
    password_confirmation: "",
    terminos: false,
});

const muestra_password = ref(false);
const muestra_password2 = ref(false);

const errors = ref([]);

const listExpedido = ref([
    { value: "LP", label: "La Paz" },
    { value: "CB", label: "Cochabamba" },
    { value: "SC", label: "Santa Cruz" },
    { value: "CH", label: "Chuquisaca" },
    { value: "OR", label: "Oruro" },
    { value: "PT", label: "Potosi" },
    { value: "TJ", label: "Tarija" },
    { value: "PD", label: "Pando" },
    { value: "BN", label: "Beni" },
]);

const listUbicacions = ref([
    { value: "LA PAZ", label: "La Paz" },
    { value: "COCHABAMBA", label: "Cochabamba" },
    { value: "SANTA CRUZ", label: "Santa Cruz" },
    { value: "CHUQUISACA", label: "Chuquisaca" },
    { value: "ORURO", label: "Oruro" },
    { value: "POTOSI", label: "Potosi" },
    { value: "TARIJA", label: "Tarija" },
    { value: "PANDO", label: "Pando" },
    { value: "BENI", label: "Beni" },
]);

const listBancos = ref([
    "BANCO NACIONAL DE BOLIVIA S.A.",
    "BANCO MERCANTIL SANTA CRUZ S.A.",
    "BANCO BISA S.A.",
    "BANCO DE CRÉDITO DE BOLIVIA S.A.",
    "BANCO ECONÓMICO S.A.",
    "BANCO GANADERO S.A.",
    "BANCO SOLIDARIO S.A.",
    "BANCO DE LA NACIÓN ARGENTINA",
    "BANCO PARA EL FOMENTO A INICIATIVAS ECONÓMICAS S.A.",
    "BANCO FORTALEZA S.A.",
    "BANCO PRODEM S.A.",
    "BANCO PYME DE LA COMUNIDAD S.A.",
    "BANCO PYME ECOFUTURO S.A.",
    "BANCO DE DESARROLLO PRODUCTIVO S.A.M.",
    "BANCO UNIÓN S.A.",
]);

var url_assets = "";
var url_principal = "";

const validando = ref(false);
const validado = ref(false);
const muestraCheck = ref(false);
const modal_dialog_tc = ref(false);

const validarForm1 = () => {
    validando.value = true;

    axios
        .post(route("registro.validaForm1"), form.data())
        .then((response) => {
            muestraCheck.value = true;
            form.usuario = form.email;
            setTimeout(() => {
                muestraCheck.value = false;
                validando.value = false;
                validado.value = true;
            }, 1500);
        })
        .catch((error) => {
            console.log(error.response);
            if (error.response.data.errors) {
                const errors = error.response.data.errors;
                form.errors = {};
                for (const field in errors) {
                    if (errors.hasOwnProperty(field)) {
                        form.errors[field] = errors[field][0]; // Asignar solo el primer error
                    }
                }
            }
            muestraCheck.value = false;
            validando.value = false;
            validado.value = false;
        });
};

function cargaArchivo(e, key) {
    const file = e.target.files[0];
    if (file) {
        form[key] = file;
    } else {
        form[key] = "";
    }
}

const volverAForm1 = () => {
    muestraCheck.value = false;
    validado.value = false;
};

const txtBtnValidar = computed(() => {
    if (muestraCheck.value) {
        return `Correcto <i class="text-success fa fa-check-circle"></i>`;
    }

    if (validando.value) {
        return `Validando <i class="fa fa-spinner fa-spin"></i>`;
    }

    return `Validar <i class="fa fa-check"></i>`;
});

const enviando = ref(false);
const submit = () => {
    if (validado.value) {
        console.log(validado.value);
        enviando.value = true;
        let config = {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        };
        let formdata = new FormData();
        formdata.append("nombre", form.nombre);
        formdata.append("paterno", form.paterno);
        formdata.append("materno", form.materno);
        formdata.append("ci", form.ci);
        formdata.append("complemento", form.complemento);
        formdata.append("ci_exp", form.ci_exp);
        formdata.append("fono", form.fono);
        formdata.append("dpto_residencia", form.dpto_residencia);
        formdata.append("email", form.email);
        formdata.append("foto_ci_anverso", form.foto_ci_anverso);
        formdata.append("foto_ci_reverso", form.foto_ci_reverso);
        formdata.append("banco", form.banco);
        formdata.append("nro_cuenta", form.nro_cuenta);
        formdata.append("moneda", form.moneda);
        formdata.append("password", form.password);
        formdata.append("password_confirmation", form.password_confirmation);
        formdata.append("terminos", form.terminos);
        axios
            .post(route("register"), form, config)
            .then((response) => {
                window.location = route("portal.index");
            })
            .catch((error) => {
                enviando.value = false;
                if (error.response.data.errors) {
                    const errors = error.response.data.errors;
                    form.errors = {};
                    for (const field in errors) {
                        if (errors.hasOwnProperty(field)) {
                            form.errors[field] = errors[field][0]; // Asignar solo el primer error
                        }
                    }
                } else {
                    Swal.fire({
                        icon: "info",
                        title: "Error",
                        text: `${error.response.data.message}`,
                        confirmButtonColor: "#3085d6",
                        confirmButtonText: `Aceptar`,
                    });
                }
            });
        // form.post(route("register"), {
        //     onSuccess: () => {
        //         router.get(route("portal.index"));
        //         window.location.reload();
        //         setTimeout(() => {
        //             enviando.value = false;
        //         }, 1000);
        //     },
        //     onFinish: () => {
        //         setTimeout(() => {
        //             enviando.value = false;
        //         }, 1000);
        //         form.reset("password");
        //         form.reset("password_confirmation");
        //     },
        // });
    }
};

const verTerminosCondiciones = () => {
    modal_dialog_tc.value = true;
};

onMounted(() => {
    url_assets = props.url_assets;
    url_principal = props.url_principal;
});
</script>

<template>
    <div>
        <Head title="Registro"></Head>
        <div class="loading" v-if="enviando">
            <i class="fa fa-spinner fa-spin fa-3x text-blue"></i>
        </div>
        <TerminosCondiciones
            :open_dialog="modal_dialog_tc"
            @cerrar-dialog="modal_dialog_tc = false"
        ></TerminosCondiciones>
        <div class="container-fluid contenedor_login">
            <div class="row">
                <div
                    class="col-md-6 offset-md-3 col-lg-4 offset-lg-4 col-xl-3 offset-xl-4"
                >
                    <div class="card my-5">
                        <div class="card-header text-center">
                            <img
                                :src="oConfiguracion.url_logo"
                                alt="Logo"
                                class="logo_login"
                                width="100px"
                                lazy
                            />
                            <h5 class="w-100 text-center h4 text-dark mt-2">
                                <i class="fa fa-edit"></i> Registro
                            </h5>
                        </div>
                        <div class="card-body bg-principal">
                            <form @submit.prevent="submit()">
                                <div class="row" v-show="!validado">
                                    <div class="col-12">
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="nombre"
                                                class="form-control"
                                                placeholder="Nombre(s)"
                                                v-model="form.nombre"
                                                autofocus
                                            />
                                            <label class="ml-1 rounded"
                                                >Nombre(s)*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.nombre"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.nombre
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="paterno"
                                                class="form-control"
                                                placeholder="Apellido Paterno"
                                                v-model="form.paterno"
                                            />
                                            <label class="ml-1 rounded"
                                                >Apellido Paterno*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.paterno"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.paterno
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="materno"
                                                class="form-control"
                                                placeholder="Apellido Materno"
                                                v-model="form.materno"
                                            />
                                            <label class="ml-1 rounded"
                                                >Apellido Materno</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.materno"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.materno
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="ci"
                                                class="form-control"
                                                placeholder="Documento de identidad"
                                                v-model="form.ci"
                                            />
                                            <label class="ml-1 rounded"
                                                >Documento de identidad*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.ci"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.ci
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="complemento"
                                                class="form-control"
                                                placeholder="Complemento"
                                                v-model="form.complemento"
                                            />
                                            <label class="ml-1 rounded"
                                                >Complemento</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.complemento"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.complemento
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <select
                                                name="ci_exp"
                                                class="form-control"
                                                placeholder="Lugar de expedición"
                                                v-model="form.ci_exp"
                                            >
                                                <option value="">
                                                    - Seleccione -
                                                </option>
                                                <option
                                                    v-for="item in listExpedido"
                                                    :value="item.value"
                                                >
                                                    {{ item.label }}
                                                </option>
                                            </select>
                                            <label class="ml-1 rounded"
                                                >Lugar de expedición*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.ci_exp"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.ci_exp
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="fono"
                                                class="form-control"
                                                placeholder="Número de Celular"
                                                v-model="form.fono"
                                            />
                                            <label class="ml-1 rounded"
                                                >Número de Celular*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.fono"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.fono
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <select
                                                name="dpto_residencia"
                                                class="form-control"
                                                placeholder="Departamento donde resides"
                                                v-model="form.dpto_residencia"
                                            >
                                                <option value="">
                                                    - Seleccione -
                                                </option>
                                                <option
                                                    v-for="item in listUbicacions"
                                                    :value="item.value"
                                                >
                                                    {{ item.label }}
                                                </option>
                                            </select>
                                            <label class="ml-1 rounded"
                                                >Departamento donde
                                                resides*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.dpto_residencia"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.dpto_residencia
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="email"
                                                name="email"
                                                class="form-control"
                                                placeholder="Correo electrónico"
                                                v-model="form.email"
                                            />
                                            <label class="ml-1 rounded"
                                                >Correo electrónico*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.email"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.email
                                                }}</strong>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" v-show="validado">
                                    <div class="col-12">
                                        <h4
                                            class="card-title w-100 text-center mb-0"
                                        >
                                            - Datos complementarios -
                                        </h4>
                                    </div>
                                    <div class="col-12 mt-2 border-bottom">
                                        <div class="form-group">
                                            <label class="ml-1 rounded"
                                                >Foto del C.I. anverso(PDF o
                                                Imagen)*</label
                                            >
                                            <input
                                                type="file"
                                                name="foto_ci_anverso"
                                                class="form-control border-0"
                                                placeholder="Foto del C.I. anverso(PDF o Imagen)"
                                                @change="
                                                    cargaArchivo(
                                                        $event,
                                                        'foto_ci_anverso',
                                                    )
                                                "
                                            />
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.foto_ci_anverso"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.foto_ci_anverso
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div class="form-group mb-2">
                                            <label class="ml-1 rounded"
                                                >Foto del C.I. reverso(PDF o
                                                Imagen)*</label
                                            >
                                            <input
                                                type="file"
                                                name="foto_ci_reverso"
                                                class="form-control border-0"
                                                placeholder="Foto del C.I. reverso (PDF o Imagen)"
                                                @change="
                                                    cargaArchivo(
                                                        $event,
                                                        'foto_ci_reverso',
                                                    )
                                                "
                                            />
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.foto_ci_reverso"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.foto_ci_reverso
                                                }}</strong>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <h4
                                            class="card-title w-100 text-center mt-2"
                                        >
                                            - Datos para Devolución de Garantías
                                            -
                                        </h4>
                                    </div>
                                    <div class="col-12 border-bottom pb-3">
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <select
                                                name="banco"
                                                class="form-control"
                                                placeholder="Banco"
                                                v-model="form.banco"
                                            >
                                                <option value="">
                                                    - Seleccione -
                                                </option>
                                                <option
                                                    v-for="item in listBancos"
                                                    :value="item"
                                                >
                                                    {{ item }}
                                                </option>
                                            </select>
                                            <label class="ml-1 rounded"
                                                >Banco*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.banco"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.banco
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="nro_cuenta"
                                                class="form-control"
                                                placeholder="Número de cuenta"
                                                v-model="form.nro_cuenta"
                                            />
                                            <label class="ml-1 rounded"
                                                >Número de cuenta*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.nro_cuenta"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.nro_cuenta
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.moneda"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.moneda
                                                }}</strong>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <h4
                                            class="card-title w-100 text-center mt-3"
                                        >
                                            - Crea tu usuario -
                                        </h4>
                                    </div>
                                    <div class="col-12">
                                        <div
                                            class="form-floating mt-3 bg-white rounded"
                                        >
                                            <input
                                                type="text"
                                                name="usuario"
                                                class="form-control"
                                                placeholder="Nombre de usuario"
                                                v-model="form.usuario"
                                                readonly
                                            />
                                            <label class="ml-1 rounded"
                                                >Nombre de usuario*</label
                                            >
                                        </div>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.usuario"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.usuario
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div class="mt-3">
                                            <div
                                                class="input-group form-floating"
                                            >
                                                <input
                                                    :type="
                                                        muestra_password
                                                            ? 'text'
                                                            : 'password'
                                                    "
                                                    name="password"
                                                    class="form-control"
                                                    v-model="form.password"
                                                    autocomplete="false"
                                                    placeholder="Contraseña"
                                                />

                                                <label
                                                    class="items-center text-dark ml-1 rounded"
                                                    style="z-index: 100"
                                                    >Contraseña</label
                                                >
                                                <div class="input-group-append">
                                                    <button
                                                        class="btn btn-default"
                                                        type="button"
                                                        @click="
                                                            muestra_password =
                                                                !muestra_password
                                                        "
                                                    >
                                                        <i
                                                            class="fa"
                                                            :class="[
                                                                muestra_password
                                                                    ? 'fa-eye'
                                                                    : 'fa-eye-slash',
                                                            ]"
                                                        ></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="text-xs">
                                            La contraseña debe tener al menos 8
                                            caracteres, incluyendo una letra
                                            mayúscula, un número y un símbolo
                                            (@$!%*?&).
                                        </p>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.password"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.password
                                                }}</strong>
                                            </span>
                                        </div>
                                        <div>
                                            <div
                                                class="input-group mb-3 form-floating mb-2"
                                            >
                                                <input
                                                    :type="
                                                        muestra_password2
                                                            ? 'text'
                                                            : 'password'
                                                    "
                                                    name="password_confirmation"
                                                    class="form-control"
                                                    placeholder="Confirmar Contraseña"
                                                    v-model="
                                                        form.password_confirmation
                                                    "
                                                    autocomplete="false"
                                                />
                                                <label
                                                    class="ml-1 rounded"
                                                    style="z-index: 100"
                                                    >Confirmar Contraseña</label
                                                >
                                                <button
                                                    class="btn btn-default"
                                                    type="button"
                                                    @click="
                                                        muestra_password2 =
                                                            !muestra_password2
                                                    "
                                                >
                                                    <i
                                                        class="fa"
                                                        :class="[
                                                            muestra_password2
                                                                ? 'fa-eye'
                                                                : 'fa-eye-slash',
                                                        ]"
                                                    ></i>
                                                </button>
                                            </div>
                                        </div>
                                        <p class="text-sm w-100 text-center">
                                            <span class="text-danger">*</span>
                                            El titular de cuenta debe ser quien
                                            se registra en el presente
                                            formulario
                                        </p>
                                        <label
                                            for="terminos"
                                            class="d-block mt-15px d-flex align-center gap-1 justify-content-center"
                                        >
                                            <input
                                                type="checkbox"
                                                id="terminos"
                                                v-model="form.terminos"
                                            />
                                            <span class="mx-1">Acepto los</span>
                                            <a
                                                href="#"
                                                class=""
                                                @click.prevent="
                                                    verTerminosCondiciones
                                                "
                                                >términos y condiciones</a
                                            >*
                                        </label>
                                        <div
                                            class="w-100"
                                            v-if="form.errors?.terminos"
                                        >
                                            <span
                                                class="invalid-feedback text-danger"
                                                style="display: block"
                                                role="alert"
                                            >
                                                <strong>{{
                                                    form.errors.terminos
                                                }}</strong>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <button
                                        v-show="validado"
                                        type="submit"
                                        class="btn btn-primary w-100 mb-2"
                                        :disabled="enviando"
                                    >
                                        Finalizar Registro
                                        <i class="fa fa-arrow-right"></i>
                                    </button>
                                    <button
                                        v-show="validado"
                                        type="button"
                                        class="btn btn-default w-100"
                                        @click="volverAForm1"
                                    >
                                        <i class="fa fa-arrow-left"></i> Volver
                                    </button>
                                    <button
                                        @click="validarForm1"
                                        v-show="!validado"
                                        type="button"
                                        class="btn w-100"
                                        :class="{
                                            'btn-default': !muestraCheck,
                                            'btn-success': muestraCheck,
                                        }"
                                        v-html="txtBtnValidar"
                                    ></button>
                                </div>
                                <div class="mt-2">
                                    <Link
                                        :href="route('login')"
                                        class="text-muted text-sm d-block w-100 text-center"
                                        ><u>Ya tengo una cuenta</u></Link
                                    >
                                </div>
                                <div class="mt-2">
                                    <a
                                        :href="route('portal.index')"
                                        class="text-muted text-sm text-decoration-underline d-block w-100 text-center"
                                        ><i class="fa fa-arrow-left"></i> Volver
                                        al portal</a
                                    >
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
body #app .contenedor_login {
    min-height: 100vh;
    width: 100vw;
    background-color: var(--bgGrayLight);
}
</style>
