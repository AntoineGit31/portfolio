<script setup>
import { onMounted, onBeforeUnmount, ref, computed } from "vue";
import { useRouter } from "vue-router";
import { Flowmap, RenderTarget } from "ogl";
import { renderer, gl } from "../createShader";
import uvTexture from "../shader/uvTexture";
import displayTexture from "../shader/displayTexture";
import initializePressure from "../shader/initializePressure";
import advection from "../shader/advection";
import velocityToPresure from "../shader/velocityToPresure";
import velocityCorrection from "../shader/velocityCorrection";
import fluidVelocity from "../shader/fluidVelocity";
import reactionDiffusion from "../shader/reactionDiffusion";
import canvasRenderer from "../canvasRenderer";
import glassShading from "../shader/glassShading";
import backgroundClock from "../shader/backgroundClock";
import { getUrlParam } from "../getUrlParam";
import useParallax from "../parallax";

const router = useRouter();
const { parallax } = useParallax();

// Language state
const currentLang = ref('fr');
const translations = {
  fr: {
    portfolio: 'Portfolio',
    viewPortfolio: 'Voir le portfolio',
    home: 'Accueil',
    projects: 'Projets',
    about: 'À propos',
    contact: 'Contact',
  },
  en: {
    portfolio: 'Portfolio',
    viewPortfolio: 'View portfolio',
    home: 'Home',
    projects: 'Projects',
    about: 'About',
    contact: 'Contact',
  }
};

const t = computed(() => translations[currentLang.value]);

function toggleLanguage() {
  currentLang.value = currentLang.value === 'fr' ? 'en' : 'fr';
}

function scrollToPortfolio() {
  router.push('/projects');
}

/**@type {HTMLElement} */
let appRoot;
/**@type {Flowmap} */
let flowmap;

const renderTargets = [];
const renderTargets_delayed_set_size = [];

const FLAG_debug = getUrlParam("debug", null, String);
const FLAG_iteration = getUrlParam("iteration", 10, Number);

function createRenderTarget(delayed_set_size = false) {
  const target = new RenderTarget(gl, {
    width: 512,
    height: 512,
    type: gl.HALF_FLOAT,
    format: gl.RGBA,
    internalFormat: gl.RGBA16F,
    depth: false,
    wrapS: gl.CLAMP_TO_EDGE,
    wrapT: gl.CLAMP_TO_EDGE,
  });
  if (delayed_set_size) {
    renderTargets_delayed_set_size.push(target);
  } else {
    renderTargets.push(target);
  }
  return target;
}

let set_size_needed = true;
let simulation_size = [512, 512];

// Listeners
function resize() {
  const rect = appRoot.getBoundingClientRect();
  renderer.setSize(rect.width, rect.height);
  set_size_needed = true;
}

function renderForeground(canvas, ctx) {
  ctx.fillStyle = "red";
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.textAlign = "center";
  ctx.textBaseline = "middle";

  // Calculate font size based on canvas dimensions
  const nameSize = Math.min(canvas.width / 12, canvas.height / 6);
  const portfolioSize = nameSize * 0.85;
  const lineSpacing = nameSize * 1.4;

  // Line 1: Antoine Goudedranche
  ctx.font = `bold ${Math.round(nameSize)}px Roboto Mono`;
  ctx.fillText("Antoine Goudedranche", canvas.width / 2, canvas.height / 2 - lineSpacing / 2);

  // Line 2: Portfolio (centered below)
  ctx.font = `${Math.round(portfolioSize)}px Roboto Mono`;
  ctx.fillText("Portfolio", canvas.width / 2, canvas.height / 2 + lineSpacing / 2);
}

/**
 * @param {MouseEvent} e
 */
function mousemove(e) {
  const rect = appRoot.getBoundingClientRect();
  flowmap.mouse.set((e.x - 0) / rect.width, (rect.bottom - e.y) / rect.height);
  flowmap.velocity.set(
    (e.movementX / rect.width) * simulation_size[0],
    (e.movementY / rect.width) * simulation_size[1]
  );
}

function touchmove(e) {
  if (!e.touches || e.touches.length === 0) return;
  const touch = e.touches[0];
  const rect = appRoot.getBoundingClientRect();
  e.preventDefault();
  flowmap.mouse.set(
    (touch.clientX - 0) / rect.width,
    (rect.bottom - touch.clientY) / rect.height
  );
  // Approximate movement by comparing with previous position
  if (!touchmove.prev) touchmove.prev = { x: touch.clientX, y: touch.clientY };
  flowmap.velocity.set(
    ((touch.clientX - touchmove.prev.x) / rect.width) * simulation_size[0],
    ((touch.clientY - touchmove.prev.y) / rect.width) * simulation_size[1]
  );
  touchmove.prev.x = touch.clientX;
  touchmove.prev.y = touch.clientY;
}

// Main setup
let alive = true;
async function initOGL() {
  appRoot = document.getElementById("ogl-canvas-root");
  appRoot.appendChild(gl.canvas);
  renderer.setSize(window.innerWidth, window.innerHeight);
  let pressure = createRenderTarget();
  let background = createRenderTarget();
  let pressure_temp = createRenderTarget(true);
  let velocity = createRenderTarget();
  let velocity_temp = createRenderTarget(true);

  flowmap = new Flowmap(gl, {
    size: 512,
    falloff: 0.12,
    alpha: 0.8,
    dissipation: 0.7,
  });

  // register listener
  window.addEventListener("resize", resize);
  resize();

  window.addEventListener("touchmove", touchmove, { passive: false });
  window.addEventListener("mousemove", mousemove);

  // Main initialization
  initializePressure(pressure);

  // Rendering
  function update(t) {
    if (alive) requestAnimationFrame(update);
    flowmap.update();
    flowmap.velocity.set(0, 0);

    if (set_size_needed) {
      set_size_needed = false;
      displayTexture(pressure_temp, pressure.texture, false);
      displayTexture(velocity_temp, velocity.texture, false);

      const scale = Math.max(
        0.4,
        Math.min(
          0.8,
          (1024 / Math.min(renderer.width, renderer.height)) *
            window.devicePixelRatio
        )
      );

      const width = Math.round((renderer.width * scale) / 4) * 4;
      const height = Math.round((renderer.height * scale) / 4) * 4;

      simulation_size = [width, height];

      for (let target of renderTargets) target.setSize(width, height);

      displayTexture(pressure, pressure_temp.texture, false);
      displayTexture(velocity, velocity_temp.texture, false);

      for (let target of renderTargets_delayed_set_size)
        target.setSize(width, height);
    }

    fluidVelocity(
      velocity_temp,
      pressure.texture,
      velocity.texture,
      flowmap.mask.read.texture
    );

    const maskTexture = canvasRenderer(renderer, renderForeground);

    for (let i = 0; i < FLAG_iteration; i++) {
      velocityToPresure(pressure_temp, velocity_temp.texture);
      velocityCorrection(
        velocity,
        pressure_temp.texture,
        velocity_temp.texture
      );

      advection(velocity_temp, velocity.texture, velocity.texture);
      advection(pressure_temp, pressure.texture, velocity.texture);

      reactionDiffusion(pressure, pressure_temp.texture, maskTexture);
    }

    displayTexture(velocity, velocity_temp.texture, false);
    backgroundClock(background, [parallax.value.x, parallax.value.y]);
    glassShading(renderer, pressure.texture, background.texture, [
      parallax.value.x,
      parallax.value.y,
    ]);

    if (FLAG_debug == "velocity") {
      displayTexture(renderer, velocity.texture, false);
    } else if (FLAG_debug == "pressure") {
      displayTexture(renderer, pressure.texture, true);
    } else if (FLAG_debug == "background") {
      displayTexture(renderer, background.texture, false);
    } else if (FLAG_debug == "flowmap") {
      displayTexture(null, flowmap.mask.read.texture, false);
    }
  }
  requestAnimationFrame(update);
}

function destroy() {
  // remove listener
  window.removeEventListener("resize", resize);
  window.removeEventListener("touchmove", touchmove);
  window.removeEventListener("mousemove", mousemove);
  if (appRoot && gl.canvas.parentNode === appRoot) {
    appRoot.removeChild(gl.canvas);
  }
  alive = false;
}

onMounted(() => {
  initOGL();
});

onBeforeUnmount(() => {
  destroy();
});
</script>

<template>
  <div class="app-container">
    <!-- Fluid Glass Background -->
    <div id="ogl-canvas-root"></div>
    
    <!-- Navbar Overlay -->
    <nav class="navbar">
      <div class="nav-logo">AG</div>
      <div class="nav-links">
        <router-link to="/" class="nav-link active">{{ t.home }}</router-link>
        <router-link to="/projects" class="nav-link">{{ t.projects }}</router-link>
        <router-link to="/about" class="nav-link">{{ t.about }}</router-link>
        <router-link to="/contact" class="nav-link">{{ t.contact }}</router-link>
      </div>
      <button class="lang-toggle" @click="toggleLanguage">
        <span :class="{ active: currentLang === 'fr' }">FR</span>
        <span class="separator">/</span>
        <span :class="{ active: currentLang === 'en' }">EN</span>
      </button>
    </nav>
    
    <!-- CTA Button Overlay -->
    <div class="cta-container">
      <button class="cta-button" @click="scrollToPortfolio">
        <span class="cta-text">{{ t.viewPortfolio }}</span>
        <svg class="cta-arrow" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M5 12h14M12 5l7 7-7 7"/>
        </svg>
      </button>
    </div>
  </div>
</template>

<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

.app-container {
  width: 100%;
  height: 100%;
  position: relative;
  overflow: hidden;
}

#ogl-canvas-root {
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  z-index: 0;
  
  canvas {
    width: 100%;
    height: 100%;
  }
}

// Navbar styles
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 3rem;
  background: rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.nav-logo {
  font-family: 'Inter', sans-serif;
  font-size: 1.5rem;
  font-weight: 700;
  color: #fff;
  letter-spacing: 0.05em;
  text-shadow: 0 0 20px rgba(255, 140, 50, 0.5);
}

.nav-links {
  display: flex;
  gap: 2.5rem;
}

.nav-link {
  font-family: 'Inter', sans-serif;
  font-size: 0.9rem;
  font-weight: 500;
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  letter-spacing: 0.02em;
  transition: all 0.3s ease;
  position: relative;
  
  &::after {
    content: '';
    position: absolute;
    bottom: -4px;
    left: 0;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, #ff8c32, #ffb366);
    transition: width 0.3s ease;
  }
  
  &:hover, &.active {
    color: #fff;
    text-shadow: 0 0 15px rgba(255, 140, 50, 0.6);
    
    &::after {
      width: 100%;
    }
  }
  
  &.active {
    color: #ff8c32;
  }
}

.lang-toggle {
  font-family: 'Inter', sans-serif;
  font-size: 0.85rem;
  font-weight: 500;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 0.5rem 1rem;
  color: rgba(255, 255, 255, 0.7);
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.3rem;
  
  &:hover {
    background: rgba(255, 255, 255, 0.15);
    border-color: rgba(255, 255, 255, 0.3);
  }
  
  span {
    transition: all 0.3s ease;
    
    &.active {
      color: #ff8c32;
      font-weight: 600;
      text-shadow: 0 0 10px rgba(255, 140, 50, 0.5);
    }
  }
  
  .separator {
    color: rgba(255, 255, 255, 0.3);
  }
}

// CTA Button styles
.cta-container {
  position: fixed;
  bottom: 15%;
  left: 50%;
  transform: translateX(-50%);
  z-index: 100;
}

.cta-button {
  font-family: 'Inter', sans-serif;
  font-size: 1rem;
  font-weight: 600;
  color: #fff;
  background: linear-gradient(135deg, rgba(255, 140, 50, 0.8), rgba(255, 100, 50, 0.9));
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50px;
  padding: 1rem 2.5rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 0.75rem;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  box-shadow: 
    0 10px 40px rgba(255, 100, 50, 0.3),
    0 0 60px rgba(255, 140, 50, 0.2),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  
  &:hover {
    transform: translateY(-3px);
    box-shadow: 
      0 15px 50px rgba(255, 100, 50, 0.4),
      0 0 80px rgba(255, 140, 50, 0.3),
      inset 0 1px 0 rgba(255, 255, 255, 0.3);
    
    .cta-arrow {
      transform: translateX(5px);
    }
  }
  
  &:active {
    transform: translateY(-1px);
  }
}

.cta-text {
  letter-spacing: 0.03em;
}

.cta-arrow {
  width: 20px;
  height: 20px;
  transition: transform 0.3s ease;
}

// Responsive styles
@media (max-width: 768px) {
  .navbar {
    padding: 1rem 1.5rem;
  }
  
  .nav-links {
    display: none;
  }
  
  .cta-button {
    padding: 0.875rem 2rem;
    font-size: 0.9rem;
  }
}
</style>
