<script setup>
import Content from "@/Components/Content.vue";
import { computed, onMounted, ref } from "vue";
import { Head, usePage, Link } from "@inertiajs/vue3";
import { useAppStore } from "@/stores/aplicacion/appStore";
const appStore = useAppStore();

const cargarListas = () => {};

const listSucursals = ref([]);

onMounted(() => {
    appStore.stopLoading();
    cargarListas();
});

const form = ref({
    tipo: "todos",
    formato: "pdf",
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const listTipos = ref([
    {
        value: "todos",
        label: "TODOS",
    },
    {
        value: "ADMINISTRADOR",
        label: "ADMINISTRADOR",
    },
    {
        value: "OPERADOR",
        label: "OPERADOR",
    },
]);

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
    const url = route("reportes.r_usuarios", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};
</script>
<template>
    <Head title="Reporte Usuarios"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Usuarios</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Reportes > Usuarios
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
                                    <label class="mb-0"
                                        >Seleccionar Tipo*</label
                                    >
                                    <select
                                        :hide-details="
                                            form.errors?.tipo ? false : true
                                        "
                                        :error="
                                            form.errors?.tipo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.tipo
                                                ? form.errors?.tipo
                                                : ''
                                        "
                                        v-model="form.tipo"
                                        class="form-control"
                                    >
                                        <option
                                            v-for="item in listTipos"
                                            :value="item.value"
                                        >
                                            {{ item.label }}
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-12 mt-1">
                                    <label class="mb-0">Formato*</label>
                                    <select
                                        :hide-details="
                                            form.errors?.formato ? false : true
                                        "
                                        :error="
                                            form.errors?.formato ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.formato
                                                ? form.errors?.formato
                                                : ''
                                        "
                                        v-model="form.formato"
                                        class="form-control"
                                    >
                                        <option
                                            v-for="item in listTipoReporte"
                                            :value="item.value"
                                        >
                                            {{ item.label }}
                                        </option>
                                    </select>
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
