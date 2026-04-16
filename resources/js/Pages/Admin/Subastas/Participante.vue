<script setup>
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, computed, onBeforeUnmount, onBeforeMount } from "vue";
import VerificarComprobante from "./VerificarComprobante.vue";
import { useFormater } from "@/composables/useFormater";
import PublicacionAdmin from "@/Components/PublicacionAdmin.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
const { getFormatoMoneda } = useFormater();
const props = defineProps({
    participante: {
        type: Object,
        default: null,
    },
});
const { props: props_page } = usePage();
const appStore = useAppStore();

const itemParticipante = ref(props.participante);
const open_dialog_verif = ref(false);

const estadoComprobante = computed(() => {
    let estado = `SIN VERIFICAR`;
    if (itemParticipante.value.estado_comprobante == 1) {
        estado = `VERIFICADO`;
    }

    if (itemParticipante.value.estado_comprobante == 2) {
        estado = `RECHAZADO`;
    }
    return estado;
});

const verificaComprobante = () => {
    itemParticipante.value = props.participante;
    open_dialog_verif.value = true;
};

const updateItemParticipante = (newVal) => {
    itemParticipante.value = newVal;
};

const loading = ref(false);
onBeforeMount(() => {
    appStore.startLoading();
});
onMounted(async () => {
    appStore.stopLoading();
});
onBeforeUnmount(() => {});
</script>
<template>
    <Head title="Subasta Clientes"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item">
            <Link :href="route('subastas.index')">Subastas</Link>
        </li>
        <li class="breadcrumb-item">
            <Link
                :href="
                    route('subastas.participantes', itemParticipante.subasta_id)
                "
                >Subasta-Clientes</Link
            >
        </li>
        <li class="breadcrumb-item active">Información cliente</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Información cliente</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <h4 class="panel-title btn-nuevo">
                        <Link
                            :href="
                                route(
                                    'subastas.participantes',
                                    itemParticipante.subasta_id,
                                )
                            "
                            class="btn btn-outline-default d-inline-block"
                            ><i class="fa fa-arrow-left"></i> Volver</Link
                        >
                    </h4>
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6 offset-md-3 p-3">
                            <PublicacionAdmin
                                :publicacion="itemParticipante.subasta"
                                :column="true"
                                :link="true"
                            ></PublicacionAdmin>
                        </div>
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <p>
                                        <strong>Nombre Cliente:</strong>
                                        {{
                                            itemParticipante?.cliente?.full_name
                                        }}
                                    </p>
                                    <p>
                                        <strong>Puja actual:</strong>
                                        {{
                                            getFormatoMoneda(
                                                itemParticipante?.puja,
                                            )
                                        }}
                                    </p>
                                    <p>
                                        <strong>Estado comprobante: </strong>
                                        <span
                                            class="badge"
                                            :class="{
                                                'bg-gray':
                                                    itemParticipante.estado_comprobante ==
                                                    0,
                                                'bg-success':
                                                    itemParticipante.estado_comprobante ==
                                                    1,
                                                'bg-danger':
                                                    itemParticipante.estado_comprobante ==
                                                    2,
                                            }"
                                            v-text="estadoComprobante"
                                        ></span>
                                    </p>
                                    <p>
                                        <strong>Verificar comprobante: </strong>
                                        <button
                                            class="btn btn-success"
                                            @click="verificaComprobante"
                                        >
                                            <i class="fa fa-check"></i>
                                        </button>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 offset-md-4 mt-3">
                            <div class="card">
                                <div class="card-header bg-primary">
                                    <h5 class="text-white">
                                        <i class="fa fa-list"></i> Historial de
                                        ofertas
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Fecha y Hora</th>
                                                <th>Monto</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr
                                                v-for="item in participante.participante_pujas"
                                            >
                                                <td>
                                                    {{
                                                        item.fecha_hora_oferta_t
                                                    }}
                                                </td>
                                                <td>
                                                    {{
                                                        getFormatoMoneda(
                                                            item.puja,
                                                        )
                                                    }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END panel-body -->
            </div>
            <!-- END panel -->
        </div>
    </div>
    <VerificarComprobante
        :open_dialog="open_dialog_verif"
        :participante="itemParticipante"
        @envio-formulario="updateItemParticipante"
        @cerrar-dialog="open_dialog_verif = false"
    ></VerificarComprobante>
</template>
