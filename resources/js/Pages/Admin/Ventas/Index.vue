<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useVentas } from "@/composables/ventas/useVentas";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    appStore.stopLoading();
});

const { setVenta, limpiarVenta } = useVentas();
const { axiosDelete } = useAxios();

const miTable = ref(null);
const headers = [
    {
        label: "NRO",
        key: "id",
        sortable: true,
        width: "4%",
    },
    {
        label: "CLIENTE",
        key: "cliente.nombre",
        sortable: true,
    },
    {
        label: "NIT/C.I.",
        key: "nit_ci",
        sortable: true,
    },
    {
        label: "TOTAL",
        key: "total",
        sortable: true,
    },
    {
        label: "FECHA",
        key: "fecha",
        sortable: true,
    },
    {
        label: "ESTADO",
        key: "status",
        sortable: true,
    },
    {
        label: "ACCIÓN",
        key: "accion",
        fixed: "right",
        width: "4%",
    },
];

const multiSearch = ref({
    search: "",
    filtro: [],
});

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
    }
};

const editarVenta = (item) => {
    router.get(route("ventas.edit", item.id));
};

const eliminarVenta = (item) => {
    Swal.fire({
        title: "¿Quierés anular este registro?",
        html: `<strong>Nro. Venta: ${item.id}<br/><strong>Cliente: </strong>${item.cliente.nombre}<br/><strong>Total: ${item.total}</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, anular",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-danger",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await axiosDelete(route("ventas.destroy", item.id));
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};
</script>
<template>
    <Head title="Ventas"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Ventas</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Ventas</li>
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
                                    'ventas.create',
                                )
                            "
                            class="btn btn-primary"
                            :href="route('ventas.create')"
                        >
                            <i class="fa fa-plus"></i> Nueva Venta
                        </Link>
                    </div>
                    <div class="col-md-8 my-1">
                        <div class="row justify-content-end">
                            <div class="col-md-5">
                                <div
                                    class="input-group"
                                    style="align-items: end"
                                >
                                    <input
                                        v-model="multiSearch.search"
                                        placeholder="Buscar"
                                        class="form-control border-1 border-right-0"
                                    />
                                    <div class="input-append">
                                        <button
                                            class="btn btn-default rounded-0 border-left-0"
                                            @click="updateDatos"
                                        >
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <MiTable
                            :tableClass="'bg-white mitabla'"
                            ref="miTable"
                            :cols="headers"
                            :api="true"
                            :url="route('ventas.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #status="{ item }">
                                <span
                                    class="badge text-sm"
                                    :class="{
                                        'badge-success': item.status == 1,
                                        'badge-danger': item.status == 0,
                                    }"
                                    >{{
                                        item.status == 1
                                            ? "FINALIZADO"
                                            : "ANULADO"
                                    }}</span
                                >
                            </template>
                            <template #fecha="{ item }">
                                <span>{{ item.fecha_t }} {{ item.hora }}</span>
                            </template>
                            <template #accion="{ item }">
                                <template
                                    v-if="
                                        item.status == 1 &&
                                        (props_page.auth?.user.permisos ==
                                            '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'ventas.edit',
                                            ))
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Editar"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-warning"
                                            @click="editarVenta(item)"
                                        >
                                            <i class="fa fa-pen"></i></button
                                    ></el-tooltip>
                                </template>

                                <template
                                    v-if="
                                        item.status == 1 &&
                                        (props_page.auth?.user.permisos ==
                                            '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'ventas.destroy',
                                            ))
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Anular"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-danger"
                                            @click="eliminarVenta(item)"
                                        >
                                            <i class="fa fa-ban"></i></button
                                    ></el-tooltip>
                                </template>
                            </template>
                        </MiTable>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
