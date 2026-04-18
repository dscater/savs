<script>
import Portal from "@/Layouts/Portal.vue";
import Publicacion from "@/Components/Publicacion.vue";
export default {
    layout: Portal,
};
</script>

<script setup>
import { ref, onMounted, computed } from "vue";
import { router, useForm, usePage, Head, Link } from "@inertiajs/vue3";
import { useUser } from "@/composables/useUser";
onMounted(() => {});

const props = defineProps({
    user: {
        type: Object,
    },
});

const url_aux = ref(props.user.url_foto);

const url_foto_str = ref("");
const foto = ref(null);
const imagen_cargada = ref(false);

function cargaImagen(e) {
    foto.value = e.target.files[0];
    url_foto_str.value = URL.createObjectURL(foto.value);
    props.user.url_foto = url_foto_str.value;
    imagen_cargada.value = true;
}

const { getUser } = useUser();

function guardarImagen() {
    router.post(
        route("profile.update_foto"),
        { foto: foto.value, _method: "patch" },
        {
            forceFormData: true,
            onSuccess: () => {
                getUser();
                Swal.fire({
                    icon: "success",
                    title: "Correcto",
                    text: `Imagen actualizada`,
                    confirmButtonColor: "#3085d6",
                    // confirmButtonText: `Aceptar`,
                    showConfirmButton: false,
                });
                imagen_cargada.value = false;
                setTimeout(() => {
                    window.location.reload();
                }, 1000);
            },
            onError: (err) => {
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    text: `${
                        flash.error
                            ? flash.error
                            : "Tienes errores en el formulario"
                    }`,
                    confirmButtonColor: "#3085d6",
                    confirmButtonText: `Aceptar`,
                });
                console.log(err);
            },
        },
    );
}

function cancelarImagen() {
    imagen_cargada.value = false;
    url_foto_str.value = url_aux.value;
    props.user.url_foto = url_aux.value;
}

const form = useForm({
    password_actual: "",
    password: "",
    password_confirmation: "",
    _method: "patch",
});

const { props: props_page, flash } = usePage();
const user = ref(props_page.auth?.user);
const url_asset = ref(props_page.url_assets);

const enviaFormulario = () => {
    form.errors = {};
    form.post(route("profile.update"), {
        preserveScroll: true,
        onSuccess: () => {
            form.clearErrors();
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            form.reset();
        },
        onError: (err) => {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : "Tienes errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            console.log(err);
        },
    });
};

// INFORMACION
let formInfo = useForm({
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
    moneda: "",
    password: "",
    password_confirmation: "",
});
const oCliente = ref(null);

const errors = ref([]);

const listExpedido = [
    { value: "LP", label: "La Paz" },
    { value: "CB", label: "Cochabamba" },
    { value: "SC", label: "Santa Cruz" },
    { value: "CH", label: "Chuquisaca" },
    { value: "OR", label: "Oruro" },
    { value: "PT", label: "Potosi" },
    { value: "TJ", label: "Tarija" },
    { value: "PD", label: "Pando" },
    { value: "BN", label: "Beni" },
];

const listUbicacions = [
    { value: "LA PAZ", label: "La Paz" },
    { value: "COCHABAMBA", label: "Cochabamba" },
    { value: "SANTA CRUZ", label: "Santa Cruz" },
    { value: "CHUQUISACA", label: "Chuquisaca" },
    { value: "ORURO", label: "Oruro" },
    { value: "POTOSI", label: "Potosi" },
    { value: "TARIJA", label: "Tarija" },
    { value: "PANDO", label: "Pando" },
    { value: "BENI", label: "Beni" },
];

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

function cargaArchivo(e, key) {
    const file = e.target.files[0];
    if (file) {
        formInfo[key] = file;
    } else {
        formInfo[key] = "";
    }
}
const verTerminosCondiciones = () => {
    modal_dialog_tc.value = true;
};

const submit = () => {
    formInfo.post(route("profile.updateInfoCliente"), {
        onSuccess: () => {
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `Información actualizada`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        },
        onFinish: () => {},
    });
};

const getCliente = () => {
    axios.get(route("profile.getInfoCliente")).then((response) => {
        oCliente.value = response.data;
        formInfo.nombre = response.data.nombre;
        formInfo.paterno = response.data.paterno;
        formInfo.materno = response.data.materno;
        formInfo.ci = response.data.user_dato.ci;
        formInfo.complemento = response.data.user_dato.complemento;
        formInfo.ci_exp = response.data.user_dato.ci_exp;
        formInfo.fono = response.data.fono;
        formInfo.dpto_residencia = response.data.user_dato.dpto_residencia;
        formInfo.email = response.data.user_dato.email;
        formInfo.foto_ci_anverso = response.data.user_dato.foto_ci_anverso;
        formInfo.foto_ci_reverso = response.data.user_dato.foto_ci_reverso;
        formInfo.banco = response.data.user_dato.banco;
        formInfo.nro_cuenta = response.data.user_dato.nro_cuenta;
    });
};

onMounted(() => {
    url_foto_str.value = props.user.url_foto;
    getCliente();
    url_assets = props.url_assets;
    url_principal = props.url_principal;
});
</script>

<template>
    <Head title="Perfil"></Head>

    <div class="container">
        <div class="row mt-3">
            <div class="col-12">
                <h4 class="h3 pl-3 font-weight-bold">Mi perfil</h4>
            </div>
        </div>
        <div class="row">
            <div class="col-md-7">
                <form
                    @submit.prevent="submit()"
                    class="bg-principal-portal2 p-3 login-content"
                >
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">
                                <i class="fa fa-user"></i> Datos Personales
                            </h4>
                        </div>
                        <div class="card-body pt-1">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-floating mt-3">
                                        <input
                                            type="text"
                                            name="nombre"
                                            class="form-control"
                                            placeholder="Nombre(s)"
                                            v-model="formInfo.nombre"
                                            readonly
                                        />
                                        <label for="name" class="pl-2"
                                            >Nombre(s)*</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.nombre"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.nombre
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <input
                                            type="text"
                                            name="paterno"
                                            class="form-control"
                                            placeholder="Apellido Paterno"
                                            v-model="formInfo.paterno"
                                            readonly
                                        />
                                        <label for="name" class="pl-2"
                                            >Apellido Paterno*</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.paterno"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.paterno
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <input
                                            type="text"
                                            name="materno"
                                            class="form-control"
                                            placeholder="Apellido Materno"
                                            v-model="formInfo.materno"
                                            readonly
                                        />
                                        <label for="name" class="pl-2"
                                            >Apellido Materno</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.materno"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.materno
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <input
                                            type="text"
                                            name="ci"
                                            class="form-control"
                                            placeholder="Documento de identidad"
                                            v-model="formInfo.ci"
                                            readonly
                                        />
                                        <label for="name" class="pl-2"
                                            >Documento de identidad*</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.ci"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.ci
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <input
                                            type="text"
                                            name="complemento"
                                            class="form-control"
                                            placeholder="Complemento"
                                            v-model="formInfo.complemento"
                                            readonly
                                        />
                                        <label for="name" class="pl-2"
                                            >Complemento</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.complemento"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.complemento
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <input
                                            type="text"
                                            name="complemento"
                                            class="form-control"
                                            placeholder="Complemento"
                                            v-model="formInfo.ci_exp"
                                            readonly
                                        />
                                        <!-- <select
                                    name="ci_exp"
                                    class="form-control "
                                    placeholder="Lugar de expedición"
                                    v-model="formInfo.ci_exp"
                                    readonly
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listExpedido"
                                        :value="item.value"
                                    >
                                        {{ item.label }}
                                    </option>
                                </select> -->
                                        <label for="name" class="pl-2"
                                            >Lugar de expedición*</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.ci_exp"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.ci_exp
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <input
                                            type="text"
                                            name="fono"
                                            class="form-control"
                                            placeholder="Número de Celular"
                                            v-model="formInfo.fono"
                                        />
                                        <label for="name" class="pl-2"
                                            >Número de Celular*</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.fono"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.fono
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <select
                                            name="dpto_residencia"
                                            class="form-control"
                                            placeholder="Departamento donde resides"
                                            v-model="formInfo.dpto_residencia"
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
                                        <label for="name" class="pl-2"
                                            >Departamento donde recides*</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.dpto_residencia"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.dpto_residencia
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-floating mt-3">
                                        <input
                                            type="email"
                                            name="email"
                                            class="form-control"
                                            placeholder="Correo electrónico"
                                            v-model="formInfo.email"
                                        />
                                        <label class="pl-2"
                                            >Correo electrónico*</label
                                        >
                                    </div>
                                    <div
                                        class="w-100"
                                        v-if="formInfo.errors?.email"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.email
                                            }}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">
                                <i class="fa fa-list"></i> Devolución de
                                Garantías
                            </h4>
                        </div>
                        <div class="card-body">
                            <div class="col-12">
                                <div class="form-floating mb-3">
                                    <select
                                        name="banco"
                                        class="form-control"
                                        placeholder="Banco"
                                        v-model="formInfo.banco"
                                    >
                                        <option value="">- Seleccione -</option>
                                        <option
                                            v-for="item in listBancos"
                                            :value="item"
                                        >
                                            {{ item }}
                                        </option>
                                    </select>
                                    <label class="pl-2 mx-1">Banco*</label>
                                </div>
                                <div
                                    class="w-100"
                                    v-if="formInfo.errors?.banco"
                                >
                                    <span
                                        class="invalid-feedback alert alert-danger"
                                        style="display: block"
                                        role="alert"
                                    >
                                        <strong>{{
                                            formInfo.errors.banco
                                        }}</strong>
                                    </span>
                                </div>
                                <div class="form-floating mb-2">
                                    <input
                                        type="text"
                                        name="nro_cuenta"
                                        class="form-control"
                                        placeholder="Número de cuenta"
                                        v-model="formInfo.nro_cuenta"
                                    />
                                    <label for="name" class="pl-2 mx-1"
                                        >Número de cuenta*</label
                                    >
                                </div>
                                <div
                                    class="w-100"
                                    v-if="formInfo.errors?.nro_cuenta"
                                >
                                    <span
                                        class="invalid-feedback alert alert-danger"
                                        style="display: block"
                                        role="alert"
                                    >
                                        <strong>{{
                                            formInfo.errors.nro_cuenta
                                        }}</strong>
                                    </span>
                                </div>
                                <div
                                    class="w-100"
                                    v-if="formInfo.errors?.moneda"
                                >
                                    <span
                                        class="invalid-feedback alert alert-danger"
                                        style="display: block"
                                        role="alert"
                                    >
                                        <strong>{{
                                            formInfo.errors.moneda
                                        }}</strong>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">
                                <i class="fa fa-id-card"></i> Datos
                                complementarios
                            </h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group mb-2">
                                        <label class="pl-2"
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
                                        v-if="formInfo.errors?.foto_ci_anverso"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.foto_ci_anverso
                                            }}</strong>
                                        </span>
                                    </div>
                                    <div class="form-group mb-2">
                                        <label class="pl-2"
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
                                        v-if="formInfo.errors?.foto_ci_reverso"
                                    >
                                        <span
                                            class="invalid-feedback alert alert-danger"
                                            style="display: block"
                                            role="alert"
                                        >
                                            <strong>{{
                                                formInfo.errors.foto_ci_reverso
                                            }}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="col-12 mt-3">
                            <button
                                class="btn btn-primary w-100"
                                @click="actualizaInformacion"
                            >
                                <i class="fa fa-save"></i> Guardar cambios
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md-5 pt-2">
                <div class="row d-block">
                    <div clas="col-12">
                        <div class="info_foto">
                            <img class="image mb-1" :src="url_foto_str" />
                            <label
                                v-if="!imagen_cargada"
                                class="bg-principal p-2 rounded cursor-pointer"
                                for="file_foto"
                                ><b>Cambiar foto</b
                                ><input
                                    type="file"
                                    id="file_foto"
                                    accept="image/png, image/gif, image/jpeg"
                                    hidden
                                    @change="cargaImagen"
                            /></label>
                            <button
                                v-if="imagen_cargada"
                                class="w-50 mb-1 btn btn-success btn text-sm"
                                @click="guardarImagen"
                            >
                                Guardar cambios
                            </button>
                            <button
                                v-if="imagen_cargada"
                                class="w-50 mb-1 btn btn-default btn-sm"
                                @click="cancelarImagen"
                            >
                                Cancelar
                            </button>
                        </div>
                    </div>
                    <div class="col-12">
                        <form class="">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">
                                        <i class="fa fa-key"></i> Contraseña
                                    </h4>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-floating mt-3">
                                                <input
                                                    type="text"
                                                    name="usuario"
                                                    class="form-control"
                                                    placeholder="Nombre de usuario"
                                                    v-model="formInfo.email"
                                                    readonly
                                                />
                                                <label for="name" class="pl-2"
                                                    >Nombre de usuario</label
                                                >
                                            </div>
                                            <div class="form-floating mt-3">
                                                <input
                                                    type="password"
                                                    name="usuario"
                                                    class="form-control"
                                                    placeholder="Contraseña actual"
                                                    v-model="
                                                        form.password_actual
                                                    "
                                                    autocomplete="false"
                                                />
                                                <label for="name" class="pl-2"
                                                    >Contraseña actual*</label
                                                >
                                            </div>
                                            <div
                                                class="w-100"
                                                v-if="
                                                    form.errors?.password_actual
                                                "
                                            >
                                                <span
                                                    class="invalid-feedback alert alert-danger"
                                                    style="display: block"
                                                    role="alert"
                                                >
                                                    <strong>{{
                                                        form.errors
                                                            .password_actual
                                                    }}</strong>
                                                </span>
                                            </div>
                                            <div class="form-floating mt-3">
                                                <input
                                                    type="password"
                                                    name="usuario"
                                                    class="form-control"
                                                    placeholder="Nueva contraseña"
                                                    v-model="form.password"
                                                    autocomplete="false"
                                                />
                                                <label for="name" class="pl-2"
                                                    >Nueva contraseña*</label
                                                >
                                            </div>
                                            <p
                                                class="text-muted text-xs"
                                                style="font-size: 0.8em"
                                            >
                                                La contraseña debe tener al
                                                menos 8 caracteres, incluyendo
                                                una letra mayúscula, un número y
                                                un símbolo (@$!%*?&).
                                            </p>
                                            <div
                                                class="w-100"
                                                v-if="form.errors?.password"
                                            >
                                                <span
                                                    class="invalid-feedback alert alert-danger"
                                                    style="display: block"
                                                    role="alert"
                                                >
                                                    <strong>{{
                                                        form.errors.password
                                                    }}</strong>
                                                </span>
                                            </div>
                                            <div class="form-floating">
                                                <input
                                                    type="password"
                                                    name="usuario"
                                                    class="form-control"
                                                    placeholder="Repite la contraseña"
                                                    v-model="
                                                        form.password_confirmation
                                                    "
                                                    autocomplete="false"
                                                />
                                                <label for="name" class="pl-2"
                                                    >Repite la
                                                    contraseña*</label
                                                >
                                            </div>
                                            <div
                                                class="w-100"
                                                v-if="
                                                    form.errors
                                                        ?.password_confirmation
                                                "
                                            >
                                                <span
                                                    class="invalid-feedback alert alert-danger"
                                                    style="display: block"
                                                    role="alert"
                                                >
                                                    <strong>{{
                                                        form.errors
                                                            .password_confirmation
                                                    }}</strong>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-3">
                                            <button
                                                type="button"
                                                class="btn btn-primary w-100"
                                                @click="enviaFormulario"
                                            >
                                                <i class="fa fa-sync"></i>
                                                Actualizar contraseña
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.login-content .form-floating label {
    margin-left: 0px;
}
.info_foto {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.info_foto img.image {
    width: 150px;
    height: 150px;
    object-fit: cover;
    border-radius: 50%;
    border: solid 1px gray;
}
</style>
