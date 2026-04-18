<script setup>
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
import { onBeforeMount } from "vue";
const configuracionStore = useConfiguracionStore();

const formatUrl = (url) => {
    if (!url) return "#";
    return url.startsWith("http") ? url : `https://${url}`;
};
</script>
<template>
    <div class="container-fluid footer">
        <div class="row">
            <div class="col-12 text-center">
                <h4 class="font-weight-bold">Comunicate con nosotros</h4>
            </div>
            <div class="col-12 text-center pb-0 mb-0">
                <a
                    :href="`https://wa.me/+59169796503?text=Hola%20deseo%20mas%20informacion`"
                    target="_blank"
                    class="mx-2 text-white text-lg"
                >
                    <i class="fab fa-whatsapp"></i> 69796503
                </a>
                <a
                    :href="`https://wa.me/+59178815163?text=Hola%20deseo%20mas%20informacion`"
                    target="_blank"
                    class="mx-2 text-white text-lg"
                >
                    <i class="fab fa-whatsapp"></i> 78815163
                </a>
                <a
                    :href="`https://wa.me/+59177710866?text=Hola%20deseo%20mas%20informacion`"
                    target="_blank"
                    class="mx-2 text-white text-lg"
                >
                    <i class="fab fa-whatsapp"></i> 77710866
                </a>
            </div>
            <div class="col-12 text-center">
                <a
                    :href="
                        formatUrl(
                            'https://www.facebook.com/people/Autopartes-Rudje-Kaizen-Group/100092425002265/',
                        )
                    "
                    target="_blank"
                    class="mx-2 btn btn-outline-info border-white text-white text-lg"
                >
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a
                    :href="`mailto:www.autopartesrudjekaizengroup@gmail.com`"
                    target="_blank"
                    class="mx-2 btn btn-outline-info border-white text-white text-lg"
                >
                    <i class="fa fa-envelope"></i>
                </a>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-12 text-center">
                <span class="font-weight-bold text-lg">
                    {{ configuracionStore.oConfiguracion.razon_social }}</span
                >
                <br />
                <strong
                    >Copyright &copy; {{ new Date().getFullYear() }}
                    <a href="/" class="text-principal">{{
                        configuracionStore.oConfiguracion.nombre_sistema
                    }}</a
                    >.</strong
                >
                Todos los derechos reservados.
            </div>
        </div>
    </div>
</template>
<style scoped>
.footer {
    color: white;
    border-top: solid 1px var(--bg1);
    background-color: var(--bg1);
    margin-top: 40px;
    display: block;
    min-height: 90px;
    padding-top: 60px;
    padding-bottom: 60px;
}

.footer {
    bottom: 0;
}
</style>
