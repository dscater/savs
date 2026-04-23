<script setup>
import Portal from "@/Layouts/Portal.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { computed, inject, onBeforeMount, onMounted, ref } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
// importar estilos de AOS
import "aos/dist/aos.css";
import AOS from "aos";
import Seccion from "@/Layouts/includes_portal/Seccion.vue";
import { usePedidoStore } from "@/stores/pedido/pedidoStore";
const pedidoStore = usePedidoStore();

const appStore = useAppStore();
defineOptions({ layout: Portal });

onMounted(() => {
    appStore.stopLoading();
    AOS.init({
        duration: 1000,
        easing: "ease-in-out",
        once: false,
        mirror: false,
    });
});
const enviando = ref(false);
const txtBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spinner fa-spin"></i> Creando pedido...`;
    } else {
        return `<i class="fab fa-whatsapp"></i> Realizar pedido por WhatsApp`;
    }
});
const crearPedido = () => {
    Swal.fire({
        title: "¿Quierés realizar el pedido?",
        html: `<strong>${pedidoStore.listProductos.length} productos agregados</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, realizar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-success",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            enviando.value = true;
            axios
                .post(route("portal.crearPedido"), {
                    productos: pedidoStore.listProductos,
                })
                .then((res) => {
                    Swal.fire("¡Pedido realizado con éxito!", "", "success");
                    Swal.fire({
                        icon: "success",
                        title: "¡Pedido realizado con éxito!",
                        text: ``,
                        confirmButtonColor: "#3085d6",
                        confirmButtonText: `Aceptar`,
                    });
                    pedidoStore.vaciarPedido();
                    // console.log(res.data);
                    window.open(res.data.whatsapp, "_blank");
                })
                .catch((err) => {
                    Swal.fire("Error al realizar el pedido", "", "error");
                })
                .finally(() => {
                    enviando.value = false;
                });
        }
    });
};

const quitar = (index) => {
    Swal.fire({
        title: "¿Quierés quitar este producto?",
        html: ``,
        showCancelButton: true,
        confirmButtonText: "Si, quitar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-danger",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            pedidoStore.quitarProducto(index);
        }
    });
};

const total = computed(() => {
    const suma_total = pedidoStore.listProductos.reduce((value, item) => {
        return value + item.subtotal;
    }, 0);
    return suma_total;
});

const actualizaCantidad = (e, index) => {
    const cantidad = e.target.value;
    pedidoStore.actualizarCantidad(index, cantidad);
};

onBeforeMount(() => {
    appStore.startLoading();
});
</script>
<template>
    <div class="container-fluid seccion">
        <Seccion :titulo="'Pedido'"></Seccion>

        <div class="container mt-4">
            <div id="product" class="section-container pt-20px">
                <div class="container">
                    <div class="row mb-2">
                        <div class="col-12">
                            <div
                                class="menu_inicio"
                                v-if="pedidoStore.listProductos.length > 0"
                            >
                                <table
                                    class="table table-bordered rounded bg-white"
                                >
                                    <thead class="bg-principal-portal rounded">
                                        <th>N°</th>
                                        <th></th>
                                        <th>Producto</th>
                                        <th>C/U Bs.</th>
                                        <th>Cantidad</th>
                                        <th>Subtotal</th>
                                        <th></th>
                                    </thead>
                                    <tbody>
                                        <template
                                            v-if="
                                                pedidoStore.listProductos
                                                    .length > 0
                                            "
                                        >
                                            <tr
                                                v-for="(
                                                    item, index
                                                ) in pedidoStore.listProductos"
                                            >
                                                <td>
                                                    {{ index + 1 }}
                                                </td>
                                                <td>
                                                    <img
                                                        :src="
                                                            item.producto
                                                                .producto_imagens[0]
                                                                .url_imagen
                                                        "
                                                        alt=""
                                                        height="90px"
                                                    />
                                                </td>
                                                <td>
                                                    {{ item.producto.nombre }}
                                                </td>
                                                <td>
                                                    {{ item.producto.precio }}
                                                </td>
                                                <td>
                                                    <input
                                                        type="number"
                                                        class="form-control"
                                                        v-model="item.cantidad"
                                                        @change="
                                                            actualizaCantidad(
                                                                $event,
                                                                index,
                                                            )
                                                        "
                                                        @keyup="
                                                            actualizaCantidad(
                                                                $event,
                                                                index,
                                                            )
                                                        "
                                                    />
                                                </td>
                                                <td>{{ item.subtotal }}</td>
                                                <td>
                                                    <button
                                                        class="btn btn-danger"
                                                        @click="quitar(index)"
                                                    >
                                                        X
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td
                                                    class="text-right font-weight-bold text-lg"
                                                    colspan="5"
                                                >
                                                    TOTAL
                                                </td>
                                                <td
                                                    class="font-weight-bold text-lg"
                                                >
                                                    {{ total }}
                                                </td>
                                            </tr>
                                        </template>
                                        <template v-else>
                                            <tr>
                                                <td colspan="5">
                                                    No se agregó ningún Producto
                                                </td>
                                            </tr>
                                        </template>
                                    </tbody>
                                </table>
                            </div>
                            <div
                                class="enviar_pedido mt-1"
                                v-if="pedidoStore.listProductos.length > 0"
                            >
                                <button
                                    class="btn btn-success w-100"
                                    @click="crearPedido"
                                    :disabled="enviando"
                                    v-html="txtBtn"
                                ></button>
                                <Link
                                    :href="route('portal.index')"
                                    class="text-gray w-100 text-center mt-3 d-block"
                                    ><i class="fa fa-arrow-left"></i> Seguir
                                    viendo</Link
                                >
                            </div>
                            <div class="col-12 text-center h4" v-else>
                                NO SE AGREGÓ NINGÚN PRODUCTO
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
