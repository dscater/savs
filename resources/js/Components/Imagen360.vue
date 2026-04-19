<script setup>
import { ref, computed, watch, onMounted, onUnmounted } from "vue";

const props = defineProps({
    images: {
        type: Array,
        default: () => [],
    },
    autoRotacion: {
        type: Boolean,
        default: false,
    },
    speed: {
        type: Number,
        default: 200,
    },
});

const images = computed(() => props.images);
const total = computed(() => images.value.length);

const current = ref(0);

// CONTROL
let interval = null;
const isInteracting = ref(false);

// AUTO ROTATE
const startAuto = () => {
    stopAuto(); // evitar duplicados

    if (total.value === 0 || !props.autoRotacion) return;

    interval = setInterval(() => {
        if (!isInteracting.value) {
            current.value = (current.value + 1) % total.value;
        }
    }, props.speed);
};

const stopAuto = () => {
    if (interval) {
        clearInterval(interval);
        interval = null;
    }
};

// WATCH
watch(total, (val) => {
    if (val > 0) {
        current.value = 0;
        startAuto();
    }
});

// INTERACCIONES
const onEnter = () => {
    isInteracting.value = true;
};

const onLeave = () => {
    isInteracting.value = false;
};

const startTouch = () => {
    isInteracting.value = true;
};

const endTouch = () => {
    isInteracting.value = false;
};

// DRAG SIMPLE
let startX = 0;

const startDrag = (e) => {
    isInteracting.value = true;
    startX = e.clientX;
};

const moveDrag = (e) => {
    if (!isInteracting.value || total.value === 0) return;

    const delta = e.clientX - startX;

    if (Math.abs(delta) > 5) {
        if (delta > 0) {
            current.value = (current.value - 1 + total.value) % total.value;
        } else {
            current.value = (current.value + 1) % total.value;
        }
        startX = e.clientX;
    }
};

const endDrag = () => {
    isInteracting.value = false;
};

onUnmounted(() => {
    stopAuto();
});
</script>
<template>
    <div
        class="viewer"
        @mouseenter="onEnter"
        @mouseleave="onLeave"
        @mousedown="startDrag"
        @mousemove="moveDrag"
        @mouseup="endDrag"
        @touchstart="startTouch"
        @touchend="endTouch"
    >
        <img
            v-if="images.length > 0"
            :src="images[current]?.url_imagen"
            class="imagen"
            draggable="false"
        />
    </div>
</template>

<style scoped>
.viewer {
    width: 100%;
    border: solid 3px;
}
.viewer img {
    max-width: 100%;
}
</style>
