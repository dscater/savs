<script setup>
import { ref, computed, watch, onMounted, onUnmounted } from "vue";

const props = defineProps({
    imagenes: {
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
    height: {
        type: String,
        default: "200px",
    },
});

const imagenes = computed(() => props.imagenes);
const total = computed(() => imagenes.value.length);

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

const endTouch = () => {
    isDragging.value = false;
    startAuto();
};

// WATCH
watch(total, (val) => {
    if (val > 0) {
        current.value = 0;
        startAuto();
    }
});

// DRAG SIMPLE
const isDragging = ref(false);
let startX = 0;
const startDrag = (e) => {
    isDragging.value = true;
    stopAuto();
    startX = e.clientX;
};

const moveDrag = (e) => {
    if (!isDragging.value || total.value === 0) return;

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
    isDragging.value = false;
    startAuto();
};

const startTouch = (e) => {
    isDragging.value = true;
    stopAuto();
    startX = e.touches[0].clientX;
};

const moveTouch = (e) => {
    if (!isDragging.value) return;

    const delta = e.touches[0].clientX - startX;

    if (Math.abs(delta) > 5) {
        if (delta > 0) {
            current.value = (current.value - 1 + total.value) % total.value;
        } else {
            current.value = (current.value + 1) % total.value;
        }
        startX = e.touches[0].clientX;
    }
};

const viewerRef = ref(null);
const isFullscreen = ref(false);
const toggleFullscreen = () => {
    if (!document.fullscreenElement) {
        isFullscreen.value = true;
        viewerRef.value.requestFullscreen();
    } else {
        document.exitFullscreen();
        isFullscreen.value = false;
    }
};
onMounted(() => {
    startAuto();
});

onUnmounted(() => {
    stopAuto();
});
</script>
<template>
    <div
        ref="viewerRef"
        class="viewer"
        @mousedown="startDrag"
        @mousemove="moveDrag"
        @mouseup="endDrag"
        @mouseleave="endDrag"
        @touchstart="startTouch"
        @touchmove="moveTouch"
        @touchend="endTouch"
        :style="{
            height: isFullscreen ? '100vh' : height,
        }"
    >
        <button class="btn-full" @click="toggleFullscreen">
            <i class="fa fa-expand"></i>
        </button>
        <img
            v-if="imagenes.length > 0"
            :src="imagenes[current]?.url_imagen"
            class="imagen"
            draggable="false"
        />
    </div>
</template>

<style scoped>
.btn-full {
    position: absolute;
    top: 10px;
    right: 10px;
    z-index: 10;
    background: black;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
}
.viewer {
    width: 100%;
    position: relative;
    cursor: grab;
    text-align: center;
    border: solid 1px;
    display: flex;
}
.viewer img {
    width: 100%;
    height: 100%;
    object-fit: fill;
}

.viewer:fullscreen {
    width: 100vw;
    height: 100vh;
    background: black;
}

.viewer:fullscreen img {
    object-fit: contain;
}
</style>
