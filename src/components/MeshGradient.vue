<script setup>
import { ref, onMounted, onBeforeUnmount, computed } from 'vue';

const props = defineProps({
  variant: {
    type: String,
    default: 'blue', // blue, green, red, purple, gold
    validator: (v) => ['blue', 'green', 'red', 'purple', 'gold'].includes(v)
  },
  glowSize: {
    type: Number,
    default: 500
  },
  glowIntensity: {
    type: Number,
    default: 0.25
  },
  easing: {
    type: Number,
    default: 0.05
  },
  speed: {
    type: Number,
    default: 1
  }
});

// --- Enhanced Color Palettes ---
const palettes = {
  blue: {
    primary: '#1e3a8a',
    secondary: '#3b82f6',
    accent: '#60a5fa',
    base: '#020617',
    glow: '#38bdf8'
  },
  green: {
    primary: '#064e3b',
    secondary: '#10b981',
    accent: '#34d399',
    base: '#022c22',
    glow: '#6ee7b7'
  },
  red: {
    primary: '#7f1d1d',
    secondary: '#ef4444',
    accent: '#f87171',
    base: '#450a0a',
    glow: '#fca5a5'
  },
  purple: {
    primary: '#4c1d95',
    secondary: '#a855f7',
    accent: '#c084fc',
    base: '#1e1b4b',
    glow: '#d8b4fe'
  },
  gold: {
    primary: '#78350f',
    secondary: '#f59e0b',
    accent: '#fbbf24',
    base: '#2e1001',
    glow: '#fcd34d'
  }
};

const currentPalette = computed(() => palettes[props.variant] || palettes.blue);

// --- Mouse Tracking & Smoothing ---
const mouseX = ref(0.5);
const mouseY = ref(0.5);
const lerpX = ref(0.5);
const lerpY = ref(0.5);
const glowOpacity = ref(0);

let rafId = null;

const handleMouseMove = (e) => {
  mouseX.value = e.clientX / window.innerWidth;
  mouseY.value = e.clientY / window.innerHeight;
  // Smoothly fade in the glow on first move
  if (glowOpacity.value < props.glowIntensity) {
    glowOpacity.value = props.glowIntensity;
  }
};

const handleMouseLeave = () => {
  glowOpacity.value = 0;
  mouseX.value = 0.5;
  mouseY.value = 0.5;
};

const updateLerp = () => {
  lerpX.value += (mouseX.value - lerpX.value) * props.easing;
  lerpY.value += (mouseY.value - lerpY.value) * props.easing;
  rafId = requestAnimationFrame(updateLerp);
};

onMounted(() => {
  window.addEventListener('mousemove', handleMouseMove);
  document.addEventListener('mouseleave', handleMouseLeave);
  updateLerp();
});

onBeforeUnmount(() => {
  window.removeEventListener('mousemove', handleMouseMove);
  document.removeEventListener('mouseleave', handleMouseLeave);
  cancelAnimationFrame(rafId);
});

// --- Parallax Logic ---
const moveOffset = computed(() => ({
  x: (lerpX.value - 0.5) * 2,
  y: (lerpY.value - 0.5) * 2
}));

const layerStyles = computed(() => ({
  back: { transform: `translate3d(${moveOffset.value.x * 20}px, ${moveOffset.value.y * 20}px, 0)` },
  mid: { transform: `translate3d(${moveOffset.value.x * 45}px, ${moveOffset.value.y * 45}px, 0)` },
  front: { transform: `translate3d(${moveOffset.value.x * 90}px, ${moveOffset.value.y * 90}px, 0)` }
}));

const glowStyle = computed(() => ({
  left: `${lerpX.value * 100}%`,
  top: `${lerpY.value * 100}%`,
  opacity: glowOpacity.value,
  width: `${props.glowSize}px`,
  height: `${props.glowSize}px`,
  background: `radial-gradient(circle at center, ${currentPalette.value.glow}44 0%, transparent 70%)`
}));

</script>

<template>
  <div class="mesh-container" :style="{ '--base-bg': currentPalette.base }">
    <!-- 1. Background Mesh Layer: Heavy Blurring for Liquid Look -->
    <div class="mesh-canvas">
      <div class="blob b-1" :style="{ '--color': currentPalette.primary, '--duration': 20 / speed + 's' }"></div>
      <div class="blob b-2" :style="{ '--color': currentPalette.secondary, '--duration': 28 / speed + 's' }"></div>
      <div class="blob b-3" :style="{ '--color': currentPalette.accent, '--duration': 24 / speed + 's' }"></div>
      <div class="blob b-4" :style="{ '--color': currentPalette.secondary, '--duration': 32 / speed + 's' }"></div>
    </div>

    <!-- 2. Parallax Depth Layers -->
    <div class="parallax-root">
      <div class="layer layer-back" :style="layerStyles.back">
        <div class="grid-texture"></div>
        <div v-for="i in 20" :key="'dot-'+i" class="p-dot" 
             :style="{ left: i*5+'%', top: (i*7)%100+'%', opacity: 0.15 }"></div>
      </div>

      <div class="layer layer-mid" :style="layerStyles.mid">
        <div v-for="i in 4" :key="'mid-'+i" class="soft-glow"
             :style="{ 
               left: (10 + i*20)+'%', 
               top: (20 + i*15)+'%', 
               background: currentPalette.accent+'08',
               width: (200 + i*50)+'px',
               height: (200 + i*50)+'px'
             }"></div>
      </div>

      <div class="layer layer-front" :style="layerStyles.front">
        <div v-for="i in 12" :key="'front-'+i" class="p-glimmer"
             :style="{ 
               left: Math.random()*100+'%', 
               top: Math.random()*100+'%', 
               background: currentPalette.glow+'33',
               '--float-delay': i*0.5+'s'
             }"></div>
      </div>
    </div>

    <!-- 3. The Spotlight (Interactive) -->
    <div class="mouse-spotlight" :style="glowStyle"></div>

    <!-- 4. Post-Processing Shields -->
    <div class="shield noise"></div>
    <div class="shield vignette"></div>
  </div>
</template>

<style scoped lang="scss">
.mesh-container {
  position: fixed;
  inset: 0;
  z-index: -10; // Ensure it stays behind EVERYTHING
  background-color: var(--base-bg);
  overflow: hidden;
  pointer-events: none;
  transition: background-color 1.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.mesh-canvas {
  position: absolute;
  inset: -15%;
  filter: blur(140px);
  opacity: 0.85;
  mix-blend-mode: plus-lighter;
}

.blob {
  position: absolute;
  width: 80vw;
  height: 80vh;
  background: var(--color);
  border-radius: 40% 60% 60% 40% / 40% 40% 60% 60%;
  animation: liquid-mesh var(--duration) ease-in-out infinite;
  will-change: transform, border-radius;
  opacity: 0.7;
}

.b-1 { top: -10%; left: -10%; }
.b-2 { bottom: -10%; right: -10%; animation-direction: reverse; }
.b-3 { top: 40%; left: 30%; width: 50vw; animation-delay: -5s; }
.b-4 { bottom: 20%; left: 10%; width: 60vw; opacity: 0.4; }

@keyframes liquid-mesh {
  0% { transform: translate(0, 0) scale(1) rotate(0deg); border-radius: 40% 60% 60% 40%; }
  33% { transform: translate(15vw, -10vh) scale(1.1) rotate(120deg); border-radius: 60% 40% 40% 60%; }
  66% { transform: translate(-10vw, 15vh) scale(0.9) rotate(240deg); border-radius: 50% 50% 50% 50%; }
  100% { transform: translate(0, 0) scale(1) rotate(360deg); border-radius: 40% 60% 60% 40%; }
}

// Parallax
.parallax-root, .layer { position: absolute; inset: 0; }
.layer { will-change: transform; transition: transform 0.1s linear; }

.grid-texture {
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.06) 1px, transparent 0);
  background-size: 50px 50px;
  mask-image: radial-gradient(circle at 50% 50%, black 30%, transparent 90%);
}

.p-dot { position: absolute; width: 3px; height: 3px; background: #fff; border-radius: 50%; }

.soft-glow {
  position: absolute;
  border-radius: 50%;
  filter: blur(100px);
}

.p-glimmer {
  position: absolute;
  width: 1px;
  height: 15px;
  border-radius: 4px;
  animation: glimmer-float 4s ease-in-out infinite;
  animation-delay: var(--float-delay);
}

@keyframes glimmer-float {
  0%, 100% { transform: translateY(0) opacity(0.2); }
  50% { transform: translateY(-20px) opacity(0.6); }
}

// Spotlight
.mouse-spotlight {
  position: absolute;
  transform: translate(-50%, -50%);
  z-index: 5;
  transition: opacity 1s ease;
  mix-blend-mode: screen;
}

// Post-Process
.shield { position: absolute; inset: 0; pointer-events: none; }
.noise {
  z-index: 10;
  opacity: 0.15;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.8' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
}
.vignette {
  z-index: 11;
  background: radial-gradient(circle at center, transparent 20%, rgba(0,0,0,0.6) 100%);
}

@media (prefers-reduced-motion: reduce) {
  .blob, .p-glimmer { animation: none !important; }
  .layer { transform: none !important; }
}
</style>
