<script>
import Login from "@/Layouts/Login.vue";
import { onMounted, ref } from "vue";
export default {
    layout: Login,
};
</script>
<script setup>
import { Head, Link, router, useForm, usePage } from "@inertiajs/vue3";

import { useConfiguracion } from "@/composables/configuracion/useConfiguracion";
const propsPage = defineProps({
    recuperar_password: {
        type: Object,
        default: null,
    },
});
const { props } = usePage();
const { oConfiguracion } = useConfiguracion();
const form = useForm({
    id: propsPage.recuperar_password.id,
    cod: "",
    password: "",
    password_confirmation: "",
});

var url_assets = "";
var url_principal = "";
const muestra_password = ref(false);
const muestra_password2 = ref(false);

const submit = () => {
    axios
        .post(
            route("registrar_recuperacion", propsPage.recuperar_password.id),
            form,
        )
        .then((response) => {
            form.errors = {};
            form.reset("password");
            form.reset("password_confirmation");

            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${response.data.message}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });

            router.get(route("login"));
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

    // form.post(route("login"), {
    //     onFinish: () => {
    //         window.location.reload();
    //     },
    // });
};

onMounted(() => {
    url_assets = props.url_assets;
    url_principal = props.url_principal;
});
</script>

<template>
    <Head title="Recuperar contraseña"></Head>
    <div class="container-fluid contenedor_login">
        <div class="row">
            <div
                class="col-md-6 offset-md-3 col-lg-4 offset-lg-4 col-xl-3 offset-xl-4 my-5"
            >
                <div class="card">
                    <div class="card-header text-center">
                        <img
                            :src="oConfiguracion.url_logo"
                            alt="Logo"
                            class="logo_login"
                            width="100px"
                            lazy
                        />
                    </div>
                    <div class="card-body">
                        <form @submit.prevent="submit()">
                            <div class="form-floating mb-3">
                                <input
                                    type="text"
                                    name="cod"
                                    class="form-control"
                                    placeholder="Código de verificación"
                                    id="name"
                                    v-model="form.cod"
                                    autofocus
                                />
                                <label for="name" class="text-gray pl-2"
                                    >Ingresa el código de verificación</label
                                >
                            </div>
                            <div class="">
                                <div
                                    class="input-group mb-3 form-floating mb-3"
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
                                        for="name"
                                        class="text-gray pl-2"
                                        style="z-index: 100"
                                        >Contraseña</label
                                    >
                                    <button
                                        class="btn btn-default"
                                        type="button"
                                        @click="
                                            muestra_password = !muestra_password
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
                            <div class="w-100" v-if="form.errors?.password">
                                <span
                                    class="invalid-feedback alert alert-danger"
                                    style="display: block"
                                    role="alert"
                                >
                                    <strong>{{ form.errors.password }}</strong>
                                </span>
                            </div>
                            <div>
                                <div
                                    class="input-group mb-3 form-floating mb-3"
                                >
                                    <input
                                        :type="
                                            muestra_password2
                                                ? 'text'
                                                : 'password'
                                        "
                                        name="password_confirmation"
                                        class="form-control"
                                        placeholder="Confirma la Contraseña"
                                        v-model="form.password_confirmation"
                                        autocomplete="false"
                                    />
                                    <label
                                        for="name"
                                        class="text-gray pl-2"
                                        style="z-index: 100"
                                        >Confirma la Contraseña</label
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
                            <div class="mb-3">
                                <button
                                    type="submit"
                                    class="btn btn-outline-primary d-block w-100"
                                >
                                    <i class="fa fa-sync"></i> Actualizar
                                    contraseña
                                </button>
                            </div>
                            <div class="mt-20px mb-3">
                                <Link
                                    :href="route('login')"
                                    class="d-block w-100 text-center"
                                    >Iniciar sesión</Link
                                >
                            </div>
                            <div class="mb-0">
                                <a
                                    :href="route('portal.index')"
                                    class="d-block w-100 text-center"
                                    >Volver al portal</a
                                >
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.contenedor_login {
    min-height: 100vh;
}
</style>
