<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue';

const props = defineProps({
  accentColor: {
    type: String,
    default: '#3b82f6' // Default blue
  },
  intensity: {
    type: Number,
    default: 0.4,
    validator: (v) => v >= 0 && v <= 1
  }
});

// Mouse parallax state
const mouseX = ref(0.5);
const mouseY = ref(0.5);
const lerpX = ref(0.5);
const lerpY = ref(0.5);

let rafId = null;

// Convert hex to RGB for use in gradients
const colorToRgb = (hex) => {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? {
    r: parseInt(result[1], 16),
    g: parseInt(result[2], 16),
    b: parseInt(result[3], 16)
  } : { r: 59, g: 130, b: 246 };
};

const rgb = computed(() => colorToRgb(props.accentColor));

// Create color variations for aurora - more vibrant
const auroraColors = computed(() => ({
  primary: `rgba(${rgb.value.r}, ${rgb.value.g}, ${rgb.value.b}, ${props.intensity * 1.2})`,
  secondary: `rgba(${Math.min(255, rgb.value.r * 0.8)}, ${Math.min(255, rgb.value.g * 0.9)}, ${Math.min(255, rgb.value.b * 1.2)}, ${props.intensity * 0.9})`,
  glow: `rgba(${rgb.value.r}, ${rgb.value.g}, ${rgb.value.b}, ${props.intensity * 0.6})`
}));

// Generate floating particles with random positions
const particles = computed(() => {
  const count = 12;
  const items = [];
  for (let i = 0; i < count; i++) {
    items.push({
      id: i,
      x: (i * 17 + 10) % 100,
      y: (i * 23 + 5) % 100,
      size: 2 + (i % 4) * 1.5,
      depth: 0.3 + (i % 3) * 0.35, // 0.3, 0.65, 1.0
      delay: i * 0.5,
      duration: 15 + (i % 5) * 3
    });
  }
  return items;
});

// Mouse tracking
const handleMouseMove = (e) => {
  mouseX.value = e.clientX / window.innerWidth;
  mouseY.value = e.clientY / window.innerHeight;
};

// Smooth lerp animation
const updateLerp = () => {
  lerpX.value += (mouseX.value - lerpX.value) * 0.03;
  lerpY.value += (mouseY.value - lerpY.value) * 0.03;
  rafId = requestAnimationFrame(updateLerp);
};

// Parallax offset based on mouse
const parallaxOffset = computed(() => ({
  x: (lerpX.value - 0.5) * 2,
  y: (lerpY.value - 0.5) * 2
}));

// Particle styles with parallax
const getParticleStyle = (particle) => {
  const moveX = parallaxOffset.value.x * (30 * particle.depth);
  const moveY = parallaxOffset.value.y * (20 * particle.depth);
  const blur = (1 - particle.depth) * 3;
  
  return {
    left: `${particle.x}%`,
    top: `${particle.y}%`,
    width: `${particle.size}px`,
    height: `${particle.size}px`,
    opacity: 0.3 + particle.depth * 0.4,
    filter: `blur(${blur}px)`,
    transform: `translate(${moveX}px, ${moveY}px)`,
    animationDelay: `${particle.delay}s`,
    animationDuration: `${particle.duration}s`,
    background: `radial-gradient(circle, ${auroraColors.value.glow} 0%, transparent 70%)`
  };
};

// Aurora wave styles with parallax
const auroraStyle = computed(() => ({
  '--aurora-primary': auroraColors.value.primary,
  '--aurora-secondary': auroraColors.value.secondary,
  '--aurora-glow': auroraColors.value.glow,
  '--parallax-x': `${parallaxOffset.value.x * 20}px`,
  '--parallax-y': `${parallaxOffset.value.y * 10}px`
}));

onMounted(() => {
  window.addEventListener('mousemove', handleMouseMove);
  updateLerp();
});

onBeforeUnmount(() => {
  window.removeEventListener('mousemove', handleMouseMove);
  if (rafId) cancelAnimationFrame(rafId);
});
</script>

<template>
  <div class="aurora-container" :style="auroraStyle">
    <!-- Deep space base -->
    <div class="space-base"></div>
    
    <!-- Aurora waves at bottom -->
    <div class="aurora-layer">
      <div class="aurora-wave wave-1"></div>
      <div class="aurora-wave wave-2"></div>
      <div class="aurora-wave wave-3"></div>
    </div>
    
    <!-- Floating particles -->
    <div class="particles-layer">
      <div 
        v-for="particle in particles" 
        :key="particle.id"
        class="particle"
        :style="getParticleStyle(particle)"
      ></div>
    </div>
    
    <!-- Subtle vignette -->
    <div class="vignette"></div>
    
    <!-- Noise texture overlay -->
    <div class="noise"></div>
  </div>
</template>

<style scoped lang="scss">
.aurora-container {
  position: fixed;
  inset: 0;
  z-index: 0;
  overflow: hidden;
  pointer-events: none;
}

.space-base {
  position: absolute;
  inset: 0;
  background: radial-gradient(
    ellipse 120% 80% at 50% 20%,
    #0a0a12 0%,
    #050508 50%,
    #000 100%
  );
}

// Aurora waves
.aurora-layer {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.aurora-wave {
  position: absolute;
  bottom: -20%;
  left: -20%;
  width: 140%;
  height: 60%;
  border-radius: 50% 50% 0 0;
  filter: blur(60px);
  opacity: 1;
  will-change: transform;
  transform: translate(var(--parallax-x), var(--parallax-y));
  
  &.wave-1 {
    background: radial-gradient(ellipse at 30% 100%, var(--aurora-primary) 0%, transparent 70%);
    animation: aurora-drift-1 20s ease-in-out infinite;
  }
  
  &.wave-2 {
    background: radial-gradient(ellipse at 70% 100%, var(--aurora-secondary) 0%, transparent 70%);
    animation: aurora-drift-2 25s ease-in-out infinite;
    animation-delay: -5s;
  }
  
  &.wave-3 {
    background: radial-gradient(ellipse at 50% 100%, var(--aurora-glow) 0%, transparent 60%);
    animation: aurora-drift-3 18s ease-in-out infinite;
    animation-delay: -10s;
    bottom: -30%;
    height: 50%;
  }
}

@keyframes aurora-drift-1 {
  0%, 100% { 
    transform: translate(calc(var(--parallax-x) - 5%), var(--parallax-y)) scale(1); 
  }
  50% { 
    transform: translate(calc(var(--parallax-x) + 5%), var(--parallax-y)) scale(1.1); 
  }
}

@keyframes aurora-drift-2 {
  0%, 100% { 
    transform: translate(calc(var(--parallax-x) + 3%), var(--parallax-y)) scale(1.05); 
  }
  50% { 
    transform: translate(calc(var(--parallax-x) - 3%), var(--parallax-y)) scale(0.95); 
  }
}

@keyframes aurora-drift-3 {
  0%, 100% { 
    transform: translate(var(--parallax-x), calc(var(--parallax-y) + 5%)) scale(1); 
  }
  50% { 
    transform: translate(var(--parallax-x), calc(var(--parallax-y) - 5%)) scale(1.15); 
  }
}

// Floating particles
.particles-layer {
  position: absolute;
  inset: 0;
}

.particle {
  position: absolute;
  border-radius: 50%;
  animation: particle-float linear infinite;
  transition: transform 0.3s ease-out;
}

@keyframes particle-float {
  0% {
    transform: translateY(0) translateX(0);
  }
  25% {
    transform: translateY(-30px) translateX(15px);
  }
  50% {
    transform: translateY(-10px) translateX(-10px);
  }
  75% {
    transform: translateY(-40px) translateX(5px);
  }
  100% {
    transform: translateY(0) translateX(0);
  }
}

// Overlays
.vignette {
  position: absolute;
  inset: 0;
  background: radial-gradient(
    ellipse 80% 60% at 50% 50%,
    transparent 30%,
    rgba(0, 0, 0, 0.4) 100%
  );
}

.noise {
  position: absolute;
  inset: 0;
  opacity: 0.08;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
}

// Reduce motion for accessibility
@media (prefers-reduced-motion: reduce) {
  .aurora-wave, .particle {
    animation: none !important;
  }
}
</style>
