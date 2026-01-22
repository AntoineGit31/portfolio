<script setup>
import { ref, onMounted, onBeforeUnmount, watch, computed } from 'vue';
import * as THREE from 'three';

const props = defineProps({
  accentColor: {
    type: String,
    default: '#3b82f6'
  }
});

const containerRef = ref(null);
let renderer = null;
let scene = null;
let camera = null;
let material = null;
let animationId = null;
let startTime = 0;

// Fixed parameters as requested
const GAMMA = 0.47;
const HORIZON = 0.30;
const MOONLIGHT = 6.3;

// Convert hex to normalized RGB
const hexToRgb = (hex) => {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? {
    r: parseInt(result[1], 16) / 255,
    g: parseInt(result[2], 16) / 255,
    b: parseInt(result[3], 16) / 255
  } : { r: 0.2, g: 0.5, b: 1.0 };
};

const accentRgb = computed(() => hexToRgb(props.accentColor));

// GLSL Fragment Shader - Scenic night backdrop
const fragmentShader = `
precision highp float;

uniform float uTime;
uniform vec2 uResolution;
uniform float uGamma;
uniform float uHorizon;
uniform float uMoonlight;
uniform vec3 uAccentColor;

#define PI 3.14159265359

// Hash function for noise
float hash(vec2 p) {
  return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

// 2D Noise
float noise(vec2 p) {
  vec2 i = floor(p);
  vec2 f = fract(p);
  f = f * f * (3.0 - 2.0 * f);
  
  float a = hash(i);
  float b = hash(i + vec2(1.0, 0.0));
  float c = hash(i + vec2(0.0, 1.0));
  float d = hash(i + vec2(1.0, 1.0));
  
  return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

// Fractional Brownian Motion
float fbm(vec2 p) {
  float value = 0.0;
  float amplitude = 0.5;
  float frequency = 1.0;
  
  for(int i = 0; i < 6; i++) {
    value += amplitude * noise(p * frequency);
    frequency *= 2.0;
    amplitude *= 0.5;
  }
  return value;
}

// Star field - Enhanced visibility
float stars(vec2 uv, float density) {
  vec2 grid = floor(uv * density);
  vec2 f = fract(uv * density);
  
  float star = 0.0;
  float h = hash(grid);
  
  // Lowered threshold from 0.97 to 0.92 for more stars
  if(h > 0.92) {
    vec2 center = vec2(hash(grid + 0.1), hash(grid + 0.2));
    float d = length(f - center);
    float brightness = (h - 0.92) / 0.08; // Adjusted range
    // Smaller star cores with brighter centers
    star = smoothstep(0.08, 0.0, d) * brightness * 1.5;
    // Subtle twinkle effect
    star *= 0.6 + 0.4 * sin(uTime * 2.0 + h * 100.0);
  }
  
  return star;
}

// Moon shape with glow
vec3 moon(vec2 uv, vec2 moonPos, float size) {
  float d = length(uv - moonPos);
  
  // Moon disc
  float disc = smoothstep(size, size - 0.005, d);
  
  // Moon texture (craters)
  float craters = fbm(uv * 20.0 + 5.0) * 0.3;
  vec3 moonColor = vec3(0.95, 0.93, 0.88) - craters * 0.2;
  
  // Glow
  float glow = exp(-d * 3.0) * 0.8;
  float outerGlow = exp(-d * 1.5) * 0.3;
  
  vec3 glowColor = mix(vec3(0.9, 0.85, 0.7), uAccentColor * 0.5 + 0.5, 0.3);
  
  return moonColor * disc + glowColor * (glow + outerGlow);
}

// Water surface - Brighter and more reflective
vec3 water(vec2 uv, float time, vec3 skyColor, vec3 moonReflection, vec2 moonPos) {
  // Transform to water plane coordinates
  float waterY = 0.35; // Water line position
  if(uv.y > waterY) return vec3(0.0);
  
  // Perspective projection for water
  vec2 waterUV = vec2(uv.x, 1.0 / (waterY - uv.y + 0.001));
  waterUV.x *= waterUV.y * 0.1;
  
  // Water waves using FBM
  float wave1 = fbm(waterUV * 2.0 + vec2(time * 0.1, 0.0));
  float wave2 = fbm(waterUV * 4.0 - vec2(time * 0.05, time * 0.02));
  float waves = (wave1 + wave2 * 0.5) * 0.02;
  
  // Distorted reflection coordinates
  vec2 reflectUV = vec2(uv.x + waves, waterY + (waterY - uv.y) + waves);
  
  // Base water color - BRIGHTER: increased from 0.02/0.03/0.05 to 0.04/0.06/0.10
  vec3 waterColor = mix(vec3(0.04, 0.06, 0.10), uAccentColor * 0.15, 0.35);
  
  // Sky reflection - STRONGER: increased from 0.4 to 0.6
  float reflectStrength = smoothstep(waterY, waterY - 0.3, uv.y) * 0.6;
  waterColor = mix(waterColor, skyColor * 0.5, reflectStrength);
  
  // Subtle ambient light on water surface
  waterColor += vec3(0.02, 0.03, 0.05) * smoothstep(waterY, 0.0, uv.y);
  
  // Moon reflection path (glitter)
  float moonDist = abs(uv.x - moonPos.x);
  float glitterPath = exp(-moonDist * moonDist * 50.0);
  float glitter = glitterPath * pow(noise(waterUV * 100.0 + time * 2.0), 8.0) * uMoonlight;
  
  // Add moonlight column reflection - slightly stronger
  float columnReflect = glitterPath * smoothstep(0.35, 0.1, uv.y) * 0.6;
  columnReflect *= (0.5 + 0.5 * sin(waterUV.y * 20.0 + time));
  
  waterColor += moonReflection * columnReflect * uMoonlight * 0.35;
  waterColor += vec3(1.0, 0.95, 0.8) * glitter;
  
  // Fresnel-like edge darkening - REDUCED: changed from full effect to 0.7 min
  float fresnel = smoothstep(waterY - 0.02, waterY - 0.12, uv.y);
  waterColor *= mix(0.7, 1.0, fresnel);
  
  return waterColor;
}

// Horizon glow
vec3 horizonGlow(vec2 uv, float intensity) {
  float y = uv.y - 0.35;
  float glow = exp(-abs(y) * 8.0) * intensity;
  
  // Add some color variation
  vec3 glowColor = mix(uAccentColor * 0.5, vec3(0.8, 0.6, 0.4), 0.5);
  glowColor = mix(glowColor, vec3(0.2, 0.1, 0.3), smoothstep(0.0, -0.1, y));
  
  return glowColor * glow;
}

// Clouds
float clouds(vec2 uv, float time) {
  vec2 cloudUV = uv * vec2(1.5, 3.0) + vec2(time * 0.02, 0.0);
  float cloud = fbm(cloudUV);
  cloud = smoothstep(0.4, 0.7, cloud);
  
  // Fade clouds near horizon and top
  cloud *= smoothstep(0.35, 0.5, uv.y);
  cloud *= smoothstep(1.0, 0.7, uv.y);
  
  return cloud * 0.15;
}

void main() {
  vec2 uv = gl_FragCoord.xy / uResolution.xy;
  float aspect = uResolution.x / uResolution.y;
  vec2 uvAspect = vec2((uv.x - 0.5) * aspect, uv.y - 0.5) + 0.5;
  
  float time = uTime;
  
  // Sky gradient
  vec3 skyTop = vec3(0.02, 0.02, 0.05);
  vec3 skyBottom = mix(vec3(0.05, 0.03, 0.08), uAccentColor * 0.1, 0.3);
  vec3 sky = mix(skyBottom, skyTop, smoothstep(0.35, 0.9, uv.y));
  
  // Stars (only in sky area) - Enhanced density and brightness
  float starField = 0.0;
  if(uv.y > 0.38) {
    // More star layers with increased brightness
    starField += stars(uvAspect, 60.0) * 1.0;         // Large bright stars
    starField += stars(uvAspect + 0.3, 100.0) * 0.8;  // Medium stars
    starField += stars(uvAspect + 0.6, 150.0) * 0.6;  // Small stars
    starField += stars(uvAspect + 0.9, 250.0) * 0.4;  // Faint distant stars
    starField *= smoothstep(0.38, 0.48, uv.y); // Fade near horizon
  }
  sky += vec3(starField) * 1.2; // Overall star brightness boost
  
  // Moon
  vec2 moonPos = vec2(0.7, 0.65);
  vec3 moonLight = moon(uvAspect, moonPos, 0.04);
  
  // Clouds
  float cloudLayer = clouds(uvAspect, time);
  
  // Combine sky elements
  vec3 color = sky;
  color += moonLight;
  color = mix(color, vec3(0.15, 0.12, 0.18), cloudLayer);
  
  // Horizon glow
  color += horizonGlow(uv, uHorizon);
  
  // Water (only below horizon)
  if(uv.y < 0.36) {
    vec3 waterSurface = water(uv, time, sky, moonLight, vec2(0.7, 0.0));
    color = waterSurface;
  }
  
  // Add subtle accent color ambient
  color += uAccentColor * 0.02;
  
  // Add ambient glow on the left side to balance the moon on the right
  float leftAmbient = smoothstep(0.6, 0.0, uv.x) * 0.08;
  color += mix(vec3(0.08, 0.06, 0.12), uAccentColor * 0.3, 0.4) * leftAmbient;
  
  // Also add subtle starlight ambience on the left
  color += vec3(0.02, 0.025, 0.04) * smoothstep(0.5, 0.0, uv.x) * smoothstep(0.35, 0.6, uv.y);
  
  // Vignette - Asymmetric, offset toward moon position (right side)
  vec2 vignetteCenter = vec2(0.55, 0.5); // Slightly offset to the right
  float vignette = 1.0 - length((uv - vignetteCenter) * vec2(1.0, 1.2));
  vignette = smoothstep(0.0, 0.75, vignette);
  color *= vignette * 0.7 + 0.3; // Reduced darkening effect (0.3 min instead of 0.2)
  
  // Gamma correction
  color = pow(color, vec3(1.0 / uGamma));
  
  // Subtle noise to prevent banding
  color += (hash(uv + time) - 0.5) * 0.02;
  
  gl_FragColor = vec4(color, 1.0);
}
`;

const vertexShader = `
void main() {
  gl_Position = vec4(position, 1.0);
}
`;

const initScene = () => {
  if (!containerRef.value) return;
  
  const width = window.innerWidth;
  const height = window.innerHeight;
  
  // Renderer
  renderer = new THREE.WebGLRenderer({ 
    antialias: false,
    alpha: false 
  });
  renderer.setSize(width, height);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  containerRef.value.appendChild(renderer.domElement);
  
  // Scene
  scene = new THREE.Scene();
  
  // Camera (orthographic for full-screen quad)
  camera = new THREE.OrthographicCamera(-1, 1, 1, -1, 0, 1);
  
  // Shader material
  material = new THREE.ShaderMaterial({
    vertexShader,
    fragmentShader,
    uniforms: {
      uTime: { value: 0 },
      uResolution: { value: new THREE.Vector2(width, height) },
      uGamma: { value: GAMMA },
      uHorizon: { value: HORIZON },
      uMoonlight: { value: MOONLIGHT },
      uAccentColor: { value: new THREE.Vector3(accentRgb.value.r, accentRgb.value.g, accentRgb.value.b) }
    }
  });
  
  // Full-screen quad
  const geometry = new THREE.PlaneGeometry(2, 2);
  const mesh = new THREE.Mesh(geometry, material);
  scene.add(mesh);
  
  startTime = performance.now();
};

const animate = () => {
  if (!renderer || !scene || !camera || !material) return;
  
  const elapsed = (performance.now() - startTime) / 1000;
  material.uniforms.uTime.value = elapsed;
  
  renderer.render(scene, camera);
  animationId = requestAnimationFrame(animate);
};

const handleResize = () => {
  if (!renderer || !material) return;
  
  const width = window.innerWidth;
  const height = window.innerHeight;
  
  renderer.setSize(width, height);
  material.uniforms.uResolution.value.set(width, height);
};

// Watch for accent color changes
watch(() => props.accentColor, () => {
  if (material) {
    const rgb = accentRgb.value;
    material.uniforms.uAccentColor.value.set(rgb.r, rgb.g, rgb.b);
  }
});

onMounted(() => {
  console.log('CosmicBackground mounting with Three.js...');
  initScene();
  animate();
  window.addEventListener('resize', handleResize);
  console.log('CosmicBackground initialized successfully');
});

onBeforeUnmount(() => {
  if (animationId) {
    cancelAnimationFrame(animationId);
  }
  window.removeEventListener('resize', handleResize);
  
  if (renderer) {
    renderer.dispose();
    if (containerRef.value && renderer.domElement) {
      containerRef.value.removeChild(renderer.domElement);
    }
  }
  if (material) material.dispose();
});
</script>

<template>
  <div ref="containerRef" class="cosmic-container"></div>
</template>

<style scoped lang="scss">
.cosmic-container {
  position: fixed;
  inset: 0;
  z-index: 0;
  overflow: hidden;
  pointer-events: none;
  background: #000;
  
  canvas {
    display: block;
    width: 100%;
    height: 100%;
  }
}

@media (prefers-reduced-motion: reduce) {
  .cosmic-container {
    background: linear-gradient(
      to bottom,
      #020205 0%,
      #0a0812 50%,
      #050308 100%
    );
    
    canvas {
      display: none;
    }
  }
}
</style>
