<script>
import SliderImagenes from "@/Components/SliderImagenes.vue";
import DetalleSubasta from "@/Components/DetalleSubasta.vue";
import ModalComprobante from "@/Components/ModalComprobante.vue";
import ModalPuja from "@/Components/ModalPuja.vue";
import HistorialOfertas from "@/Components/HistorialOfertas.vue";
</script>
<script setup>
import { usePage, Link } from "@inertiajs/vue3";
import { onMounted, ref, inject, computed, onBeforeUnmount, watch } from "vue";
import { useFormater } from "@/composables/useFormater";
import axios from "axios";
const { getFormatoMoneda } = useFormater();
const { props: props_page } = usePage();
const props = defineProps({
    publicacion: {
        type: Object,
        default: null,
    },
    link: {
        type: Boolean,
        default: false,
    },
    column: {
        type: Boolean,
        default: false,
    },
    detalle_lista: {
        type: Boolean,
        default: false,
    },
});
const verificaUser = inject("verificaUser");
const verificarPujaUser = inject("verificarPujaUser");
const oPublicacion = ref(props.publicacion);
const oParticipante = ref(null);
const modal_dialog = ref(false);
const modal_dialog_comprobante = ref(false);
const modal_dialog_puja = ref(false);
const modal_dialog_historial_ofertas = ref(false);
const data_puja = ref(null);
const swRealizarOferta = ref(true);

watch(
    () => props.publicacion,
    (newValue) => {
        oPublicacion.value = newValue;
        swRealizarOferta.value =
            oPublicacion.value.esta_vigente == true ? true : false;
    },
);

watch(oPublicacion.value, (newValue) => {
    oPublicacion.value = newValue;
    swRealizarOferta.value =
        oPublicacion.value.esta_vigente == true ? true : false;
});

const verDetallesPublicacion = () => {
    modal_dialog.value = true;
};

const realizarOferta = async () => {
    if (verificaUser()) {
        // mostrar puja
        data_puja.value = await verificarPujaUser(
            props_page.auth.user.id,
            oPublicacion.value.id,
        );
        // console.log(data_puja);
        if (data_puja.value && data_puja.value.participante) {
            // verificar estado_comprobante

            // mostrar info para registrar puja
            oParticipante.value = data_puja.value.participante;
            // console.log(oParticipante.value);
            if (
                oParticipante.value.estado_comprobante == 1 ||
                oParticipante.value.estado_comprobante == 0
            ) {
                modal_dialog_puja.value = true;
            } else if (oParticipante.value.estado_comprobante == 2) {
                // mostrar registro de comprobante nuevo
                modal_dialog_comprobante.value = true;
            }
        } else {
            // mostrar registro de comprobante
            modal_dialog_comprobante.value = true;
        }
    }
};

const muestraFormPuja = (participante) => {
    oParticipante.value = participante;
    modal_dialog_comprobante.value = false;
    modal_dialog_puja.value = true;
};

const obtieneInfoParticipante = async () => {
    if (props_page.auth && props_page.auth.user) {
        data_puja.value = await verificarPujaUser(
            props_page.auth.user.id,
            oPublicacion.value.id,
        );
        if (data_puja.value && data_puja.value.participante) {
            oParticipante.value = data_puja.value.participante;

            clearInterval(intervalParticipantes.value);
            intervalParticipantes.value = setInterval(() => {
                obtenerOfertasSubasta();
            }, 1000);
        } else {
            oParticipante.value = null;
        }
        // console.log(oParticipante.value);
    }
};

const actualizaPublicacion = (newVal) => {
    oPublicacion.value = newVal;
    obtieneInfoParticipante();
};

const segundosDif = ref(0);
const minutosDif = ref(0);
const horasDif = ref(0);
const diasDif = ref(0);
const strRestante = ref("");
const intervalConteo = ref(null);

const iniciaConteoFinalizacion = () => {
    // Fecha en formato DD/MM/YYYY HH:MM:SS
    // Fecha actual
    const fechaActual = new Date();
    let fechaStr = "";
    if (oPublicacion.value) {
        fechaStr = oPublicacion.value.fecha_hora_limite;
        // Separar la fecha y la hora
        const [fecha, hora] = fechaStr.split(" ");
        const [dia, mes, anio] = fecha.split("/");
        const [horas, minutos, segundos] = hora.split(":");

        // Crear el objeto Date con los valores separados (meses empiezan en 0)
        const fechaObjetivo = new Date(
            anio,
            mes - 1,
            dia,
            horas,
            minutos,
            segundos,
        );

        // Calcular la diferencia en milisegundos
        const diferenciaMs = fechaObjetivo - fechaActual;

        // Convertir la diferencia a segundos, minutos, horas y días
        segundosDif.value = Math.floor((diferenciaMs / 1000) % 60);
        minutosDif.value = Math.floor((diferenciaMs / (1000 * 60)) % 60);
        horasDif.value = Math.floor((diferenciaMs / (1000 * 60 * 60)) % 24);
        diasDif.value = Math.floor(diferenciaMs / (1000 * 60 * 60 * 24));

        if (
            segundosDif.value < 1 &&
            minutosDif.value <= 0 &&
            horasDif.value <= 0 &&
            diasDif.value <= 0
        ) {
            verificarGanadorPublicacion();
            clearInterval(intervalConteo.value);
            oPublicacion.value.esta_vigente = false;
            swRealizarOferta.value = false;
        }
    }

    strRestante.value = `${diasDif.value}d ${horasDif.value}h ${minutosDif.value}m ${segundosDif.value}s`;
};

const verificarGanadorPublicacion = () => {
    axios
        .post(route("subastas.verificaGanador", oPublicacion.value.id))
        .then((response) => {
            // console.log(response);
            oPublicacion.value = response.data.publicacion;
        });
};

const verificaSwOferta = () => {
    if (oPublicacion.value.estado_subasta == 1) {
        iniciaConteoFinalizacion();
        intervalConteo.value = setInterval(() => {
            iniciaConteoFinalizacion();
        }, 1000);
    } else {
        swRealizarOferta.value = false;
    }
};

const btnTxtRealizarOferta = computed(() => {
    console.log(oParticipante.value);
    if (
        oParticipante.value &&
        (oParticipante.value.estado_comprobante == 0 ||
            oParticipante.value.estado_comprobante == 2)
    )
        return "Pendiente";
    return "Realizar una oferta";
});

const verificaClienteTop = (id) => {
    if (
        id &&
        oPublicacion.value.subasta &&
        oPublicacion.value.subasta.historial_ofertas
    ) {
        let res = oPublicacion.value.subasta.historial_ofertas.filter(
            (elem) => elem.participante_id == id,
        );
        return res.length > 0;
    }
    return true;
};

const obtenerOfertasSubasta = () => {
    if (oPublicacion.value && oPublicacion.value.subasta) {
        axios
            .get(route("subastas.ofertas", oPublicacion.value.subasta.id))
            .then((response) => {
                if (response.data.estado_puja != null) {
                    oParticipante.value.estado_puja = response.data.estado_puja;
                }

                oPublicacion.value.subasta.historial_ofertas =
                    response.data.historial_ofertas;
            });
    }
};

const verOfertas = () => {
    if (oPublicacion.value) {
        modal_dialog_historial_ofertas.value = true;
    }
};

var intervalParticipantes = ref(null);

onMounted(() => {
    swRealizarOferta.value =
        oPublicacion.value.esta_vigente == true ? true : false;

    obtieneInfoParticipante();
    verificaSwOferta();
    if (props.detalle_lista && oPublicacion.value.estado_subasta == 1) {
        intervalParticipantes.value = setInterval(() => {
            obtenerOfertasSubasta();
        }, 1000);
    }
});

onBeforeUnmount(() => {
    clearInterval(intervalConteo.value);
    clearInterval(intervalParticipantes.value);
});
</script>
<template>
    <HistorialOfertas
        v-if="props_page.auth"
        :open_dialog="modal_dialog_historial_ofertas"
        :publicacion_id="oPublicacion.id"
        @cerrar-dialog="modal_dialog_historial_ofertas = false"
    ></HistorialOfertas>
    <DetalleSubasta
        :open_dialog="modal_dialog"
        :publicacion="oPublicacion"
        :detalles="oPublicacion.publicacion_detalles"
        @cerrar-dialog="modal_dialog = false"
    ></DetalleSubasta>
    <ModalComprobante
        :open_dialog="modal_dialog_comprobante"
        :publicacion="oPublicacion"
        :participante="oParticipante"
        @cerrar-dialog="modal_dialog_comprobante = false"
        @envio-formulario="muestraFormPuja"
    ></ModalComprobante>
    <ModalPuja
        :open_dialog="modal_dialog_puja"
        :publicacion="oPublicacion"
        :participante="oParticipante"
        @cerrar-dialog="modal_dialog_puja = false"
        @envio-formulario="actualizaPublicacion"
    ></ModalPuja>
    <div class="border-0 mb-4 mx-2">
        <div class="row">
            <!-- BEGIN product-detail -->
            <div
                class="contenedor_imagen p-0"
                :class="[
                    props.column ? 'flex-column' : '',
                    props.detalle_lista
                        ? 'col-md-6 product_info_imagen'
                        : 'col-md-12',
                ]"
            >
                <!-- tiempo restante -->
                <div class="tiempoRestante" v-if="swRealizarOferta">
                    <strong>Quedan</strong>
                    <span v-text="strRestante"></span>
                </div>
                <!-- BEGIN product-image -->
                <div
                    class="product-image flex-column"
                    :class="[props.column ? ' w-100' : '']"
                >
                    <!-- BEGIN product-main-image -->
                    <div class="product-main-image">
                        <SliderImagenes
                            :imagenes="publicacion.producto.producto_imagens"
                        ></SliderImagenes>
                    </div>
                    <!-- END product-main-image -->
                    <div class="row fila_detalle pt-3" style="">
                        <div class="col-12 text-center" v-if="link">
                            <Link
                                v-if="oPublicacion"
                                class="btn btn-primary btn-sm"
                                :href="route('portal.subasta', oPublicacion.id)"
                            >
                                <i class="fa fa-arrow-right"></i>
                            </Link>
                        </div>
                        <!-- FIN tiempo restante -->
                        <div
                            class="col-12 mt-2 mb-0 p-0"
                            style="margin: 0px 0px; padding: 0px 6px 0px 6px"
                        >
                            <h4
                                class="w-100 text-center card-title font-weight-bold"
                            >
                                {{ oPublicacion.producto.nombre }}
                            </h4>
                            <div class="row">
                                <div class="col-12">
                                    <button
                                        type="button"
                                        class="btn btn-sm w-100 rounded-0 mx-0 text-gray"
                                        @click.prevent="verDetallesPublicacion"
                                    >
                                        Detalles
                                        <i class="fa fa-external-link-alt"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2" v-if="!column">
                                <div
                                    class="col-12 text-center font-weight-bold text-md"
                                >
                                    Oferta inicial
                                    <i class="fa fa-arrow-right"></i>
                                    Bs.
                                    {{
                                        getFormatoMoneda(
                                            oPublicacion.monto_inicial,
                                        )
                                    }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END product-image -->
                <!-- BEGIN product-info -->
                <div class="product-info p-3">
                    <!-- BEGIN product-info-header -->
                    <!-- <div class="product-info-header">
                        <h4 class="product-title w-100 text-center">Ofertas</h4>
                    </div> -->
                    <div class="row">
                        <div class="col-12" v-if="column">
                            <div class="row mb-3">
                                <div
                                    class="text_info col-md-6 font-weight-bold"
                                >
                                    Oferta inicial:
                                </div>
                                <div class="col-md-6 txt_info2">
                                    Bs.
                                    {{
                                        getFormatoMoneda(
                                            oPublicacion.monto_inicial,
                                        )
                                    }}
                                </div>
                                <div
                                    class="text_info col-md-6 font-weight-bold"
                                >
                                    Oferta actual:
                                </div>
                                <template
                                    v-if="
                                        oPublicacion.subasta &&
                                        oPublicacion.subasta?.historial_ofertas
                                            ?.length > 0
                                    "
                                >
                                    <div class="col-md-6 txt_info2">
                                        Bs.
                                        {{
                                            getFormatoMoneda(
                                                oPublicacion.subasta
                                                    .participantes_puja[0].puja,
                                            )
                                        }}
                                    </div>
                                </template>
                                <template v-else>
                                    <div class="col-md-6 txt_info2">
                                        Sin registros aún
                                    </div>
                                </template>
                            </div>
                        </div>
                    </div>
                    <!-- END product-info-header -->
                    <!-- BEGIN product-purchase-container -->
                    <div class="text-center mb-21">
                        <!-- <div
                            v-if="
                                oParticipante &&
                                oParticipante.estado == 2
                            "
                            class="alert alert-success"
                        >
                            GANADOR
                        </div> -->
                        <button
                            class="btn btn-lg mb-2"
                            @click="realizarOferta"
                            :class="[
                                !oParticipante || oParticipante.estado == 0
                                    ? 'btn-danger'
                                    : 'btn-success bg-green',
                            ]"
                            v-if="swRealizarOferta"
                            v-text="btnTxtRealizarOferta"
                        ></button>
                        <div v-else>
                            <span
                                class="text-danger font-weight-bold d-block mb-2 txt_subasta_concluida"
                                >SUBASTA CONCLUIDA</span
                            >
                        </div>
                    </div>
                    <!-- END product-purchase-container -->
                </div>
                <!-- END product-info -->
            </div>
            <div
                class="col-md-6 p-0 bg-white cont_ofertas pt-3"
                v-if="detalle_lista"
            >
                <div class="product-info-header">
                    <h4
                        class="product-title w-100 text-center font-weight-bold"
                    >
                        OFERTAS
                    </h4>
                </div>
                <table class="table tabla_ofertas">
                    <thead>
                        <tr class="bg-primary">
                            <th class="text-white" width="2%">#</th>
                            <th class="text-white">Oferta</th>
                        </tr>
                    </thead>
                    <tbody>
                        <template
                            v-if="
                                oPublicacion.subasta &&
                                oPublicacion.subasta.historial_ofertas &&
                                oPublicacion.subasta.historial_ofertas.length >
                                    0
                            "
                        >
                            <tr
                                v-for="(item, index) in oPublicacion.subasta
                                    .historial_ofertas"
                                :class="[
                                    index == 0 ? 'h2' : '',
                                    index == 1 ? 'h4' : '',
                                    oParticipante &&
                                    oParticipante.id == item.participante_id
                                        ? 'bg-teal text-white'
                                        : '',
                                ]"
                            >
                                <td class="">{{ index + 1 }})</td>
                                <td class="">
                                    Bs.
                                    {{ getFormatoMoneda(item.puja) }}
                                    <small
                                        v-if="
                                            oParticipante &&
                                            oParticipante.id ==
                                                item.participante_id
                                        "
                                        >(Mi oferta)</small
                                    >
                                </td>
                            </tr>

                            <tr
                                v-if="!verificaClienteTop(oParticipante?.id)"
                                class="bg-teal text-white"
                            >
                                <td>-</td>
                                <td>
                                    Bs.
                                    {{ getFormatoMoneda(oParticipante?.puja) }}
                                    <small>(Mi oferta)</small>
                                </td>
                            </tr>
                        </template>
                        <template v-else>
                            <tr>
                                <td colspan="2" class="text-center">
                                    Sin registros aún
                                </td>
                            </tr>
                        </template>
                    </tbody>
                </table>
                <div
                    class="row"
                    v-if="
                        props_page.auth &&
                        props_page.auth.user &&
                        props_page.auth.user.role_id == 2
                    "
                >
                    <div class="col-12 text-center">
                        <button
                            class="btn btn-outline-primary"
                            @click="verOfertas"
                        >
                            Mis ofertas <i class="fa fa-external-link"></i>
                        </button>
                    </div>
                </div>
            </div>
            <!-- END product-detail -->
        </div>
    </div>
</template>
<style scoped>
.product-info,
.product-image {
    background-color: rgb(255, 255, 255);
    border-bottom: solid 1px;
    border-color: var(--bg_blue_dark);
}

.product-info {
    border-bottom: solid 3px;
    border-color: var(--principal-portal);
}

.fila_detalle {
    margin: auto;
    max-width: 100%;
    position: relative;
}
.product-detail {
    position: relative;
}

.tiempoRestante {
    display: flex;
    flex-direction: column;
    background-color: rgba(0, 179, 45, 0.767);
    color: white;
    text-align: center;
    padding: 5px;
    min-width: 130px;
    width: 20%;
    border-radius: 5px 0px 6px 0px;
    position: absolute;
    left: 0px;
    top: 0px;
    z-index: 500;
}

.contenedor_imagen {
    position: relative;
}

.product_info_imagen {
    border-right: solid 1px rgb(204, 204, 204);
}

.text_info {
    text-align: right;
}

.detalles_principal {
    font-weight: bold;
}

.detalles_principal .col-12 {
    padding: 10px;
}
.tabla_ofertas tbody tr:hover {
    background-color: transparent;
}

.contenedor_detalles p {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

@media (max-width: 900px) {
    .text_info {
        text-align: center;
    }

    .txt_info2 {
        text-align: center;
    }
    .cont_ofertas {
        border-top: solid 1px white;
    }
}
</style>
