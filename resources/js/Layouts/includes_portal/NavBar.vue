<script setup>
// includes
import { ref, onMounted, onBeforeMount, watch, onUnmounted } from "vue";
import { Link, router, usePage } from "@inertiajs/vue3";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
const configuracionStore = useConfiguracionStore();
const { auth } = usePage().props;
const propsPage = usePage().props;

const isFixed = ref(false);
const showButton = ref(false);
const handleScroll = () => {
    const y = window.scrollY;
    const scrollTop = window.scrollY || document.documentElement.scrollTop;
    const windowHeight =
        window.innerHeight || document.documentElement.clientHeight;
    const docHeight = document.documentElement.scrollHeight;
    const scrollRestante = docHeight - (scrollTop + windowHeight);

    if (scrollRestante < 50) {
        return;
    }
    isFixed.value = y > 70;
    // showButton.value = y > 300;
};

onMounted(() => {
    window.addEventListener("scroll", handleScroll);
    configuracionStore.initConfiguracion();
});
onUnmounted(() => {
    window.removeEventListener("scroll", handleScroll);
});

onBeforeMount(() => {});
</script>
<template>
    <nav
        class="navbar navbar-expand-lg navbar-dark bg-principal sticky-top"
        :class="{
            fixed: isFixed,
        }"
    >
        <div class="container-fluid">
            <Link class="navbar-brand text-white font-weight-bold" href="/">
                <img
                    :src="configuracionStore.oConfiguracion.url_logo"
                    alt="Logo"
                    height="40px"
                    class="rounded"
                />
                {{ configuracionStore.oConfiguracion.alias }}</Link
            >
            <button
                class="navbar-toggler"
                type="button"
                data-toggle="collapse"
                data-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation"
            >
                <span class="navbar-toggler-icon"></span>
            </button>
            <div
                class="collapse navbar-collapse justify-content-end"
                id="navbarNav"
            >
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <Link
                            class="nav-link"
                            :href="route('login')"
                            v-if="!auth.user"
                        >
                            <i class="fa fa-sign-in-alt"></i>
                        </Link>
                        <Link class="nav-link" :href="route('inicio')" v-else>
                            <i class="fa fa-user"></i>
                        </Link>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</template>
