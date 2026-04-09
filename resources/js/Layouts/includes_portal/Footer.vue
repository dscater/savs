<script setup>
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
import { onBeforeMount } from "vue";
const configuracionStore = useConfiguracionStore();
</script>
<template>
    <div class="container-fluid footer">
        <div class="row">
            <div class="col-12 text-center">
                {{ configuracionStore.oConfiguracion.razon_social }}
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
    padding-top: 20px;
    border-top: solid 1px var(--bgGrayLight);
    margin-top: 40px;
    display: block;
    min-height: 90px;
}
</style>
