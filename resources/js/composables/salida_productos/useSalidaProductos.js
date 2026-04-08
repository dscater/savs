import { onMounted, ref } from "vue";

const oSalidaProducto = ref({
    id: 0,
    producto_id: "",
    cantidad: "",
    descripcion: "",
    fecha_registro: "",
    _method: "POST",
});

export const useSalidaProductos = () => {
    const setSalidaProducto = (item = null) => {
        if (item) {
            oSalidaProducto.value.id = item.id;
            oSalidaProducto.value.producto_id = item.producto_id;
            oSalidaProducto.value.cantidad = item.cantidad;
            oSalidaProducto.value.descripcion = item.descripcion;
            oSalidaProducto.value.fecha_registro = item.fecha_registro;
            oSalidaProducto.value._method = "PUT";
            return oSalidaProducto;
        }
        return false;
    };

    const limpiarSalidaProducto = () => {
        oSalidaProducto.value.id = 0;
        oSalidaProducto.value.producto_id = "";
        oSalidaProducto.value.cantidad = "";
        oSalidaProducto.value.descripcion = "";
        oSalidaProducto.value.fecha_registro = "";
        oSalidaProducto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oSalidaProducto,
        setSalidaProducto,
        limpiarSalidaProducto,
    };
};
