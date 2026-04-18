<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import SliderImagenes from "@/Components/SliderImagenes.vue";
import Formulario from "../Ventas/Formulario.vue";
const props = defineProps({
    producto: {
        type: Object,
        require: true,
    },
});
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    appStore.stopLoading();
});

onBeforeMount(() => {});
</script>
<template>
    <Head title="Productos"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Productos</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item">
                            <Link :href="route('productos.index')"
                                >Productos</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Ver</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-4">
                        <Link
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'productos.index',
                                )
                            "
                            :href="route('productos.index')"
                            class="btn btn-default"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
                        </Link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 mt-1">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">
                                    <i class="fa fa-images"></i> Fotos
                                </h4>
                            </div>
                            <div class="card-body">
                                <SliderImagenes
                                    :imagenes="producto.producto_imagens"
                                    :height="'230px'"
                                ></SliderImagenes>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7 mt-1">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">
                                    <i class="fa fa-list"></i> Producto
                                </h4>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-4 text-right">
                                        <b>Código:</b>
                                    </div>
                                    <div class="col-8">
                                        {{ producto.codigo }}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4 text-right">
                                        <b>Nombre:</b>
                                    </div>
                                    <div class="col-8">
                                        {{ producto.nombre }}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4 text-right">
                                        <b>Categoría:</b>
                                    </div>
                                    <div class="col-8">
                                        {{ producto.categoria.nombre }}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4 text-right">
                                        <b>Precio:</b>
                                    </div>
                                    <div class="col-8">
                                        Bs. {{ producto.precio }}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4 text-right">
                                        <b>Stock Actual:</b>
                                    </div>
                                    <div class="col-8">
                                        {{ producto.stock }}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4 text-right">
                                        <b>Fecha de Registro:</b>
                                    </div>
                                    <div class="col-8">
                                        {{ producto.fecha_registro_t }}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4 text-right">
                                        <b>Descripción:</b>
                                    </div>
                                    <div class="col-8">
                                        <div
                                            v-html="producto.descripcion"
                                        ></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
