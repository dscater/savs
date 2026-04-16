import { onMounted, ref } from "vue";

const oSubasta = ref({
    id: 0,
    producto_id: "",
    estado_producto: "",
    monto_inicial: "",
    garantia: "",
    fecha_fin: "",
    hora_fin: "",
    publico: 0,
    estado_subasta: "",
    fecha_registro: "",
    _method: "POST",
});

export const useSubastas = () => {
    const setSubasta = (item = null) => {
        if (item) {
            oSubasta.value.id = item.id;
            oSubasta.value.producto_id = item.producto_id;
            oSubasta.value.producto = item.producto;
            oSubasta.value.estado_producto = item.estado_producto;
            oSubasta.value.monto_inicial = item.monto_inicial;
            oSubasta.value.garantia = item.garantia;
            oSubasta.value.fecha_fin = item.fecha_fin;
            oSubasta.value.hora_fin = item.hora_fin;
            oSubasta.value.publico = item.publico;
            oSubasta.value.estado_subasta = item.estado_subasta;
            oSubasta.value.fecha_registro = item.fecha_registro;
            oSubasta.value._method = "PUT";
            return oSubasta;
        }
        return false;
    };

    const limpiarSubasta = () => {
        oSubasta.value.id = 0;
        oSubasta.value.producto_id = "";
        oSubasta.value.estado_producto = "";
        oSubasta.value.monto_inicial = "";
        oSubasta.value.garantia = "";
        oSubasta.value.fecha_fin = "";
        oSubasta.value.hora_fin = "";
        oSubasta.value.publico = 0;
        oSubasta.value.estado_subasta = "";
        oSubasta.value.fecha_registro = "";
        oSubasta.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oSubasta,
        setSubasta,
        limpiarSubasta,
    };
};
