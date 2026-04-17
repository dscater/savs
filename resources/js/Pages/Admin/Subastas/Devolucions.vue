<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import axios from "axios";
import { ref, onMounted, onBeforeUnmount, nextTick, onBeforeMount } from "vue";
import { useFormater } from "@/composables/useFormater";
import PublicacionAdmin from "@/Components/PublicacionAdmin.vue";
import RegistraDevolucion from "./RegistraDevolucion.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
const { getFormatoMoneda } = useFormater();
const { props: props_page } = usePage();
const appStore = useAppStore();

const loading = ref(false);
const accion_dialog = ref(0);
const open_dialog = ref(false);
const oPublicacion = ref(null);
const listSubastas = ref([]);
const publicacion_id = ref(null);
const itemSubastaCliente = ref(null);

const obtenerPublicacion = (value) => {
    oPublicacion.value = null;
    if (value) {
        axios.get(route("subastas.show", value)).then((response) => {
            oPublicacion.value = response.data;
        });
    }
};

const abrirFormularioDevolucion = (item, index) => {
    itemSubastaCliente.value = item;
    open_dialog.value = true;
};

const cargarPublicacions = () => {
    axios
        .get(route("subastas.listado"), {
            params: {
                con_subasta: true,
            },
        })
        .then((response) => {
            console.log(response);
            listSubastas.value = response.data.subastas;
        });
};

const actualizaRegistros = () => {
    obtenerPublicacion(oPublicacion.value.id);
};

onMounted(async () => {
    cargarPublicacions();
    appStore.stopLoading();
});
onBeforeMount(() => {
    appStore.startLoading();
});
onBeforeUnmount(() => {});
</script>
<template>
    <Content>
        <Head title="Devolución de garantías"></Head>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Devolución de garantías</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Devolución de garantías
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-5">
                <div class="card" v-if="oPublicacion">
                    <div class="card-body">
                        <PublicacionAdmin
                            :publicacion="oPublicacion"
                            :column="true"
                            :link="true"
                        ></PublicacionAdmin>
                    </div>
                </div>
                <div class="card card-body bg-secondary" v-else>
                    <el-empty>
                        <template #description>
                            <span class="text-white"
                                >Debes seleccionar una publicación</span
                            >
                        </template>
                    </el-empty>
                </div>
            </div>
            <div class="col-md-7">
                <!-- BEGIN card -->
                <div class="card">
                    <!-- BEGIN card-body -->
                    <div class="card-body">
                        <el-select
                            class="w-100"
                            no-data-text="Sin registros"
                            placeholder="Seleccionar publicación"
                            filterable
                            v-model="publicacion_id"
                            @change="obtenerPublicacion"
                            clearable
                        >
                            <el-option
                                v-for="item in listSubastas"
                                :key="item.id"
                                :value="item.id"
                                :label="`${item.id} - ${item.producto.nombre}`"
                            >
                            </el-option>
                        </el-select>
                        <div class="row mt-3" v-if="oPublicacion">
                            <div class="col-12">
                                <h4 class="card-title text-center">
                                    ESTADO DE LA DEVOLUCIÓN EFECTIVA DE
                                    GARANTÍAS
                                </h4>
                            </div>
                            <div class="col-12" style="overflow: auto">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr class="bg-principal">
                                            <th class="text-white">#</th>
                                            <th class="text-white">
                                                Nombre completo
                                            </th>
                                            <th class="text-white">
                                                Fecha devolución
                                            </th>
                                            <th class="text-white">
                                                Descripción
                                            </th>
                                            <th class="text-white">
                                                Estado devolución
                                            </th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr
                                            v-for="(
                                                item, index
                                            ) in oPublicacion.participantes_devolucion"
                                        >
                                            <td>{{ index + 1 }}</td>
                                            <td>
                                                {{ item.user.full_name }}
                                            </td>
                                            <td>
                                                {{ item.fecha_hora_devolucion }}
                                            </td>
                                            <td>
                                                {{
                                                    item.descripcion_devolucion
                                                }}
                                            </td>
                                            <td
                                                v-html="item.devolucion_span"
                                            ></td>
                                            <td>
                                                <button
                                                    v-if="
                                                        item.devolucion == 0 &&
                                                        (props_page.auth?.user
                                                            .permisos == '*' ||
                                                            props_page.auth?.user.permisos.includes(
                                                                'subastas.edit',
                                                            ))
                                                    "
                                                    class="btn btn-success"
                                                    @click="
                                                        abrirFormularioDevolucion(
                                                            item,
                                                            index,
                                                        )
                                                    "
                                                >
                                                    <i
                                                        class="fa fa-clipboard-check"
                                                    ></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- END card-body -->
                </div>
                <!-- END card -->
            </div>
        </div>
        <RegistraDevolucion
            :open_dialog="open_dialog"
            :subasta_cliente="itemSubastaCliente"
            :publicacion="oPublicacion"
            @envio-formulario="actualizaRegistros"
            @cerrar-dialog="open_dialog = false"
        ></RegistraDevolucion>
    </Content>
</template>
<style scoped></style>
