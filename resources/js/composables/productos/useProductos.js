import { onMounted, ref } from "vue";

const oProducto = ref({
    id: 0,
    nombre: "",
    descripcion: "",
    precio: "",
    stock: "",
    categoria_id: "",
    producto_imagens: [],
    eliminados_imagens: [],
    _method: "POST",
});

export const useProductos = () => {
    const setProducto = (item = null) => {
        if (item) {
            oProducto.value.id = item.id;
            oProducto.value.nombre = item.nombre;
            oProducto.value.descripcion = item.descripcion;
            oProducto.value.precio = item.precio;
            oProducto.value.stock = item.stock;
            oProducto.value.categoria_id = item.categoria_id;
            oProducto.value.producto_imagens = item.producto_imagens;
            oProducto.value.eliminados_imagens = [];
            oProducto.value._method = "PUT";
            return oProducto;
        }
        return false;
    };

    const limpiarProducto = () => {
        oProducto.value.id = 0;
        oProducto.value.nombre = "";
        oProducto.value.descripcion = "";
        oProducto.value.precio = "";
        oProducto.value.stock = "";
        oProducto.value.categoria_id = "";
        oProducto.value.producto_imagens = [];
        oProducto.value.eliminados_imagens = [];
        oProducto.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oProducto,
        setProducto,
        limpiarProducto,
    };
};
