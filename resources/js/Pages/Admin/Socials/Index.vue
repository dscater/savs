<script setup>
import App from "@/Layouts/App.vue";
defineOptions({
    layout: App,
});
import Content from "@/Components/Content.vue";
import { onMounted, ref, computed, onBeforeMount } from "vue";
import { usePage, Head, useForm, Link } from "@inertiajs/vue3";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useSocialStore } from "@/stores/social/socialStore";
const appStore = useAppStore();
const socialStore = useSocialStore();

onBeforeMount(() => {
    appStore.startLoading();
});

const props_page = defineProps({
    social: {
        type: Object,
        default: null,
    },
});
const { props } = usePage();
const enviando = ref(false);

let form = null;
if (props_page.social != null) {
    props_page.social["_method"] = "put";
    form = useForm(props_page.social);
} else {
    form = useForm({
        _method: "put",
        id: 0,
        whatsapp: "",
        facebook: "",
        tiktok: "",
        instagram: "",
        youtube: "",
        x: "",
        web: "",
        correo: "",
    });
}

const enviarFormulario = () => {
    enviando.value = true;
    form.post(route("socials.update", form.id), {
        onSuccess: (response) => {
            // Mostrar mensaje de éxito
            console.log("correcto");
            const success =
                response.props.flash.success ?? "Proceso realizado con éxito";
            limpiaRefs();
            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `<strong>${success}</strong>`,
                showCancelButton: false,
                confirmButtonText: "Aceptar",
                customClass: {
                    confirmButton: "btn-alert-success",
                },
            });
        },
        onError: (err, code) => {
            console.log(code ?? "");
            const error =
                "Ocurrió un error inesperado contactese con el Administrador";
            Swal.fire({
                icon: "error",
                title: "Error",
                html: `<strong>${error}</strong>`,
                showCancelButton: false,
                confirmButtonText: "Aceptar",
                customClass: {
                    confirmButton: "btn-error",
                },
            });
            console.log("error: " + err.error);
        },
        onFinish: () => {
            enviando.value = false;
            socialStore.initSocial();
        },
    });
};
const logo = ref(null);
function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];

    // Generar la URL del archivo cargado
    const fileUrl = URL.createObjectURL(form[key]);
    form["url_" + key] = fileUrl;
}
function limpiaRefs() {
    logo.value = null;
}

const btnGuardar = computed(() => {
    if (enviando.value) {
        return `Guardando... <i class="fa fa-spinner fa-spin"></i>`;
    }

    return `Guardar cambios <i class="fa fa-save"></i>`;
});

onMounted(() => {
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Redes Sociales"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Redes Sociales</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Redes Sociales</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <form @submit.prevent="enviarFormulario()">
            <div class="row">
                <div class="col-md-4 form-group mb-3">
                    <label class="required">Whatsapp</label>
                    <input
                        type="text"
                        class="form-control"
                        v-model="form.whatsapp"
                    />
                    <small class="text-xs">Ej.: +5917777777</small>
                    <span class="text-danger" v-if="form.errors?.whatsapp">{{
                        form.errors.whatsapp
                    }}</span>
                </div>
                <div class="col-md-4 form-group mb-3">
                    <label>Facebook</label>
                    <input
                        type="text"
                        class="form-control"
                        v-model="form.facebook"
                    />
                    <span class="text-danger" v-if="form.errors?.facebook">{{
                        form.errors.facebook
                    }}</span>
                </div>
                <div class="col-md-4 form-group mb-3">
                    <label>Tiktok</label>
                    <input
                        type="text"
                        class="form-control"
                        v-model="form.tiktok"
                    />
                    <span class="text-danger" v-if="form.errors?.tiktok">{{
                        form.errors.tiktok
                    }}</span>
                </div>
                <div class="col-md-4 form-group mb-3">
                    <label>Instagram</label>
                    <input
                        type="text"
                        class="form-control"
                        v-model="form.instagram"
                    />
                    <span class="text-danger" v-if="form.errors?.instagram">{{
                        form.errors.instagram
                    }}</span>
                </div>
                <div class="col-md-4 form-group mb-3">
                    <label>Youtube</label>
                    <input
                        type="text"
                        class="form-control"
                        v-model="form.youtube"
                    />
                    <span class="text-danger" v-if="form.errors?.youtube">{{
                        form.errors.youtube
                    }}</span>
                </div>
                <div class="col-md-4 form-group mb-3">
                    <label>X</label>
                    <input type="text" class="form-control" v-model="form.x" />
                    <span class="text-danger" v-if="form.errors?.x">{{
                        form.errors.x
                    }}</span>
                </div>
                <div class="col-md-4 form-group mb-3">
                    <label>Web</label>
                    <input
                        type="text"
                        class="form-control"
                        v-model="form.web"
                    />
                    <span class="text-danger" v-if="form.errors?.web">{{
                        form.errors.web
                    }}</span>
                </div>
                <div class="col-md-4 form-group mb-3">
                    <label>Correo electrónico</label>
                    <input
                        type="text"
                        class="form-control"
                        v-model="form.correo"
                    />
                    <span class="text-danger" v-if="form.errors?.correo">{{
                        form.errors.correo
                    }}</span>
                </div>
            </div>
            <div class="row pb-5">
                <div
                    class="col-12"
                    v-if="
                        props.auth.user.permisos == '*' ||
                        props.auth.user.permisos.includes('socials.edit')
                    "
                >
                    <button
                        type="submit"
                        class="btn btn-primary"
                        v-html="btnGuardar"
                        :disabled="enviando"
                    ></button>
                </div>
            </div>
        </form>
    </Content>
</template>
<style scoped>
.logo_muestra {
    margin-top: 10px;
    width: 100%;
    text-align: center;
}
.logo_muestra img {
    max-width: 100%;
}
</style>
