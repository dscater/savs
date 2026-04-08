import { onMounted, ref } from "vue";

const oCategoria = ref({
    id: 0,
    nombre: "",
    descripcion: "",
    _method: "POST",
});

export const useCategorias = () => {
    const setCategoria = (item = null) => {
        if (item) {
            oCategoria.value.id = item.id;
            oCategoria.value.nombre = item.nombre;
            oCategoria.value.descripcion = item.descripcion;
            oCategoria.value._method = "PUT";
            return oCategoria;
        }
        return false;
    };

    const limpiarCategoria = () => {
        oCategoria.value.id = 0;
        oCategoria.value.nombre = "";
        oCategoria.value.descripcion = "";
        oCategoria.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oCategoria,
        setCategoria,
        limpiarCategoria,
    };
};
