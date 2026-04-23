<script setup>
import App from "@/Layouts/App.vue";
defineOptions({
    layout: App,
});
import Content from "@/Components/Content.vue";
import { usePage, Head, Link } from "@inertiajs/vue3";
import { onMounted, onBeforeMount, ref, computed, nextTick } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Highcharts from "highcharts";
import "highcharts/modules/exporting";
import "highcharts/modules/accessibility";
Highcharts.setOptions({
    lang: {
        downloadPNG: "Descargar PNG",
        downloadJPEG: "Descargar JPEG",
        downloadPDF: "Descargar PDF",
        downloadSVG: "Descargar SVG",
        printChart: "Imprimir gráfico",
        contextButtonTitle: "Menú de exportación",
        viewFullscreen: "Pantalla completa",
        exitFullscreen: "Salir de pantalla completa",
    },
});
const { auth } = usePage().props;
const user = ref(auth.user);

const props_page = defineProps({
    array_infos: {
        type: Array,
    },
});

const filtroGrafico1 = ref([
    {
        value: "semanal",
        label: "Ultimos 7 días",
    },
    {
        value: "meses",
        label: "Por meses",
    },
    {
        value: "gestion",
        label: "Por Años",
    },
]);

const form1 = ref({
    tipo: "semanal",
});

const generarReporte1 = () => {
    axios
        .get(route("ventasLinea"), {
            params: form1.value,
        })
        .then((response) => {
            nextTick(() => {
                const containerId = `container`;
                const container = document.getElementById(containerId);
                // Verificar que el contenedor exista y tenga un tamaño válido
                if (container) {
                    renderChart1(
                        containerId,
                        response.data.categories,
                        response.data.total_final,
                        response.data.data,
                    );
                } else {
                    console.error(`Contenedor ${containerId} no válido.`);
                }
            });
            // Create the chart
        });
};

const renderChart1 = (containerId, categories, total_final, data) => {
    Highcharts.chart(containerId, {
        chart: {
            type: "line",
        },
        title: {
            align: "center",
            text: `VENTAS REALIZADAS`,
        },
        subtitle: {
            align: "center",
            text: `Total ventas: ${total_final}`,
        },
        accessibility: {
            announceNewData: {
                enabled: true,
            },
        },
        xAxis: {
            categories: categories,
        },
        yAxis: {
            title: {
                text: "TOTAL",
            },
        },
        legend: {
            enabled: true,
        },
        plotOptions: {
            series: {
                depth: 100,
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    // format: "{point.y}",
                    style: {
                        fontSize: "11px",
                        fontWeight: "bold",
                    },
                },
            },
        },
        tooltip: {
            useHTML: true,
            formatter: function () {
                return `
                    <div style="text-align:center;">
                        <div style="display:inline-block; width:12px; height:12px; background:${this.point.color}; border-radius:50%; margin-right:5px;"></div>
                        <strong style="color:${this.point.color};">${this.point.series.name}</strong>
                        <br>
                        <span class="text-md"><strong>Total:</strong> ${this.point.y}</span>
                    </div>
                    `;
            },
        },

        series: [
            {
                name: "Ventas realizadas",
                data: data,
            },
        ],
    });
};

const filtroGrafico2 = ref([
    {
        value: "semanal",
        label: "Ultimos 7 días",
    },
    {
        value: "meses",
        label: "Por meses",
    },
    {
        value: "gestion",
        label: "Por Años",
    },
]);

const form2 = ref({
    tipo: "semanal",
});

const generarReporte2 = () => {
    axios
        .get(route("pujasLinea"), {
            params: form2.value,
        })
        .then((response) => {
            nextTick(() => {
                const containerId = `container2`;
                const container = document.getElementById(containerId);
                // Verificar que el contenedor exista y tenga un tamaño válido
                if (container) {
                    renderChart2(
                        containerId,
                        response.data.categories,
                        response.data.total_final,
                        response.data.data,
                    );
                } else {
                    console.error(`Contenedor ${containerId} no válido.`);
                }
            });
            // Create the chart
        });
};

const renderChart2 = (containerId, categories, total_final, data) => {
    Highcharts.chart(containerId, {
        chart: {
            type: "line",
        },
        title: {
            align: "center",
            text: `OFERTAS EN SUBASTAS REALIZADAS`,
        },
        subtitle: {
            align: "center",
            text: `Total ventas: ${total_final}`,
        },
        accessibility: {
            announceNewData: {
                enabled: true,
            },
        },
        xAxis: {
            categories: categories,
        },
        yAxis: {
            title: {
                text: "TOTAL",
            },
        },
        legend: {
            enabled: true,
        },
        plotOptions: {
            series: {
                depth: 100,
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    // format: "{point.y}",
                    style: {
                        fontSize: "11px",
                        fontWeight: "bold",
                    },
                },
            },
        },
        tooltip: {
            useHTML: true,
            formatter: function () {
                return `
                    <div style="text-align:center;">
                        <div style="display:inline-block; width:12px; height:12px; background:${this.point.color}; border-radius:50%; margin-right:5px;"></div>
                        <strong style="color:${this.point.color};">${this.point.series.name}</strong>
                        <br>
                        <span class="text-md"><strong>Total:</strong> ${this.point.y}</span>
                    </div>
                    `;
            },
        },

        series: [
            {
                name: "Ofertas en subastas realizadas",
                data: data,
            },
        ],
    });
};

const generarReporte3 = () => {
    axios.get(route("ingresosVentasSubastas")).then((response) => {
        nextTick(() => {
            const containerId = `container3`;
            const container = document.getElementById(containerId);
            // Verificar que el contenedor exista y tenga un tamaño válido
            if (container) {
                renderChart3(
                    containerId,
                    response.data.categories,
                    response.data.total_final,
                    response.data.data,
                );
            } else {
                console.error(`Contenedor ${containerId} no válido.`);
            }
        });
        // Create the chart
    });
};

const renderChart3 = (containerId, categories, total_final, data) => {
    Highcharts.chart(containerId, {
        chart: {
            type: "pie",
        },
        title: {
            align: "center",
            text: `INGRESOS VENTAS/SUBASTAS`,
        },
        subtitle: {
            align: "center",
            text: `Total: ${total_final.toFixed(2)}`,
        },
        accessibility: {
            announceNewData: {
                enabled: true,
            },
        },
        yAxis: {
            title: {
                text: "TOTAL",
            },
        },
        legend: {
            enabled: true,
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: "pointer",
                dataLabels: [
                    {
                        enabled: true,
                        distance: 20,
                    },
                    {
                        enabled: true,
                        distance: -20,
                        format: "{point.percentage:.2f}%",
                        style: {
                            fontSize: "0.7em",
                            textOutline: "none",
                            opacity: 0.7,
                        },
                        filter: {
                            operator: ">",
                            property: "percentage",
                            value: 10,
                        },
                    },
                ],
            },
        },
        tooltip: {
            useHTML: true,
            formatter: function () {
                return `
                    <div style="text-align:center;">
                        <div style="display:inline-block; width:12px; height:12px; background:${this.point.color}; border-radius:50%; margin-right:5px;"></div>
                        <strong style="color:${this.point.color};">${this.point.series.name}</strong><br/>${this.point.percentage.toFixed(2)}%
                        <br>
                        <span class="text-md"><strong>Total:</strong> ${this.point.y}</span>
                    </div>
                    `;
            },
        },

        series: [
            {
                name: "Ingresos Ventas/Subastas",
                data: data,
            },
        ],
    });
};

const generarReporte4 = () => {
    axios.get(route("ingresosCategorias")).then((response) => {
        nextTick(() => {
            const containerId = `container4`;
            const container = document.getElementById(containerId);
            // Verificar que el contenedor exista y tenga un tamaño válido
            if (container) {
                renderChart4(
                    containerId,
                    response.data.categories,
                    response.data.total_final,
                    response.data.data,
                );
            } else {
                console.error(`Contenedor ${containerId} no válido.`);
            }
        });
        // Create the chart
    });
};

const renderChart4 = (containerId, categories, total_final, data) => {
    Highcharts.chart(containerId, {
        chart: {
            type: "pie",
        },
        title: {
            align: "center",
            text: `INGRESOS POR CATEGORÍAS`,
        },
        subtitle: {
            align: "center",
            text: `Total: ${total_final.toFixed(2)}`,
        },
        accessibility: {
            announceNewData: {
                enabled: true,
            },
        },
        yAxis: {
            title: {
                text: "TOTAL",
            },
        },
        legend: {
            enabled: true,
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: "pointer",
                dataLabels: [
                    {
                        enabled: true,
                        distance: 20,
                    },
                    {
                        enabled: true,
                        distance: -20,
                        format: "{point.percentage:.2f}%",
                        style: {
                            fontSize: "0.7em",
                            textOutline: "none",
                            opacity: 0.7,
                        },
                        filter: {
                            operator: ">",
                            property: "percentage",
                            value: 10,
                        },
                    },
                ],
            },
        },
        tooltip: {
            useHTML: true,
            formatter: function () {
                return `
                    <div style="text-align:center;">
                        <div style="display:inline-block; width:12px; height:12px; background:${this.point.color}; border-radius:50%; margin-right:5px;"></div>
                        <strong style="color:${this.point.color};">${this.point.series.name}</strong><br/>${this.point.percentage.toFixed(2)}%
                        <br>
                        <span class="text-md"><strong>Total:</strong> ${this.point.y}</span>
                    </div>
                    `;
            },
        },

        series: [
            {
                name: "Ingresos Ventas/Subastas",
                data: data,
            },
        ],
    });
};

const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const { props } = usePage();

onMounted(() => {
    generarReporte1();
    generarReporte2();
    generarReporte3();
    generarReporte4();
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Inicio"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Inicio</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">Inicio</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-lg-3 col-6" v-for="item in array_infos">
                <!-- small box -->
                <div class="small-box" :class="[item.color]">
                    <div class="inner">
                        <h3 class="text-white">{{ item.cantidad }}</h3>

                        <p>{{ item.label }}</p>
                    </div>
                    <div class="icon">
                        <i class="fa" :class="[item.icon]"></i>
                    </div>
                    <Link :href="route(item.url)" class="small-box-footer"
                        >Ver más <i class="fa fa-arrow-alt-circle-right"></i
                    ></Link>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <select
                                    v-model="form1.tipo"
                                    class="form-control text-sm"
                                    @change="generarReporte1"
                                >
                                    <option
                                        v-for="item in filtroGrafico1"
                                        :value="item.value"
                                    >
                                        {{ item.label }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-12">
                                <div id="container"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <select
                                    v-model="form2.tipo"
                                    class="form-control text-sm"
                                    @change="generarReporte2"
                                >
                                    <option
                                        v-for="item in filtroGrafico2"
                                        :value="item.value"
                                    >
                                        {{ item.label }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-12">
                                <div id="container2"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <div id="container3"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <div id="container4"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
<style scoped>
.item_btn {
    margin: 10px;
}

.contenido_item i {
    color: black;
}

.contenido_item {
    transition: all 0.8s;
    color: black;
    padding: 10px;
    cursor: pointer;
    background-color: rgb(248, 229, 229);
    border: solid 2px rgb(243, 211, 211);
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    font-size: 1.3em;
    flex-direction: column;
}
</style>
