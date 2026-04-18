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
const { props } = usePage();
const { oConfiguracion } = useConfiguracion();
const form = useForm({
    correo: "",
});

var url_assets = "";
var url_principal = "";
const enviando = ref(false);

const submit = () => {
    enviando.value = true;
    axios
        .post(route("solicitar_recuperacion"), form)
        .then((response) => {
            enviando.value = false;
            form.reset();
            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `Registro correcto<br/> Revisa tu correo electrónico`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        })
        .catch((error) => {
            enviando.value = false;
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
    <Head title="Olvidaste tu contraseña"></Head>
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
                            <div class="row">
                                <div class="col-12">
                                    <ol>
                                        <li>
                                            Ingresa el correo electrónico con el
                                            que te registraste
                                        </li>
                                        <li>
                                            Te envíaremos un link y un código,
                                            para que puedas recuperar tu
                                            contraseña
                                        </li>
                                    </ol>
                                </div>
                            </div>
                            <div class="form-floating">
                                <input
                                    type="text"
                                    name="correo"
                                    class="form-control"
                                    placeholder="Usuario/Correo"
                                    id="name"
                                    v-model="form.correo"
                                    autofocus
                                />
                                <label for="name" class="text-gray pl-3"
                                    >Correo electrónico</label
                                >
                            </div>
                            <div class="w-100" v-if="form.errors?.correo">
                                <span
                                    class="invalid-feedback alert alert-danger"
                                    style="display: block"
                                    role="alert"
                                >
                                    <strong>{{ form.errors.correo }}</strong>
                                </span>
                            </div>
                            <div class="my-3">
                                <button
                                    :disabled="enviando"
                                    type="submit"
                                    class="btn btn-outline-primary w-100"
                                >
                                    <i class="fa fa-paper-plane"></i> Solicitar
                                    recuperación
                                </button>
                            </div>
                            <div class="mb-2">
                                <Link
                                    :href="route('login')"
                                    class="text-center d-block w-10"
                                >
                                    Iniciar sesión
                                </Link>
                            </div>
                            <div class="mb-">
                                <Link
                                    :href="route('registro')"
                                    class="text-center d-block w-10"
                                >
                                    Registro
                                </Link>
                            </div>
                        </form>
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
