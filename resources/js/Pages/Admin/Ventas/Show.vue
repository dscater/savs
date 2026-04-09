<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useVentas } from "@/composables/ventas/useVentas";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
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
    <Head title="Ver Venta"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Ver Venta</h1>
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
                        <li class="breadcrumb-item active">Ver Venta</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-6">
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
                        <a
                            :href="route('ventas.imprimir', venta.id)"
                            target="_blank"
                            class="btn btn-dark mx-1"
                            ><i class="fa fa-print"></i> Recibo</a
                        >
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
                                        {{ venta.cliente?.nombre }}
                                    </div>
                                    <div class="col-6">
                                        <strong>NIT/C.I.:</strong>
                                        {{ venta.nit_ci }}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">
                                    <i class="fa fa-list"></i> Datos de la Venta
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12 mb-2">
                                        <div class="row">
                                            <div class="col-6">
                                                <strong>Fecha y Hora:</strong>
                                                {{ venta.fecha_t }}
                                                {{ venta.hora }}
                                            </div>
                                            <div class="col-6">
                                                <strong>Usuario:</strong>
                                                {{ venta.user.usuario }}
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
                                                    v-for="item in venta.venta_detalles"
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
                                                        {{ venta.total }}
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
