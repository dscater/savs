<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
    url_compartir: {
        type: String,
        default: "",
    },
});

const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const url_catalogo = ref(props.url_compartir);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
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
watch(
    () => props.url_compartir,
    (newValue) => {
        url_catalogo.value = newValue;
    },
);

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-share-alt"></i> Compartir Catálogo`
        : `<i class="fa fa-share-alt"></i> Compartir`;
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

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const emits = defineEmits(["cerrar-formulario"]);

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const copiarURL = () => {
    navigator.clipboard.writeText(url_catalogo.value).then(
        () => {
            toast.success("URL copiada al portapapeles");
        },
        (err) => {
            toast.error("Error al copiar la URL: " + err);
        },
    );
};

const compartir = (red) => {
    const url = encodeURIComponent(url_catalogo.value);
    const texto = encodeURIComponent("Mira este catálogo");

    let link = "";

    switch (red) {
        case "whatsapp":
            link = `https://wa.me/?text=${texto}%20${url}`;
            break;

        case "facebook":
            link = `https://www.facebook.com/sharer/sharer.php?u=${url}`;
            break;

        case "twitter":
            link = `https://twitter.com/intent/tweet?text=${texto}&url=${url}`;
            break;

        case "linkedin":
            link = `https://www.linkedin.com/sharing/share-offsite/?url=${url}`;
            break;

        case "telegram":
            link = `https://t.me/share/url?url=${url}&text=${texto}`;
            break;
    }

    window.open(link, "_blank");
};

const copiarPara = (red) => {
    navigator.clipboard.writeText(url_catalogo.value);

    toast.success(`Link copiado. Ahora pégalo en ${red}`);
};

onMounted(() => {});
</script>

<template>
    <MiModal
        :open_modal="muestra_form"
        @close="cerrarFormulario"
        :size="'modal-xl'"
        :header-class="'bg-white'"
        :footer-class="'justify-content-end'"
    >
        <template #header>
            <h4 class="modal-title" v-html="tituloDialog"></h4>
            <button
                type="button"
                class="close"
                @click.prevent="cerrarFormulario()"
            >
                <span aria-hidden="true">×</span>
            </button>
        </template>

        <template #body>
            <div class="row">
                <!-- BOTONES REDES -->
                <div class="col-12 mb-3 text-center">
                    <div class="d-flex justify-content-center flex-wrap">
                        <button
                            class="btn btn-success m-1"
                            @click="compartir('whatsapp')"
                        >
                            <i class="fab fa-whatsapp"></i>
                        </button>

                        <button
                            class="btn btn-primary m-1"
                            @click="compartir('facebook')"
                        >
                            <i class="fab fa-facebook-f"></i>
                        </button>

                        <button
                            class="btn btn-info m-1"
                            @click="compartir('twitter')"
                        >
                            <i class="fab fa-twitter"></i>
                        </button>

                        <button
                            class="btn btn-primary m-1"
                            @click="compartir('linkedin')"
                        >
                            <i class="fab fa-linkedin-in"></i>
                        </button>

                        <button
                            class="btn btn-dark m-1"
                            @click="compartir('telegram')"
                        >
                            <i class="fab fa-telegram-plane"></i>
                        </button>
                        <button
                            class="btn btn-danger m-1"
                            @click="copiarPara('Instagram')"
                        >
                            <i class="fab fa-instagram"></i>
                        </button>

                        <button
                            class="btn btn-dark m-1"
                            @click="copiarPara('TikTok')"
                        >
                            <i class="fab fa-tiktok"></i>
                        </button>
                    </div>
                </div>
                <div class="col-12">
                    <div class="input-group">
                        <input
                            type="text"
                            class="form-control"
                            :value="url_catalogo"
                            readonly
                        />
                        <div class="input-group-append">
                            <button
                                class="btn btn-outline-secondary"
                                type="button"
                                @click="copiarURL"
                            >
                                Copiar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </template>
        <template #footer>
            <button
                type="button"
                class="btn btn-default"
                @click.prevent="cerrarFormulario()"
            >
                Cerrar
            </button>
        </template>
    </MiModal>
</template>
