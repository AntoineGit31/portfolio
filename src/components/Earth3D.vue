<template>
  <div ref="container" class="earth-3d-container"></div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue';
import * as THREE from 'three';

const props = defineProps({
  size: { type: Number, default: 120 }
});

const container = ref(null);
let scene, camera, renderer, earth, clouds, atmosphere, animationId;

onMounted(() => {
  initThree();
  animate();
});

onUnmounted(() => {
  cancelAnimationFrame(animationId);
  renderer.dispose();
});

const initThree = () => {
  // Scene setup
  scene = new THREE.Scene();
  
  camera = new THREE.PerspectiveCamera(45, 1, 0.1, 1000);
  camera.position.z = 3;

  renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
  renderer.setSize(props.size, props.size);
  renderer.setPixelRatio(window.devicePixelRatio);
  container.value.appendChild(renderer.domElement);

  const loader = new THREE.TextureLoader();
  
  // Use absolute URLs from Three.js examples
  const dayTexture = loader.load('https://threejs.org/examples/textures/planets/earth_day_4096.jpg');
  const nightTexture = loader.load('https://threejs.org/examples/textures/planets/earth_night_4096.jpg');
  const cloudBumpTexture = loader.load('https://threejs.org/examples/textures/planets/earth_bump_roughness_clouds_4096.jpg');

  dayTexture.colorSpace = THREE.SRGBColorSpace;
  nightTexture.colorSpace = THREE.SRGBColorSpace;

  // Earth Geometry
  const geometry = new THREE.SphereGeometry(1, 64, 64);
  
  // Custom Shader for Day/Night and Clouds
  const earthMaterial = new THREE.ShaderMaterial({
    uniforms: {
      uDayTexture: { value: dayTexture },
      uNightTexture: { value: nightTexture },
      uCloudBumpTexture: { value: cloudBumpTexture },
      uSunDirection: { value: new THREE.Vector3(2, 1, 1).normalize() }
    },
    vertexShader: `
      varying vec2 vUv;
      varying vec3 vNormal;
      varying vec3 vPosition;
      void main() {
        vUv = uv;
        vNormal = normalize(normalMatrix * normal);
        vPosition = (modelMatrix * vec4(position, 1.0)).xyz;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,
    fragmentShader: `
      uniform sampler2D uDayTexture;
      uniform sampler2D uNightTexture;
      uniform sampler2D uCloudBumpTexture;
      uniform vec3 uSunDirection;
      varying vec2 vUv;
      varying vec3 vNormal;
      varying vec3 vPosition;

      void main() {
        vec3 normal = normalize(vNormal);
        float sunOrientation = dot(normal, uSunDirection);
        
        vec4 dayColor = texture2D(uDayTexture, vUv);
        vec4 nightColor = texture2D(uNightTexture, vUv);
        vec4 cloudBump = texture2D(uCloudBumpTexture, vUv);

        // Transition between day and night (sharper transition like 🌍)
        float dayMix = smoothstep(-0.1, 0.1, sunOrientation);
        
        // Boost vibrancy for "Electric Azure"
        vec3 dayVibrant = pow(dayColor.rgb, vec3(0.8)) * 1.2;
        vec3 earthColor = mix(nightColor.rgb * 0.5, dayVibrant, dayMix);

        // Clouds (Blue channel of bump texture)
        float cloudmask = smoothstep(0.15, 0.8, cloudBump.b);
        vec3 cloudColor = vec3(1.0) * cloudmask * (dayMix * 0.8 + 0.2);
        
        earthColor = mix(earthColor, vec3(1.0) * cloudmask, cloudmask * dayMix);
        // Brighten clouds on day side
        earthColor += cloudmask * vec3(0.5) * dayMix;

        // Fresnel/Atmosphere rim (Intense electric blue)
        float fresnel = pow(1.1 - dot(normal, vec3(0.0, 0.0, 1.0)), 3.5);
        vec3 atmosphereColor = vec3(0.1, 0.6, 1.0) * fresnel * (dayMix * 0.7 + 0.3);

        gl_FragColor = vec4(earthColor + atmosphereColor, 1.0);
      }
    `
  });

  earth = new THREE.Mesh(geometry, earthMaterial);
  scene.add(earth);

  // Outer Atmosphere Glow
  const atmosGeometry = new THREE.SphereGeometry(1.08, 64, 64);
  const atmosMaterial = new THREE.ShaderMaterial({
    side: THREE.BackSide,
    transparent: true,
    uniforms: {
      uSunDirection: { value: new THREE.Vector3(2, 1, 1).normalize() }
    },
    vertexShader: `
      varying vec3 vNormal;
      void main() {
        vNormal = normalize(normalMatrix * normal);
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,
    fragmentShader: `
      varying vec3 vNormal;
      uniform vec3 uSunDirection;
      void main() {
        float intensity = pow(0.75 - dot(vNormal, vec3(0, 0, 1.0)), 4.0);
        float sunIntensity = smoothstep(-0.3, 0.3, dot(vNormal, uSunDirection));
        vec3 color = mix(vec3(0.0, 0.4, 1.0), vec3(0.1, 0.2, 0.6), 1.0 - sunIntensity);
        gl_FragColor = vec4(color, intensity * (sunIntensity * 0.8 + 0.2) * 0.9);
      }
    `
  });
  atmosphere = new THREE.Mesh(atmosGeometry, atmosMaterial);
  scene.add(atmosphere);

  // Initial rotation
  earth.rotation.y = Math.PI;
};

const animate = () => {
  animationId = requestAnimationFrame(animate);
  
  if (earth) {
    earth.rotation.y += 0.002;
  }
  
  renderer.render(scene, camera);
};
</script>

<style scoped>
.earth-3d-container {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  filter: drop-shadow(0 0 30px rgba(52, 152, 219, 0.4));
}
</style>
