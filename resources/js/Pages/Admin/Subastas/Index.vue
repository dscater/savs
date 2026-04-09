<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useSubastas } from "@/composables/subastas/useSubastas";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import axios from "axios";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    appStore.stopLoading();
});

const { setSubasta, limpiarSubasta } = useSubastas();
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
        label: "USUARIO",
        key: "user",
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

const editarSubasta = (item) => {
    router.get(route("subastas.edit", item.id));
};

const eliminarSubasta = (item) => {
    Swal.fire({
        title: "¿Quierés anular este registro?",
        html: `<strong>Nro. Subasta: ${item.id}<br/><strong>Cliente: </strong>${item.cliente.nombre}<br/><strong>Total: ${item.total}</strong>`,
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
            let respuesta = await axiosDelete(
                route("subastas.destroy", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

const revertirAnulado = (item) => {
    Swal.fire({
        title: "¿Quierés revertir la anulación de esta subasta?",
        html: `<strong>Nro. Subasta: ${item.id}<br/><strong>Cliente: </strong>${item.cliente.nombre}<br/><strong>Total: ${item.total}</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, revertir",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-primary",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            axios
                .patch(route("subastas.revertirAnulado", item.id))
                .then((response) => {
                    updateDatatable();
                    Swal.fire({
                        icon: "success",
                        title: "Correcto",
                        html: `<strong>${response.data.message}</strong>`,
                        confirmButtonText: `Aceptar`,
                        customClass: {
                            confirmButton: "btn-alert-success",
                        },
                    });
                })
                .fail((err) => {
                    console.log(err);
                    const error =
                        "Ocurrió un error inesperado contactese con el Administrador";
                    Swal.fire({
                        icon: "info",
                        title: "Error",
                        html: `<strong>${error}</strong>`,
                        confirmButtonText: `Aceptar`,
                        customClass: {
                            confirmButton: "btn-error",
                        },
                    });
                });
        }
    });
};
</script>
<template>
    <Head title="Subastas"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Subastas</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Subastas</li>
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
                                    'subastas.create',
                                )
                            "
                            class="btn btn-primary"
                            :href="route('subastas.create')"
                        >
                            <i class="fa fa-plus"></i> Nueva Subasta
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
                            :url="route('subastas.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #user="{ item }">
                                <span
                                    >{{ item.user.nombre }}
                                    {{ item.user.paterno }}
                                    {{ item.user.materno }}</span
                                >
                            </template>
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
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'subastas.imprimir',
                                        )
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Recibo"
                                        placement="left-start"
                                    >
                                        <a
                                            class="btn btn-dark"
                                            target="_blank"
                                            :href="
                                                route(
                                                    'subastas.imprimir',
                                                    item.id,
                                                )
                                            "
                                        >
                                            <i class="fa fa-print"></i></a
                                    ></el-tooltip>
                                </template>
                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'subastas.verSubasta',
                                        )
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Ver Subasta"
                                        placement="left-start"
                                    >
                                        <Link
                                            class="btn btn-info"
                                            :href="
                                                route(
                                                    'subastas.verSubasta',
                                                    item.id,
                                                )
                                            "
                                        >
                                            <i class="fa fa-eye"></i></Link
                                    ></el-tooltip>
                                </template>
                                <template
                                    v-if="
                                        item.status == 1 &&
                                        (props_page.auth?.user.permisos ==
                                            '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'subastas.edit',
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
                                            @click="editarSubasta(item)"
                                        >
                                            <i class="fa fa-pen"></i></button
                                    ></el-tooltip>
                                </template>

                                <template
                                    v-if="
                                        item.status == 0 &&
                                        (props_page.auth?.user.permisos ==
                                            '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'subastas.revertirAnulado',
                                            ))
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Revertir Anulación"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-primary"
                                            @click="revertirAnulado(item)"
                                        >
                                            <i class="fa fa-sync"></i></button
                                    ></el-tooltip>
                                </template>

                                <template
                                    v-if="
                                        item.status == 1 &&
                                        (props_page.auth?.user.permisos ==
                                            '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'subastas.destroy',
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
                                            @click="eliminarSubasta(item)"
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
