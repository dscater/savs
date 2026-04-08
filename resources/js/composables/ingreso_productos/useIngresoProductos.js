import { onMounted, ref } from "vue";

const oIngresoProducto = ref({
    id: 0,
    producto_id: "",
    cantidad: 1,
    descripcion: "",
    fecha_registro: "",
    _method: "POST",
});

export const useIngresoProductos = () => {
    const setIngresoProducto = (item = null) => {
        if (item) {
            oIngresoProducto.value.id = item.id;
            oIngresoProducto.value.producto_id = item.producto_id;
            oIngresoProducto.value.cantidad = item.cantidad;
            oIngresoProducto.value.descripcion = item.descripcion;
            oIngresoProducto.value.fecha_registro = item.fecha_registro;
            oIngresoProducto.value._method = "PUT";
            return oIngresoProducto;
        }
        return false;
    };

    const limpiarIngresoProducto = () => {
        oIngresoProducto.value.id = 0;
        oIngresoProducto.value.producto_id = "";
        oIngresoProducto.value.cantidad = 1;
        oIngresoProducto.value.descripcion = "";
        oIngresoProducto.value.fecha_registro = "";
        oIngresoProducto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oIngresoProducto,
        setIngresoProducto,
        limpiarIngresoProducto,
    };
};
