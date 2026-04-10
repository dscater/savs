<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useVentas } from "@/composables/ventas/useVentas";
import {
    watch,
    ref,
    computed,
    defineEmits,
    onMounted,
    nextTick,
    onBeforeMount,
} from "vue";
import axios from "axios";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const props = defineProps({
    venta: {
        type: Object,
        default: null,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
});

const { oVenta, setVenta, limpiarVenta } = useVentas();
const accion_form = ref(props.accion_formulario);
const enviando = ref(false);
let form = useForm(props.venta);
watch(
    () => props.venta,
    (newValue) => {
        console.log("ASDSDSDSD");
        form = useForm(newValue);
        setVenta(newValue);
    },
);
watch(
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
        if (accion_form.value == 0) {
            form["_method"] = "POST";
        }
    },
);

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        accion_form.value == 0
            ? route("ventas.store")
            : route("ventas.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: (response) => {
            console.log("correcto");
            const success =
                response.props.flash.success ?? "Proceso realizado con éxito";
            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `<strong>${success}</strong>`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-alert-success",
                },
            });
            form.reset();
            limpiarVenta();
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                const error =
                    "Existen errores en el formulario, por favor verifique";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            } else {
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
            }
            console.log("error: " + err.error);
        },
        onFinish: () => {
            enviando.value = false;
        },
    });
};

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Registrar venta`;
    }
    return `<i class="fa fa-edit"></i> Actualizar Venta`;
});

const oCliente = ref(null);
const listClientes = ref([]);
const cargarClientes = () => {
    axios.get(route("clientes.listado")).then((response) => {
        listClientes.value = response.data.clientes;
    });
};

const asignarCliente = (value) => {
    oCliente.value = null;
    form.cliente_id = "";
    form.nit_ci = "";
    if (!value) {
        return;
    }
    oCliente.value = listClientes.value.filter((item) => item.id == value)[0];
    form.cliente_id = oCliente.value.id;
    form.nit_ci = oCliente.value.nit_ci;
};

const cantidad = ref(1);
const codigoProducto = ref("");
const oProducto = ref(null);
const buscarProductoCodigo = () => {
    oProducto.value = null;
    axios
        .get(route("productos.byCodigo"), {
            params: {
                codigo: codigoProducto.value,
            },
        })
        .then((response) => {
            // verificar que no exista ya en la lista
            const existe = form.venta_detalles.some(
                (item) => item.producto_id === response.data.id,
            );

            if (!existe) {
                oProducto.value = response.data;
                toast.success(
                    `Producto ${response.data.nombre} cargado correctamente`,
                );
            } else {
                toast.info(`Producto ${response.data.nombre} ya fue agregado`);
            }
        })
        .catch((error) => {
            // mostrar error
            console.log(error);
            if (error.response && error.response.data.errors.error) {
                toast.error(`${error.response.data.errors.error[0]}`);
            } else {
                toast.error(`Ocurrió un error al intentar obtener el registro`);
            }
        })
        .finally(() => {
            // codigoProducto.value = "";
        });
};

const agregarProducto = () => {
    const existe = form.venta_detalles.some(
        (item) => item.producto_id === oProducto.value.id,
    );

    if (!oProducto.value) {
        toast.info(`No se cargo ningún producto`);
        return;
    }

    const valor = Number(cantidad.value);
    if (
        cantidad.value === null ||
        cantidad.value === "" ||
        isNaN(valor) ||
        valor < 1
    ) {
        toast.error("Debes ingresar una cantidad válida mayor o igual a 1");
        return;
    }
    if (!existe) {
        const subtotal = valor * parseFloat(oProducto.value.precio);

        form.venta_detalles.push({
            id: 0,
            venta_id: 0,
            producto: oProducto.value,
            producto_id: oProducto.value.id,
            precio: oProducto.value.precio,
            cantidad: valor,
            subtotal: subtotal.toFixed(2),
        });

        toast.success(
            `Producto ${oProducto.value.nombre} agregado correctamente`,
        );
        limpiarSeleccion();
    } else {
        toast.info(`Producto ${oProducto.value.nombre} ya fue agregado`);
    }
};

const limpiarSeleccion = () => {
    oProducto.value = null;
    codigoProducto.value = "";
    cantidad.value = 1;
};

const quitar = (index) => {
    form.venta_detalles.splice(index, 1);
};
const totalVenta = computed(() => {
    const total = form.venta_detalles.reduce((total, item) => {
        const subtotal = parseFloat(item.subtotal);

        if (subtotal !== null && subtotal !== undefined && subtotal !== "") {
            return total + Number(subtotal);
        }

        return total;
    }, 0);

    form.total = total;

    return total.toFixed(2);
});

const modificaCantidadFila = (e, index) => {
    const cantidad = e.target.value;
    const valor = Number(cantidad);
    if (cantidad === null || cantidad === "" || isNaN(valor) || valor < 1) {
        toast.error("Debes ingresar una cantidad válida mayor o igual a 1");
        return;
    }

    form.venta_detalles[index]["cantidad"] = valor;
    form.venta_detalles[index]["subtotal"] =
        valor * parseFloat(form.venta_detalles[index]["precio"]);
    form.venta_detalles[index]["subtotal"] =
        form.venta_detalles[index]["subtotal"].toFixed(2);
};

onMounted(() => {
    // console.log(form);
});
onBeforeMount(() => {
    cargarClientes();
});
</script>

<template>
    <form @submit.prevent="enviarFormulario()">
        <div class="row mb-0">
            <div class="col-md-12 col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fa fa-user"></i> Datos del Cliente
                        </h5>
                    </div>
                    <div class="card-body pt-1">
                        <div class="row">
                            <div class="col-12">
                                <small
                                    class="text-muted text-xs font-weight-bold"
                                    >Seleccionar Cliente</small
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-user-friends"></i>
                                        </span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <el-select
                                            class="el-select-input-group-right"
                                            size="large"
                                            v-model="form.cliente_id"
                                            filterable
                                            clereable
                                            placeholder="Seleccionar"
                                            no-data-text="Sin resultados"
                                            no-match-text="No se encontrarón coincidencias"
                                            @change="asignarCliente"
                                        >
                                            <el-option
                                                v-for="item in listClientes"
                                                :key="item.id"
                                                :value="item.id"
                                                :label="`${item.nombre} - ${item.nit_ci}`"
                                            ></el-option>
                                        </el-select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 mt-2">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{
                                                oCliente ? oCliente.nombre : "-"
                                            }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Nombre/Razón Social
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            <input
                                                type="text"
                                                class="form-control text-center"
                                                v-model="form.nit_ci"
                                            />
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            NIT/C.I.
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{ oCliente ? oCliente.cel : "-" }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Teléfono/Celular
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fa fa-boxes"></i> Productos
                        </h5>
                    </div>
                    <div class="card-body pt-1">
                        <div class="row">
                            <div class="col-12">
                                <small
                                    class="text-muted text-xs font-weight-bold"
                                    >Código de Producto</small
                                >
                                <div class="input-group mb-0">
                                    <div class="input-group-prepend">
                                        <span
                                            class="input-group-text bg-white"
                                            for="inputCodigo"
                                        >
                                            <i class="fa fa-box"></i>
                                        </span>
                                    </div>
                                    <input
                                        type="text"
                                        class="form-control"
                                        autocomplete="false"
                                        v-model="codigoProducto"
                                        @keypress.enter.prevent="
                                            buscarProductoCodigo
                                        "
                                    />

                                    <div class="input-group-append">
                                        <button
                                            class="btn btn-primary"
                                            type="button"
                                            @click.prevent="
                                                buscarProductoCodigo
                                            "
                                        >
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 mt-2">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{
                                                oProducto
                                                    ? oProducto.categoria
                                                          ?.nombre
                                                    : "-"
                                            }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Categoría
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{
                                                oProducto
                                                    ? oProducto.nombre
                                                    : "-"
                                            }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Nombre
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="text-center">
                                            {{
                                                oProducto
                                                    ? oProducto.stock
                                                    : "-"
                                            }}
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Disponible
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div
                                        class="col-md-4 offset-md-4 text-center"
                                    >
                                        <div class="input-group">
                                            <input
                                                type="number"
                                                step="1"
                                                class="form-control text-center"
                                                v-model="cantidad"
                                                @keypress.enter.prevent="
                                                    agregarProducto
                                                "
                                            />
                                            <div class="input-group-append">
                                                <button
                                                    class="btn btn-primary"
                                                    type="button"
                                                    @click.prevent="
                                                        agregarProducto
                                                    "
                                                >
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div
                                            class="w-100 text-center text-xs text-muted"
                                        >
                                            Cantidad
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12 col-lg-6 pb-0">
                <div class="card mb-0">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fa fa-shopping-cart"></i> Carrito
                        </h5>
                    </div>
                    <div class="card-body pt-1 overflow-auto">
                        <table class="table table-bordered">
                            <thead>
                                <tr class="bg-principal">
                                    <th class="text-xs">CÓDIGO</th>
                                    <th class="text-xs">DESCRIPCIÓN</th>
                                    <th class="text-xs">P/U BS.</th>
                                    <th class="text-xs" width="130px">
                                        CANTIDAD
                                    </th>
                                    <th class="text-xs">SUBTOTAL BS.</th>
                                    <th width="4%"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-if="form.venta_detalles.length > 0">
                                    <tr
                                        v-for="(
                                            item, index
                                        ) in form.venta_detalles"
                                    >
                                        <td>{{ item.producto.codigo }}</td>
                                        <td>{{ item.producto.nombre }}</td>
                                        <td>{{ item.producto.precio }}</td>
                                        <td>
                                            <input
                                                type="number"
                                                step="1"
                                                min="0"
                                                v-model="item.cantidad"
                                                class="form-control text-center"
                                                @keyup.prevent="
                                                    modificaCantidadFila(
                                                        $event,
                                                        index,
                                                    )
                                                "
                                                @change="
                                                    modificaCantidadFila(
                                                        $event,
                                                        index,
                                                    )
                                                "
                                            />
                                        </td>
                                        <td>{{ item.subtotal }}</td>
                                        <td>
                                            <button
                                                class="btn btn-sm btn-danger"
                                                @click="quitar(index)"
                                            >
                                                X
                                            </button>
                                        </td>
                                    </tr>
                                </template>
                                <template v-else>
                                    <tr>
                                        <td
                                            colspan="8"
                                            class="text-center text-muted"
                                        >
                                            NO SE AGREGÓ NINGÚN PRODUCTO
                                        </td>
                                    </tr>
                                </template>
                                <template v-if="form.venta_detalles.length > 0">
                                    <tr>
                                        <td
                                            class="text-right font-weight-bold text-lg"
                                            colspan="4"
                                        >
                                            TOTAL Bs.
                                        </td>
                                        <td class="font-weight-bold text-lg">
                                            {{ totalVenta }}
                                        </td>
                                        <td colspan="3"></td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row" v-if="form.errors">
                    <div class="col-12">
                        <ul class="d-block text-danger list-unstyled">
                            <li
                                class="parsley-required"
                                v-if="form.errors?.venta_detalles"
                            >
                                {{ form.errors?.venta_detalles }}
                            </li>
                            <li
                                class="parsley-required"
                                v-if="form.errors?.cliente_id"
                            >
                                {{ form.errors?.cliente_id }}
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 mb-3 text-center">
                        <button
                            type="button"
                            class="btn btn-primary w-100"
                            :disabled="enviando"
                            @click.prevent="enviarFormulario"
                            v-html="textBtn"
                        ></button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</template>
<style scoped>
span.seleccionado,
input.seleccionado {
    background-color: var(--bg4) !important;
}
</style>
