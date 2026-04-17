<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeUnmount, onBeforeMount } from "vue";
import VerificarComprobante from "./VerificarComprobante.vue";
import PublicacionAdmin from "@/Components/PublicacionAdmin.vue";
import { useFormater } from "@/composables/useFormater";
import { useAppStore } from "@/stores/aplicacion/appStore";
const { getFormatoMoneda } = useFormater();
const props = defineProps({
    subasta: {
        type: Object,
        default: null,
    },
});

const { props: props_page } = usePage();
const appStore = useAppStore();

const loading = ref(false);
const open_dialog_verif = ref(false);
const itemSubastaCliente = ref(null);
const intervalRegistros = ref(null);
const listRegistros = ref([]);
const lastId = ref(0);
const maxima_puja = ref(0);

const cargarRegistros = () => {
    axios
        .get(route("subastas.getParticipantesApi", props.subasta.id), {
            params: {
                lastId: lastId.value,
                maxima_puja: maxima_puja.value,
            },
        })
        .then((response) => {
            listRegistros.value = [
                ...new Set([...listRegistros.value, ...response.data.subastas]),
            ];

            listRegistros.value = [
                ...new Map(
                    listRegistros.value.map((item) => [item.id, item]),
                ).values(),
            ].sort((a, b) => b.monto_puja - a.monto_puja);

            lastId.value = response.data.lastId;
            maxima_puja.value = response.data.maxima_puja;
        });
};

const fila_index = ref(-1);
const actualizaFila = (data) => {
    if (fila_index.value > -1) {
        listRegistros.value[fila_index.value] = data;
        fila_index.value = -1;
    }
};

const verificarComprobante = (index, id) => {
    // comprobante
    axios.get(route("participantes.getInfo", id)).then((response) => {
        itemSubastaCliente.value = response.data;
        open_dialog_verif.value = true;
        fila_index.value = index;
    });
};

const getEstadoParticipando = (value, value2) => {
    let estado = `PARTICIPANDO`;

    if (value == 0 || value == 2) {
        estado = `PERDEDOR`;
    }
    if (value2 == 2) {
        estado = `GANADOR`;
    }

    return estado;
};

const getEstadoComprobante = (value) => {
    let estado = `SIN VERIFICAR`;
    if (value == 1) {
        estado = `VERIFICADO`;
    } else if (value == 2) {
        estado = `RECHAZADO`;
    }
    return estado;
};

onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(async () => {
    cargarRegistros();
    intervalRegistros.value = setInterval(() => {
        cargarRegistros();
    }, 1300);
    appStore.stopLoading();
});
onBeforeUnmount(() => {
    if (intervalRegistros.value) {
        clearInterval(intervalRegistros.value);
    }
});
</script>
<template>
    <Head title="Subasta Clientes"></Head>
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
                        <li class="breadcrumb-item">
                            <Link :href="route('subastas.index')"
                                >Subastas</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Participantes</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-4">
                <Link :href="route('subastas.index')" class="btn btn-default"
                    ><i class="fa fa-arrow-left"></i> Volver</Link
                >
            </div>
            <div class="col-md-12">
                <!-- BEGIN card -->
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mx-auto">
                                <div class="card">
                                    <div class="card-body">
                                        <PublicacionAdmin
                                            :publicacion="props.subasta"
                                            :column="true"
                                            :link="true"
                                        ></PublicacionAdmin>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12" style="overflow: auto">
                                <table
                                    width="100%"
                                    class="table table-bordered bg-white table_participantes"
                                >
                                    <thead>
                                        <tr class="bg-principal">
                                            <th>Nombre Participante</th>
                                            <th>C.I.</th>
                                            <th>Celular</th>
                                            <th>Correo</th>
                                            <th>Puja actual</th>
                                            <th>Estado</th>
                                            <th>Estado comprobante</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <template
                                            v-if="listRegistros.length > 0"
                                        >
                                            <tr
                                                v-for="(
                                                    item, index
                                                ) in listRegistros"
                                            >
                                                <td>
                                                    {{ item.user.full_name }}
                                                </td>
                                                <td>
                                                    {{
                                                        item.user.user_dato
                                                            .full_ci
                                                    }}
                                                </td>
                                                <td>{{ item.user.fono }}</td>
                                                <td>
                                                    {{
                                                        item.user.user_dato
                                                            .email
                                                    }}
                                                </td>
                                                <td
                                                    v-html="item.monto_puja"
                                                ></td>
                                                <td>
                                                    <span
                                                        class="badge text-xs"
                                                        :class="{
                                                            'bg-gray':
                                                                item.estado_comprobante ==
                                                                0,
                                                            'bg-primary':
                                                                item.estado ==
                                                                    1 ||
                                                                item.estado ==
                                                                    0,
                                                            'bg-success':
                                                                item.estado ==
                                                                2,
                                                        }"
                                                    >
                                                        {{ item.estado_puja_t }}
                                                    </span>
                                                </td>
                                                <td>
                                                    <span
                                                        class="badge text-xs"
                                                        :class="[
                                                            item.estado_comprobante ==
                                                            1
                                                                ? 'bg-success'
                                                                : item.estado_comprobante ==
                                                                    2
                                                                  ? 'bg-danger'
                                                                  : 'bg-gray',
                                                        ]"
                                                    >
                                                        {{
                                                            getEstadoComprobante(
                                                                item.estado_comprobante,
                                                            )
                                                        }}
                                                    </span>
                                                </td>
                                                <td>
                                                    <button
                                                        v-if="
                                                            props_page.auth
                                                                ?.user
                                                                .permisos ==
                                                                '*' ||
                                                            props_page.auth?.user.permisos.includes(
                                                                'subastas.edit',
                                                            )
                                                        "
                                                        class="m-1 btn btn-success comprobante"
                                                        @click="
                                                            verificarComprobante(
                                                                index,
                                                                item.id,
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-check-circle"
                                                        ></i>
                                                    </button>
                                                    <a
                                                        :href="
                                                            route(
                                                                'participantes.show',
                                                                item.id,
                                                            )
                                                        "
                                                        class="m-1 btn btn-primary"
                                                        :data-id="item.id"
                                                        ><i
                                                            class="fa fa-eye"
                                                        ></i
                                                    ></a>
                                                </td>
                                            </tr>
                                        </template>
                                        <template v-else>
                                            <tr>
                                                <td
                                                    colspan="8"
                                                    class="text-center"
                                                >
                                                    SIN REGISTROS
                                                </td>
                                            </tr>
                                        </template>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <VerificarComprobante
            :open_dialog="open_dialog_verif"
            :participante="itemSubastaCliente"
            @envio-formulario="actualizaFila"
            @cerrar-dialog="open_dialog_verif = false"
        ></VerificarComprobante>
    </Content>
</template>
<style scoped>
.table_participantes tbody tr td {
    font-size: 0.8em;
}
</style>
