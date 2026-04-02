<script setup>
import Portal from "@/Layouts/Portal.vue";
import { usePage, router } from "@inertiajs/vue3";
import {
    computed,
    onBeforeUnmount,
    onMounted,
    onUnmounted,
    ref,
    watch,
} from "vue";
import Compartir from "./Compartir.vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
import { useCatalogoStore } from "@/stores/catalogo/catalogoStore";
const catalogoStore = useCatalogoStore();
defineOptions({ layout: Portal });
const propsPage = usePage().props;
const url_assets = ref(propsPage.url_assets);

const props = defineProps({
    catalogo: Object,
    productos: Object,
    page: {
        type: Number,
        default: 1,
    },
});

const oProducto = ref({});
const paginaInput = ref(1);
const currentPage = computed(() => {
    paginaInput.value = Number(props.productos.current_page);
    return Number(props.productos.current_page);
});
const lastPage = computed(() => props.productos.last_page);
watch(
    () => props.productos,
    (newValue) => {
        if (newValue.data.length > 0) {
            oProducto.value = newValue.data[0];
        }
    },
);

const siguiente = () => {
    if (props.productos.current_page < props.productos.last_page) {
        cambiarPagina(props.productos.current_page + 1);
    }
};

const anterior = () => {
    if (props.productos.current_page > 1) {
        cambiarPagina(props.productos.current_page - 1);
    }
};

const inicio = () => cambiarPagina(1);
const final = () => cambiarPagina(props.productos.last_page);

const cambiarPagina = (pagina) => {
    router.get(
        route("portal.productos", props.catalogo.id),
        {
            page: pagina,
        },
        {
            preserveState: true,
            replace: true,
        },
    );
};

const setIntervalOutPagina = ref(null);
const modificarPaginaInput = () => {
    clearInterval(setIntervalOutPagina.value);
    if (
        paginaInput.value &&
        paginaInput.value > 0 &&
        paginaInput.value < lastPage
    ) {
        console.log();
        setIntervalOutPagina.value = setTimeout(() => {
            cambiarPagina(paginaInput.value ?? 1);
        }, 170);
    }
};

// DRAG SWIPE
const totalPages = 5;
const startX = ref(0);
const diffX = ref(0);
const isDragging = ref(false);

// Inicia el rastreo
const handleStart = (e) => {
    isDragging.value = true;
    // Soporte para Touch y Mouse
    startX.value = e.touches ? e.touches[0].clientX : e.clientX;
    diffX.value = 0;

    // IMPORTANTE: Escuchar en window para no perder el evento al soltar
    window.addEventListener("mousemove", handleMove);
    window.addEventListener("mouseup", handleEnd);
    window.addEventListener("touchmove", handleMove, { passive: false });
    window.addEventListener("touchend", handleEnd);
};

const handleMove = (e) => {
    if (!isDragging.value) return;

    // Prevenir scroll vertical accidental en móviles mientras arrastras
    if (e.type === "touchmove") e.preventDefault();

    const currentX = e.touches ? e.touches[0].clientX : e.clientX;
    diffX.value = currentX - startX.value;
};
// Determina si se cambia de página al soltar
const handleEnd = () => {
    if (!isDragging.value) return;

    const threshold = 20; // Sensibilidad

    if (diffX.value > threshold) {
        anterior();
    } else if (diffX.value < -threshold) {
        siguiente();
    }

    // Limpieza
    isDragging.value = false;
    diffX.value = 0;

    // Remover los listeners globales
    window.removeEventListener("mousemove", handleMove);
    window.removeEventListener("mouseup", handleEnd);
    window.removeEventListener("touchmove", handleMove);
    window.removeEventListener("touchend", handleEnd);
};

const muestra_compartir = ref(false);
const accion_compartir = ref(0);
const url_catalogo = ref("");
const compartirCatalogo = () => {
    muestra_compartir.value = true;
    url_catalogo.value = route("portal.productos", props.catalogo.id);
};

onMounted(() => {
    oProducto.value = props.productos.data[0];
});

const listPedido = computed(() => catalogoStore.getListaProductos());
const agregarAlPedido = () => {
    catalogoStore.agregarProducto(oProducto.value);
};

onBeforeUnmount(() => {});

onUnmounted(() => handleEnd());
</script>
<template>
    <div class="container">
        <div class="row">
            <div class="col-12 mt-3">
                <Compartir
                    :accion_formulario="accion_compartir"
                    :muestra_formulario="muestra_compartir"
                    :url_compartir="url_catalogo"
                    @cerrar-formulario="muestra_compartir = false"
                ></Compartir>
                <div class="mx-auto col-md-9 text-center">
                    Página
                    <input
                        type="text"
                        v-model="paginaInput"
                        class="nro_pagina"
                        @keyup="modificarPaginaInput"
                    />
                    de
                    {{ lastPage }}
                </div>
                <div
                    class="mx-auto col-md-9 text-center d-flex justify-content-center text-lg"
                    style="gap: 20px"
                >
                    <el-tooltip
                        class="box-item"
                        effect="dark"
                        content="Compartir Catálogo"
                        placement="bottom-start"
                    >
                        <a
                            href="#"
                            class="text-dark"
                            @click.prevent="compartirCatalogo"
                            ><i class="fa fa-share-alt"></i
                        ></a>
                    </el-tooltip>
                    <template v-if="catalogo.descargar == 1">
                        <el-tooltip
                            class="box-item"
                            effect="dark"
                            content="Descargar Catálogo"
                            placement="bottom-start"
                        >
                            <a
                                :href="
                                    route(
                                        'portal.descargar_catalogo',
                                        catalogo.id,
                                    )
                                "
                                target="_blank"
                                class="text-dark"
                                ><i class="fa fa-download"></i
                            ></a>
                        </el-tooltip>
                    </template>
                    <el-tooltip
                        class="box-item"
                        effect="dark"
                        content="Agregar al Pedido"
                        placement="bottom-start"
                    >
                        <button class="btn btn-sm" @click="agregarAlPedido">
                            <i class="fa fa-plus fa-lg"></i>
                        </button>
                    </el-tooltip>
                </div>
                <div class="menu_inicio">
                    <div
                        class="contenedor_producto"
                        @mousedown="handleStart"
                        @touchstart="handleStart"
                    >
                        <div class="pagina_inicio" v-if="currentPage > 1">
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Inicio"
                                placement="left-start"
                                ><i
                                    class="fa fa-angle-double-left"
                                    @click="inicio"
                                ></i
                            ></el-tooltip>
                        </div>
                        <div class="pagina_anterior" v-if="currentPage > 1">
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Anterior"
                                placement="left-start"
                            >
                                <i
                                    class="fa fa-angle-left"
                                    @click="anterior"
                                ></i>
                            </el-tooltip>
                        </div>
                        <div
                            class="pagina_siguiente"
                            v-if="currentPage < lastPage"
                        >
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Siguiente"
                                placement="right-start"
                            >
                                <i
                                    class="fa fa-angle-right"
                                    @click="siguiente"
                                ></i
                            ></el-tooltip>
                        </div>
                        <div
                            class="pagina_ultimo"
                            v-if="currentPage < lastPage"
                        >
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Final"
                                placement="right-start"
                            >
                                <i
                                    class="fa fa-angle-double-right"
                                    @click="final"
                                ></i>
                            </el-tooltip>
                        </div>
                        <div
                            class="producto"
                            :style="{
                                backgroundImage: `url(${oProducto.url_imagen})`,
                                backgroundSize: 'contain',
                                backgroundRepeat: 'no-repeat',
                                backgroundPosition: 'center',
                            }"
                        ></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped>
.menu_inicio {
    padding: 5px;
}

.menu_inicio .pagina_inicio i {
    left: 0px;
}
.menu_inicio .pagina_ultimo i {
    top: 20px;
    right: 0;
}

.menu_inicio .pagina_anterior i {
    top: 49%;
    left: 0;
}
.menu_inicio .pagina_siguiente i {
    top: 49%;
    right: 0;
}
</style>
