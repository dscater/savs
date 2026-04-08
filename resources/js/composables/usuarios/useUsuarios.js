import { onMounted, ref } from "vue";

const oUsuario = ref({
    id: 0,
    usuario: "",
    nombre: "",
    paterno: "",
    materno: "",
    ci: "",
    ci_exp: "",
    dir: "",
    correo: "",
    fono: "",
    password: "",
    acceso: "",
    tipo: "",
    foto: "",
    _method: "POST",
});

export const useUsuarios = () => {
    const setUsuario = (item = null, ver = false) => {
        if (item) {
            oUsuario.value.id = item.id;
            oUsuario.value.usuario = item.usuario;
            oUsuario.value.nombre = item.nombre;
            oUsuario.value.paterno = item.paterno;
            oUsuario.value.materno = item.materno;
            oUsuario.value.ci = item.ci;
            oUsuario.value.ci_exp = item.ci_exp;
            oUsuario.value.dir = item.dir;
            oUsuario.value.correo = item.correo;
            oUsuario.value.fono = item.fono;
            oUsuario.value.password = item.password;
            oUsuario.value.acceso = item.acceso;
            oUsuario.value.tipo = item.tipo;
            oUsuario.value._method = "PUT";
            return oUsuario;
        }
        return false;
    };

    const limpiarUsuario = () => {
        oUsuario.value.id = 0;
        oUsuario.value.usuario = "";
        oUsuario.value.nombre = "";
        oUsuario.value.paterno = "";
        oUsuario.value.materno = "";
        oUsuario.value.ci = "";
        oUsuario.value.ci_exp = "";
        oUsuario.value.dir = "";
        oUsuario.value.correo = "";
        oUsuario.value.fono = "";
        oUsuario.value.password = "";
        oUsuario.value.acceso = "";
        oUsuario.value.tipo = "";
        oUsuario.value.foto = "";
        oUsuario._method = "POST";
    };

    onMounted(() => {});

    return {
        oUsuario,
        setUsuario,
        limpiarUsuario,
    };
};
