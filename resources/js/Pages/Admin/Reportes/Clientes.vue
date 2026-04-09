<script setup>
import Content from "@/Components/Content.vue";
import { computed, onBeforeMount, onMounted, ref } from "vue";
import { Head, usePage, Link } from "@inertiajs/vue3";
import { useAppStore } from "@/stores/aplicacion/appStore";
const appStore = useAppStore();

const cargarListas = () => {};

onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    cargarListas();
    appStore.stopLoading();
});

const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};

const form = ref({
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
    formato: "pdf",
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const listTipos = ref([]);

const cargarTipoClientes = () => {
    axios.get(route("tipo_clientes.listado")).then((response) => {
        listTipos.value = response.data.map((item) => ({
            id: item,
            nombre: item,
        }));
        listTipos.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};

const listTipoReporte = ref([
    {
        value: "pdf",
        label: "PDF",
    },
    {
        value: "excel",
        label: "EXCEL",
    },
]);

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_clientes", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};
</script>
<template>
    <Head title="Reporte Lista de Clientes"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Lista de Clientes</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Reporte Lista de Clientes
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <form @submit.prevent="generarReporte">
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="mb-0">Rango de Fechas</label>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <input
                                                type="date"
                                                class="form-control"
                                                v-model="form.fecha_ini"
                                            />
                                        </div>
                                        <div class="col-md-6">
                                            <input
                                                type="date"
                                                class="form-control"
                                                v-model="form.fecha_fin"
                                            />
                                        </div>
                                    </div>
                                    <div
                                        class="text-muted w-100 text-center text-xs"
                                    >
                                        Dejar vacío para listar todos los
                                        clientes
                                    </div>
                                </div>
                                <div class="col-md-12 text-center mt-3">
                                    <button
                                        class="btn btn-primary"
                                        block
                                        @click="generarReporte"
                                        :disabled="generando"
                                        v-text="txtBtn"
                                    ></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
