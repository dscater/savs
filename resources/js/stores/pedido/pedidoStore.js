import { defineStore } from "pinia";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
export const usePedidoStore = defineStore("pedido", {
    state: () => ({
        listProductos: localStorage.getItem("listProductos")
            ? JSON.parse(localStorage.getItem("listProductos"))
            : [],
    }),
    actions: {
        agregarProducto(producto, cantidad) {
            if (!cantidad || parseFloat(cantidad) < 1) {
                toast.error("Debes ingresar una cantidad valida");
                return;
            }
            if (this.listProductos.some((p) => p.id === producto.id)) {
                toast.warning("El producto ya está en el pedido");
                return;
            }
            const subtotal = parseFloat(cantidad) * producto.precio;
            this.listProductos.push({
                id: producto.id,
                producto: producto,
                cantidad: cantidad,
                subtotal,
            });
            localStorage.setItem(
                "listProductos",
                JSON.stringify(this.listProductos),
            );
            toast.success("Producto agregado al pedido");
        },
        actualizarCantidad(index, cantidad) {
            if (!cantidad || parseFloat(cantidad) < 1) {
                toast.error("Debes ingresar una cantidad valida");
                return;
            }
            const subtotal =
                parseFloat(cantidad) *
                this.listProductos[index].producto.precio;

            this.listProductos[index].cantidad = cantidad;
            this.listProductos[index].subtotal = subtotal;

            localStorage.setItem(
                "listProductos",
                JSON.stringify(this.listProductos),
            );
            toast.success("Cantidad actualizada");
        },
        quitarProducto(index) {
            this.listProductos.splice(index, 1);

            localStorage.setItem(
                "listProductos",
                JSON.stringify(this.listProductos),
            );
            toast.info("Producto eliminado del pedido");
        },
        vaciarPedido() {
            this.listProductos = [];
            localStorage.removeItem("listProductos");
            // toast.info("Pedido vaciado");
        },
    },
    getters: {
        getListaProductos() {
            return this.listProductos;
        },
    },
});
