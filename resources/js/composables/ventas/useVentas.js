import { onMounted, ref } from "vue";

const oVenta = ref({
    id: 0,
    cliente_id: "",
    nit_ci: "",
    total: "",
    fecha: "",
    hora: "",
    user_id: "",
    status: "",
    venta_detalles: [],
    detalle_eliminados: [],
    _method: "POST",
});

export const useVentas = () => {
    const setVenta = (item = null) => {
        if (item) {
            oVenta.value.id = item.id;
            oVenta.value.cliente_id = item.cliente_id;
            oVenta.value.nit_ci = item.nit_ci;
            oVenta.value.total = item.total;
            oVenta.value.fecha = item.fecha;
            oVenta.value.hora = item.hora;
            oVenta.value.user_id = item.user_id;
            oVenta.value.status = item.status;
            oVenta.value.venta_detalles = item.venta_detalles;
            oVenta.value.detalle_eliminados = [];
            oVenta.value._method = "PUT";
            return oVenta;
        }
        return false;
    };

    const limpiarVenta = () => {
        oVenta.value.id = 0;
        oVenta.value.cliente_id = "";
        oVenta.value.nit_ci = "";
        oVenta.value.total = "";
        oVenta.value.fecha = "";
        oVenta.value.hora = "";
        oVenta.value.user_id = "";
        oVenta.value.status = "";
        oVenta.value.venta_detalles = [];
        oVenta.value.detalle_eliminados = [];
        oVenta.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oVenta,
        setVenta,
        limpiarVenta,
    };
};
