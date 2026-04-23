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
            <div class="col-12 text-center mb-2">
                La Paz - Bolivia <br />
                Av. Satelite Zona Villa Tejada rectangular c/11 #22
            </div>
            <div class="col-12 text-center pb-0 mb-2">
                <a
                    :href="`https://wa.me/+59177710866?text=Hola%20deseo%20mas%20informacion`"
                    target="_blank"
                    class="mx-2 text-white text-lg"
                >
                    <i class="fab fa-whatsapp"></i> 77710866
                </a>
                <a
                    :href="`https://wa.me/+59169796503?text=Hola%20deseo%20mas%20informacion`"
                    target="_blank"
                    class="mx-2 text-white text-lg"
                >
                    <i class="fab fa-whatsapp"></i> 69796503
                </a>
            </div>
            <div class="col-12 text-center">
                <a
                    :href="
                        formatUrl(
                            'https://www.facebook.com/profile.php?id=100092425002265&mibextid=ZbWKwL',
                        )
                    "
                    target="_blank"
                    class="mx-2 btn btn-outline-info border-white text-white text-lg"
                >
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a
                    :href="
                        formatUrl(
                            'https://www.tiktok.com/@rudje_kaizen_group?_t=8ou7Jj8TVHq&_r=1',
                        )
                    "
                    target="_blank"
                    class="mx-2 btn btn-outline-info border-white text-white text-lg"
                >
                    <i class="fab fa-tiktok"></i>
                </a>

                <a
                    :href="`mailto:autopartesrudjekaizengroup@gmail.com`"
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
    border-top: solid 1px var(--bg-principal-portal);
    background-color: var(--bg-principal-portal);
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
