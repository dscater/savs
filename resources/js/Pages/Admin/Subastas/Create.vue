<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useSubastas } from "@/composables/subastas/useSubastas";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Formulario from "../Subastas/Formulario.vue";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const { setSubasta, limpiarSubasta, oSubasta } = useSubastas();
onMounted(() => {
    appStore.stopLoading();
    limpiarSubasta();
});
</script>
<template>
    <Head title="Nueva Subasta"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Nueva Subasta</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item">
                            <Link :href="route('subastas.index')"
                                >Subastas</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Nueva Subasta</li>
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
                                    'subastas.index',
                                )
                            "
                            :href="route('subastas.index')"
                            class="btn btn-default"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
                        </Link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 mt-1">
                        <Formulario
                            :subasta="oSubasta"
                            :accion_formulario="0"
                        ></Formulario>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
