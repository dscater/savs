<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useSubastas } from "@/composables/subastas/useSubastas";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
const props = defineProps({
    subasta: {
        type: Object,
        require: true,
    },
});
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const { setSubasta, limpiarSubasta, oSubasta } = useSubastas();
onMounted(() => {
    appStore.stopLoading();
});

onBeforeMount(() => {
    setSubasta(props.subasta);
});
</script>
<template>
    <Head title="Ver Subasta"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Ver Subasta</h1>
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
                        <li class="breadcrumb-item active">Ver Subasta</li>
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
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">
                                    <i class="fa fa-user"></i> Datos del Cliente
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6">
                                        <strong>Nombre/Razón Social:</strong>
                                        {{ subasta.cliente?.nombre }}
                                    </div>
                                    <div class="col-6">
                                        <strong>NIT/C.I.:</strong>
                                        {{ subasta.nit_ci }}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">
                                    <i class="fa fa-list"></i> Datos de la
                                    Subasta
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6">
                                                <strong>Fecha y Hora:</strong>
                                                {{ subasta.fecha_t }}
                                                {{ subasta.hora }}
                                            </div>
                                            <div class="col-6">
                                                <strong>Usuario:</strong>
                                                {{ subasta.user.usuario }}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr class="bg-principal">
                                                    <th>CÓDIGO</th>
                                                    <th>DESCRIPCIÓN</th>
                                                    <th>CANTIDAD</th>
                                                    <th>C/U BS.</th>
                                                    <th>SUBTOTAL BS.</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="item in subasta.subasta_detalles"
                                                >
                                                    <td>
                                                        {{
                                                            item.producto.codigo
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            item.producto.nombre
                                                        }}
                                                    </td>
                                                    <td>{{ item.cantidad }}</td>
                                                    <td>{{ item.precio }}</td>
                                                    <td>{{ item.subtotal }}</td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        class="text-lg font-weight-bold text-right"
                                                        colspan="4"
                                                    >
                                                        TOTAL BS.
                                                    </td>
                                                    <td
                                                        class="text-lg font-weight-bold"
                                                    >
                                                        {{ subasta.total }}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
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
