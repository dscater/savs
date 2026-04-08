import { onMounted, ref } from "vue";

const oCliente = ref({
    id: 0,
    nombre: "",
    nit_ci: "",
    cel: "",
    correo: "",
    fecha_registro: "",
    _method: "POST",
});

export const useClientes = () => {
    const setCliente = (item = null) => {
        if (item) {
            oCliente.value.id = item.id;
            oCliente.value.nombre = item.nombre;
            oCliente.value.nit_ci = item.nit_ci;
            oCliente.value.cel = item.cel;
            oCliente.value.correo = item.correo;
            oCliente.value.fecha_registro = item.fecha_registro;
            oCliente.value._method = "PUT";
            return oCliente;
        }
        return false;
    };

    const limpiarCliente = () => {
        oCliente.value.id = 0;
        oCliente.value.nombre = "";
        oCliente.value.nit_ci = "";
        oCliente.value.cel = "";
        oCliente.value.correo = "";
        oCliente.value.fecha_registro = "";
        oCliente.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oCliente,
        setCliente,
        limpiarCliente,
    };
};
