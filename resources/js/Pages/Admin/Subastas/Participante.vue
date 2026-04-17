<script setup>
import Content from "@/Components/Content.vue";
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
                        <li class="breadcrumb-item">
                            <Link
                                :href="
                                    route(
                                        'subastas.participantes',
                                        participante.subasta_id,
                                    )
                                "
                                >Participantes</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Participante</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
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
                                class="btn btn-default"
                                ><i class="fa fa-arrow-left"></i> Volver</Link
                            >
                        </h4>
                    </div>
                    <!-- END panel-heading -->
                    <!-- BEGIN panel-body -->
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <i class="fa fa-gavel"></i> Producto
                                            Subastado
                                        </h4>
                                    </div>
                                    <div class="card-body">
                                        <PublicacionAdmin
                                            :publicacion="
                                                itemParticipante.subasta
                                            "
                                            :column="true"
                                            :link="true"
                                        ></PublicacionAdmin>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <i class="fa fa-user"></i> Datos
                                            Participante
                                        </h4>
                                    </div>
                                    <div class="card-body">
                                        <p>
                                            <strong>Nombre Completo:</strong>
                                            {{
                                                itemParticipante?.user
                                                    ?.full_name
                                            }}
                                        </p>
                                        <p>
                                            <strong>C.I.:</strong>
                                            {{
                                                itemParticipante?.user?.full_ci
                                            }}
                                        </p>
                                        <p>
                                            <strong>Puja actual:</strong>
                                            Bs.
                                            {{
                                                getFormatoMoneda(
                                                    itemParticipante?.monto_puja,
                                                )
                                            }}
                                        </p>
                                        <p>
                                            <strong
                                                >Estado comprobante:
                                            </strong>
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
                                            <strong
                                                >Verificar comprobante:
                                            </strong>
                                            <button
                                                class="btn btn-success"
                                                @click="verificaComprobante"
                                            >
                                                <i class="fa fa-check"></i>
                                            </button>
                                        </p>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <i class="fa fa-id-card"></i> Datos
                                            Complementarios
                                        </h4>
                                    </div>
                                    <div class="card-body">
                                        <p>
                                            <strong>Dpto. Residencia:</strong>
                                            {{
                                                itemParticipante?.user
                                                    ?.user_dato.dpto_residencia
                                            }}
                                        </p>
                                        <p>
                                            <strong
                                                >Banco Devolución
                                                Garantías:</strong
                                            >
                                            {{
                                                itemParticipante?.user
                                                    ?.user_dato.banco
                                            }}
                                        </p>
                                        <p>
                                            <strong>Nro. de cuenta:</strong>
                                            {{
                                                itemParticipante?.user
                                                    ?.user_dato.nro_cuenta
                                            }}
                                        </p>
                                        <div class="row">
                                            <div class="col-md-6 text-center">
                                                <label
                                                    >C.I. Anverso
                                                    <a
                                                        :href="
                                                            itemParticipante
                                                                ?.user
                                                                ?.user_dato
                                                                .url_ci_anverso
                                                        "
                                                        target="_blank"
                                                        class="btn btn-primary btn-sm text-sm"
                                                    >
                                                        <i
                                                            class="fa fa-download"
                                                        ></i></a
                                                ></label>
                                                <template
                                                    v-if="
                                                        itemParticipante?.user
                                                            ?.user_dato
                                                            .tipo_anverso ==
                                                        'imagen'
                                                    "
                                                >
                                                    <img
                                                        :src="
                                                            itemParticipante
                                                                ?.user
                                                                ?.user_dato
                                                                .url_ci_anverso
                                                        "
                                                        alt=""
                                                        width="100%"
                                                    />
                                                </template>
                                            </div>
                                            <div class="col-md-6 text-center">
                                                <label
                                                    >C.I. Reverso
                                                    <a
                                                        :href="
                                                            itemParticipante
                                                                ?.user
                                                                ?.user_dato
                                                                .url_ci_reverso
                                                        "
                                                        target="_blank"
                                                        class="btn btn-primary btn-sm text-sm"
                                                    >
                                                        <i
                                                            class="fa fa-download"
                                                        ></i></a
                                                ></label>
                                                <template
                                                    v-if="
                                                        itemParticipante?.user
                                                            ?.user_dato
                                                            .tipo_reverso ==
                                                        'imagen'
                                                    "
                                                >
                                                    <img
                                                        :src="
                                                            itemParticipante
                                                                ?.user
                                                                ?.user_dato
                                                                .url_ci_reverso
                                                        "
                                                        alt=""
                                                        width="100%"
                                                    />
                                                </template>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">
                                            <i class="fa fa-list"></i> Historial
                                            de pujas
                                        </h4>
                                    </div>
                                    <div class="card-body px-1 pt-2">
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
                                                        {{ item.fecha_hora }}
                                                    </td>
                                                    <td>
                                                        {{
                                                            getFormatoMoneda(
                                                                item.monto,
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
    </Content>
</template>
