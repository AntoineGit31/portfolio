<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

// Language state (will be replaced by a global store later)
const currentLang = ref('fr');

const translations = {
  fr: {
    title: 'Contact',
    subtitle: "Envie de collaborer ? N'hésitez pas à me contacter !",
    sendEmail: 'Envoyer un email',
    connectLinkedin: 'Se connecter sur LinkedIn',
    orReachMe: 'Ou retrouvez-moi sur',
    availableFor: 'Disponible pour',
    opportunities: [
      'Missions freelance',
      'Projets Data & IA',
      'Collaborations',
      'Recherche stage Data Analyst ou similaire'
    ],
    responseTime: 'Temps de réponse moyen',
    responseValue: '< 24h',
    backHome: 'Retour',
    home: 'Accueil',
    projects: 'Projets',
    about: 'À propos',
    contact: 'Contact',
  },
  en: {
    title: 'Contact',
    subtitle: "Want to collaborate? Feel free to reach out!",
    sendEmail: 'Send an email',
    connectLinkedin: 'Connect on LinkedIn',
    orReachMe: 'Or find me on',
    availableFor: 'Available for',
    opportunities: [
      'Freelance missions',
      'Data & AI projects',
      'Collaborations',
      'Looking for Data Analyst Stage or similar'
    ],
    responseTime: 'Average response time',
    responseValue: '< 24h',
    backHome: 'Back',
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

function goHome() {
  router.push('/');
}

const email = 'antoine31.goudedranche@gmail.com';
const linkedinUrl = 'https://www.linkedin.com/in/antoine-goudedranche-43596a268/';

// ============= PARTICLE NETWORK ANIMATION =============
const canvasRef = ref(null);
let animationId = null;
let particles = [];
let mouse = { x: null, y: null, radius: 150 };

class Particle {
  constructor(canvas) {
    this.canvas = canvas;
    this.x = Math.random() * canvas.width;
    this.y = Math.random() * canvas.height;
    this.size = Math.random() * 2 + 1;
    this.baseSize = this.size;
    this.speedX = (Math.random() - 0.5) * 0.8;
    this.speedY = (Math.random() - 0.5) * 0.8;
    this.density = Math.random() * 30 + 1;
    // Orange color palette
    this.hue = Math.random() * 30 + 15; // 15-45 (orange range)
    this.saturation = Math.random() * 30 + 70; // 70-100%
    this.lightness = Math.random() * 20 + 50; // 50-70%
    this.alpha = Math.random() * 0.5 + 0.3;
  }

  update() {
    // Mouse interaction - particles get pushed away
    if (mouse.x !== null && mouse.y !== null) {
      const dx = mouse.x - this.x;
      const dy = mouse.y - this.y;
      const distance = Math.sqrt(dx * dx + dy * dy);
      
      if (distance < mouse.radius) {
        const force = (mouse.radius - distance) / mouse.radius;
        const directionX = dx / distance;
        const directionY = dy / distance;
        
        // Push particles away from mouse
        this.x -= directionX * force * 3;
        this.y -= directionY * force * 3;
        
        // Increase size when near mouse
        this.size = this.baseSize + force * 3;
      } else {
        this.size = this.baseSize;
      }
    }

    // Regular movement
    this.x += this.speedX;
    this.y += this.speedY;

    // Boundary check with smooth wrapping
    if (this.x < 0) this.x = this.canvas.width;
    if (this.x > this.canvas.width) this.x = 0;
    if (this.y < 0) this.y = this.canvas.height;
    if (this.y > this.canvas.height) this.y = 0;
  }

  draw(ctx) {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
    ctx.fillStyle = `hsla(${this.hue}, ${this.saturation}%, ${this.lightness}%, ${this.alpha})`;
    ctx.fill();
    
    // Add glow effect
    ctx.shadowBlur = 15;
    ctx.shadowColor = `hsla(${this.hue}, ${this.saturation}%, ${this.lightness}%, 0.5)`;
  }
}

function initParticles(canvas) {
  particles = [];
  const particleCount = Math.min(Math.floor((canvas.width * canvas.height) / 6000), 200);
  
  for (let i = 0; i < particleCount; i++) {
    particles.push(new Particle(canvas));
  }
}

function connectParticles(ctx) {
  const maxDistance = 150;
  
  for (let i = 0; i < particles.length; i++) {
    for (let j = i + 1; j < particles.length; j++) {
      const dx = particles[i].x - particles[j].x;
      const dy = particles[i].y - particles[j].y;
      const distance = Math.sqrt(dx * dx + dy * dy);
      
      if (distance < maxDistance) {
        const opacity = (1 - distance / maxDistance) * 0.4;
        
        // Create gradient line
        const gradient = ctx.createLinearGradient(
          particles[i].x, particles[i].y,
          particles[j].x, particles[j].y
        );
        gradient.addColorStop(0, `hsla(30, 100%, 60%, ${opacity})`);
        gradient.addColorStop(0.5, `hsla(25, 100%, 55%, ${opacity * 1.2})`);
        gradient.addColorStop(1, `hsla(20, 100%, 50%, ${opacity})`);
        
        ctx.beginPath();
        ctx.strokeStyle = gradient;
        ctx.lineWidth = opacity * 2;
        ctx.moveTo(particles[i].x, particles[i].y);
        ctx.lineTo(particles[j].x, particles[j].y);
        ctx.stroke();
      }
    }
  }
  
  // Connect particles to mouse for extra interactivity
  if (mouse.x !== null && mouse.y !== null) {
    for (let i = 0; i < particles.length; i++) {
      const dx = particles[i].x - mouse.x;
      const dy = particles[i].y - mouse.y;
      const distance = Math.sqrt(dx * dx + dy * dy);
      
      if (distance < mouse.radius) {
        const opacity = (1 - distance / mouse.radius) * 0.6;
        
        ctx.beginPath();
        ctx.strokeStyle = `hsla(35, 100%, 65%, ${opacity})`;
        ctx.lineWidth = opacity * 2.5;
        ctx.moveTo(particles[i].x, particles[i].y);
        ctx.lineTo(mouse.x, mouse.y);
        ctx.stroke();
      }
    }
  }
}

function animate() {
  const canvas = canvasRef.value;
  if (!canvas) return;
  
  const ctx = canvas.getContext('2d');
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  
  // Reset shadow for performance
  ctx.shadowBlur = 0;
  
  // Draw connections first (behind particles)
  connectParticles(ctx);
  
  // Update and draw particles
  for (let particle of particles) {
    particle.update();
    particle.draw(ctx);
  }
  
  animationId = requestAnimationFrame(animate);
}

function handleResize() {
  const canvas = canvasRef.value;
  if (!canvas) return;
  
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  initParticles(canvas);
}

function handleMouseMove(e) {
  mouse.x = e.clientX;
  mouse.y = e.clientY;
}

function handleMouseLeave() {
  mouse.x = null;
  mouse.y = null;
}

function handleTouchMove(e) {
  if (e.touches.length > 0) {
    mouse.x = e.touches[0].clientX;
    mouse.y = e.touches[0].clientY;
  }
}

function handleTouchEnd() {
  mouse.x = null;
  mouse.y = null;
}

onMounted(() => {
  const canvas = canvasRef.value;
  if (canvas) {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    initParticles(canvas);
    animate();
    
    window.addEventListener('resize', handleResize);
    window.addEventListener('mousemove', handleMouseMove);
    window.addEventListener('mouseleave', handleMouseLeave);
    window.addEventListener('touchmove', handleTouchMove);
    window.addEventListener('touchend', handleTouchEnd);
  }
});

onBeforeUnmount(() => {
  if (animationId) {
    cancelAnimationFrame(animationId);
  }
  window.removeEventListener('resize', handleResize);
  window.removeEventListener('mousemove', handleMouseMove);
  window.removeEventListener('mouseleave', handleMouseLeave);
  window.removeEventListener('touchmove', handleTouchMove);
  window.removeEventListener('touchend', handleTouchEnd);
});
</script>

<template>
  <div class="contact-page">
    <!-- Animated background -->
    <div class="background-gradient"></div>
    <div class="floating-orbs">
      <div class="orb orb-1"></div>
      <div class="orb orb-2"></div>
      <div class="orb orb-3"></div>
    </div>
    
    <!-- Particle Network Canvas -->
    <canvas ref="canvasRef" class="particle-canvas"></canvas>
    
    <!-- Navbar -->
    <nav class="navbar">
      <button class="back-button" @click="goHome">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M19 12H5M12 19l-7-7 7-7"/>
        </svg>
        <span>{{ t.backHome }}</span>
      </button>
      <div class="nav-links">
        <router-link to="/" class="nav-link">{{ t.home }}</router-link>
        <router-link to="/projects" class="nav-link">{{ t.projects }}</router-link>
        <router-link to="/about" class="nav-link">{{ t.about }}</router-link>
        <router-link to="/contact" class="nav-link active">{{ t.contact }}</router-link>
      </div>
      <button class="lang-toggle" @click="toggleLanguage">
        <span :class="{ active: currentLang === 'fr' }">FR</span>
        <span class="separator">/</span>
        <span :class="{ active: currentLang === 'en' }">EN</span>
      </button>
    </nav>
    
    <!-- Main content -->
    <main class="contact-content">
      <div class="contact-header">
        <h1 class="contact-title">{{ t.title }}</h1>
        <p class="contact-subtitle">{{ t.subtitle }}</p>
      </div>
      
      <div class="contact-grid">
        <!-- Email Card -->
        <div class="contact-card email-card">
          <div class="card-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
            </svg>
          </div>
          <h3 class="card-title">Email</h3>
          <p class="card-email">{{ email }}</p>
          <a :href="'mailto:' + email" class="card-button email-button">
            <span>{{ t.sendEmail }}</span>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M5 12h14M12 5l7 7-7 7"/>
            </svg>
          </a>
        </div>
        
        <!-- LinkedIn Card -->
        <div class="contact-card linkedin-card">
          <div class="card-icon linkedin-icon">
            <svg viewBox="0 0 24 24" fill="currentColor">
              <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
            </svg>
          </div>
          <h3 class="card-title">LinkedIn</h3>
          <p class="card-description">Antoine Goudedranche</p>
          <a :href="linkedinUrl" target="_blank" rel="noopener noreferrer" class="card-button linkedin-button">
            <span>{{ t.connectLinkedin }}</span>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M18 13v6a2 2 0 01-2 2H5a2 2 0 01-2-2V8a2 2 0 012-2h6M15 3h6v6M10 14L21 3"/>
            </svg>
          </a>
        </div>
      </div>
      
      <!-- Info Section -->
      <div class="info-section">
        <div class="info-card">
          <h4 class="info-title">{{ t.availableFor }}</h4>
          <ul class="info-list">
            <li v-for="(item, index) in t.opportunities" :key="index">
              <span class="bullet"></span>
              {{ item }}
            </li>
          </ul>
        </div>
        
        <div class="info-card response-card">
          <h4 class="info-title">{{ t.responseTime }}</h4>
          <p class="response-time">{{ t.responseValue }}</p>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

.contact-page {
  min-height: 100vh;
  width: 100%;
  position: relative;
  overflow-x: hidden;
  font-family: 'Inter', sans-serif;
  color: #fff;
}

// Animated background
.background-gradient {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, #0a0a0f 0%, #1a1a2e 50%, #0f0f1a 100%);
  z-index: -2;
}

.floating-orbs {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: -1;
  overflow: hidden;
}

// Particle Network Canvas
.particle-canvas {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
  pointer-events: none;
}

.orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.5;
  animation: float 20s ease-in-out infinite;
}

.orb-1 {
  width: 600px;
  height: 600px;
  background: radial-gradient(circle, rgba(255, 140, 50, 0.3) 0%, transparent 70%);
  top: -200px;
  right: -200px;
  animation-delay: 0s;
}

.orb-2 {
  width: 500px;
  height: 500px;
  background: radial-gradient(circle, rgba(255, 100, 50, 0.25) 0%, transparent 70%);
  bottom: -150px;
  left: -150px;
  animation-delay: -7s;
}

.orb-3 {
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, rgba(255, 180, 100, 0.2) 0%, transparent 70%);
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  animation-delay: -14s;
}

@keyframes float {
  0%, 100% { transform: translate(0, 0) scale(1); }
  25% { transform: translate(30px, -30px) scale(1.05); }
  50% { transform: translate(-20px, 20px) scale(0.95); }
  75% { transform: translate(20px, 10px) scale(1.02); }
}

// Navbar
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
  background: rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.back-button {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 25px;
  padding: 0.5rem 1rem;
  color: #fff;
  font-family: 'Inter', sans-serif;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.3s ease;
  
  svg {
    width: 18px;
    height: 18px;
  }
  
  &:hover {
    background: rgba(255, 255, 255, 0.15);
    transform: translateX(-3px);
  }
}

.nav-links {
  display: flex;
  gap: 2.5rem;
}

.nav-link {
  font-size: 0.9rem;
  font-weight: 500;
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
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
    &::after { width: 100%; }
  }
  
  &.active {
    color: #ff8c32;
  }
}

.lang-toggle {
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
  }
  
  span.active {
    color: #ff8c32;
    font-weight: 600;
  }
  
  .separator {
    color: rgba(255, 255, 255, 0.3);
  }
}

// Main content
.contact-content {
  position: relative;
  z-index: 10;
  padding: 120px 3rem 3rem;
  max-width: 1200px;
  margin: 0 auto;
}

.contact-header {
  text-align: center;
  margin-bottom: 4rem;
}

.contact-title {
  font-size: 4rem;
  font-weight: 700;
  background: linear-gradient(135deg, #fff 0%, #ff8c32 50%, #ffb366 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 1rem;
  letter-spacing: -0.02em;
}

.contact-subtitle {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.7);
  font-weight: 400;
}

// Contact cards grid
.contact-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 2rem;
  margin-bottom: 3rem;
}

.contact-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 24px;
  padding: 2.5rem;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  transition: all 0.4s ease;
  
  &:hover {
    transform: translateY(-5px);
    border-color: rgba(255, 140, 50, 0.3);
    box-shadow: 0 20px 60px rgba(255, 100, 50, 0.15);
  }
}

.card-icon {
  width: 60px;
  height: 60px;
  border-radius: 16px;
  background: linear-gradient(135deg, rgba(255, 140, 50, 0.2), rgba(255, 100, 50, 0.1));
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1.5rem;
  
  svg {
    width: 28px;
    height: 28px;
    color: #ff8c32;
  }
}

.linkedin-icon {
  background: linear-gradient(135deg, rgba(10, 102, 194, 0.3), rgba(10, 102, 194, 0.1));
  
  svg {
    color: #0a66c2;
  }
}

.card-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.card-email, .card-description {
  font-size: 1rem;
  color: rgba(255, 255, 255, 0.6);
  margin-bottom: 1.5rem;
}

.card-button {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.875rem 1.5rem;
  border-radius: 50px;
  font-size: 0.95rem;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.3s ease;
  
  svg {
    width: 18px;
    height: 18px;
    transition: transform 0.3s ease;
  }
  
  &:hover svg {
    transform: translateX(4px);
  }
}

.email-button {
  background: linear-gradient(135deg, #ff8c32, #ff6432);
  color: #fff;
  box-shadow: 0 8px 30px rgba(255, 100, 50, 0.3);
  
  &:hover {
    box-shadow: 0 12px 40px rgba(255, 100, 50, 0.4);
    transform: translateY(-2px);
  }
}

.linkedin-button {
  background: linear-gradient(135deg, #0a66c2, #004182);
  color: #fff;
  box-shadow: 0 8px 30px rgba(10, 102, 194, 0.3);
  
  &:hover {
    box-shadow: 0 12px 40px rgba(10, 102, 194, 0.4);
    transform: translateY(-2px);
  }
}

// Info section
.info-section {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2rem;
}

.info-card {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 20px;
  padding: 2rem;
}

.info-title {
  font-size: 1rem;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.5);
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 1.5rem;
}

.info-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  
  li {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-size: 1rem;
    color: rgba(255, 255, 255, 0.8);
  }
}

.bullet {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ff8c32, #ffb366);
  flex-shrink: 0;
}

.response-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.response-time {
  font-size: 3rem;
  font-weight: 700;
  background: linear-gradient(135deg, #ff8c32, #ffb366);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

// Responsive
@media (max-width: 900px) {
  .contact-grid {
    grid-template-columns: 1fr;
  }
  
  .info-section {
    grid-template-columns: 1fr;
  }
  
  .info-list {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .navbar {
    padding: 1rem 1.5rem;
  }
  
  .nav-links {
    display: none;
  }
  
  .contact-content {
    padding: 100px 1.5rem 2rem;
  }
  
  .contact-title {
    font-size: 2.5rem;
  }
  
  .contact-subtitle {
    font-size: 1rem;
  }
}
</style>
