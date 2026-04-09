<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useVentas } from "@/composables/ventas/useVentas";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Formulario from "../Ventas/Formulario.vue";
const props = defineProps({
    venta: {
        type: Object,
        require: true,
    },
});
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const { setVenta, limpiarVenta, oVenta } = useVentas();
onMounted(() => {
    appStore.stopLoading();
});

onBeforeMount(() => {
    setVenta(props.venta);
});
</script>
<template>
    <Head title="Editar Venta"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Editar Venta</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item">
                            <Link :href="route('ventas.index')">Ventas</Link>
                        </li>
                        <li class="breadcrumb-item active">Editar Venta</li>
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
                                    'ventas.index',
                                )
                            "
                            :href="route('ventas.index')"
                            class="btn btn-default"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
                        </Link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 mt-1">
                        <Formulario
                            :venta="oVenta"
                            :accion_formulario="1"
                        ></Formulario>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
