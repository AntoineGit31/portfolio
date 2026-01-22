<script setup>
import { ref, onMounted, onBeforeUnmount, computed } from 'vue';
import { useRouter } from 'vue-router';
import Earth3D from '../components/Earth3D.vue';

const router = useRouter();
const currentLang = ref('fr');

const translations = {
  fr: {
    backHome: 'Retour',
    home: 'Accueil',
    projects: 'Projets',
    about: 'À propos',
    contact: 'Contact',
    greeting: 'Bonjour, je m\'appelle',
    name: 'Antoine Goudedranche',
    role: 'Étudiant en Master 1 Data & Intelligence Artificielle',
    bio: "Passionné par la data et les nouveaux modèles d'intelligence artificielle, ce portfolio a pour objectif de présenter mes projets personnels, mes expérimentations techniques et mes centres d'intérêt dans ces domaines. Actuellement en 4ᵉ année à l'école d'ingénieurs ECE, je développe des compétences solides en analyse de données, programmation et visualisation, avec une appétence particulière pour les applications concrètes de la data et de l'IA.",
    experienceTitle: 'Expérience',
    educationTitle: 'Formation',
    skillsTitle: 'Compétences',
    passionsTitle: 'Passions',
    scrollHint: 'Scrollez pour découvrir',
    experiences: [
      {
        title: 'Stagiaire Projet',
        company: 'Continental Automotive, Toulouse',
        period: 'Janv 2024 – Fév 2024',
        description: "Travail de recherche et d'analyse sur l'éco-conception numérique pour le service IT."
      },
      {
        title: 'Vendeur',
        company: 'IKEA Roques',
        period: 'Janv 2025 – Fév 2025',
        description: "Immersion dans le monde de l'entreprise dans un secteur externe à mon cursus scolaire."
      },
      {
        title: 'Data Analyst - Stage',
        company: 'En recherche...',
        period: 'Avril 2026 – Sept 2026',
        description: "À la recherche d'un stage en Data Analysis pour mettre en pratique mes compétences."
      }
    ],
    education: [
      {
        degree: 'Majeure Data & Intelligence Artificielle',
        school: 'ECE Paris – Lyon (Parcours International)',
        period: '2022 – 2027',
        description: 'Formation d’ingénieur généraliste avec une spécialisation en Data & Intelligence Artificielle, orientée vers l’analyse de données, le machine learning et les systèmes décisionnels.'
      },
      {
        degree: 'Semestre à l\'étranger',
        school: 'Nelson Mandela University (Afrique du Sud)',
        period: '2024',
        description: 'Approfondissement technique et ouverture culturelle.'
      }
    ],
    skills: {
      data: ['Python', 'SQL', 'Pandas', 'NumPy', 'Scikit-learn'],
      viz: ['Power BI', 'Matplotlib', 'Streamlit', 'Seaborn'],
      dev: ['HTML', 'CSS', 'JavaScript', 'PHP', 'C','Python'],
      tools: ['Docker', 'Jupyter', 'Antigravity', 'phpMyAdmin']
    },
    passions: [
      {
        title: 'Tennis',
        description: 'Tennis Club de Muret (2011 – 2021)'
      },
      {
        title: 'Musculation',
        description: 'Développement d\'un site web personnel de suivi des performances sportives',
        linkText: 'perf-tracker.netlify.app',
        linkUrl: 'https://perf-tracker.netlify.app/',
        period: '(2023 – 2026)'
      },
      {
        title: 'Jeux vidéo',
        description: 'Valorant (Immortal II), League of Legends (Diamant III), Teamfight Tactics (Émeraude IV), Counter-Strike 2 (Aigle Légendaire)'
      }
    ],
    contactMe: 'Me contacter',
  },
  en: {
    backHome: 'Back',
    home: 'Home',
    projects: 'Projects',
    about: 'About',
    contact: 'Contact',
    greeting: "Hi, I'm",
    name: 'Antoine Goudedranche',
    role: 'Master 1 Data & Artificial Intelligence Student',
    bio: "Passionate about data and new artificial intelligence models, this portfolio aims to showcase my personal projects, technical experiments, and areas of interest in these fields. Currently in my 4th year at ECE engineering school, I'm developing strong skills in data analysis, programming, and visualization, with a particular interest in practical applications of data and AI.",
    experienceTitle: 'Experience',
    educationTitle: 'Education',
    skillsTitle: 'Skills',
    passionsTitle: 'Passions',
    scrollHint: 'Scroll to discover',
    experiences: [
      {
        title: 'Project Intern',
        company: 'Continental Automotive, Toulouse',
        period: 'Jan 2024 – Feb 2024',
        description: 'Research and analysis work on digital eco-design for the IT department.'
      },
      {
        title: 'Sales Associate',
        company: 'IKEA Roques',
        period: 'Jan 2025 – Feb 2025',
        description: 'Immersion in the business world in a sector outside my academic curriculum.'
      },
      {
        title: 'Data Analyst - Internship',
        company: 'Looking for opportunities...',
        period: 'April 2026 – Sept 2026',
        description: 'Seeking a Data Analysis internship to apply my skills in practice.'
      }
    ],
    education: [
      {
        degree: 'Major in Data & Artificial Intelligence',
        school: 'ECE Paris – Lyon (International Track)',
        period: '2022 – 2027',
        description: 'Generalist engineering program with a specialization in Data & Artificial Intelligence, focused on data analysis, machine learning, and decision-making systems.'
      },
      {
        degree: 'Semester Abroad',
        school: 'Nelson Mandela University (South Africa)',
        period: '2024',
        description: 'Technical deepening and cultural openness.'
      }
    ],
    skills: {
      data: ['Python', 'SQL', 'Pandas', 'NumPy', 'Scikit-learn'],
      viz: ['Power BI', 'Matplotlib', 'Streamlit', 'Seaborn'],
      dev: ['HTML', 'CSS', 'JavaScript', 'PHP', 'C', 'Python'],
      tools: ['Docker', 'Jupyter', 'Antigravity', 'phpMyAdmin']
    },
    passions: [
      {
        title: 'Tennis',
        description: 'Tennis Club de Muret (2011 – 2021)'
      },
      {
        title: 'Weight Training',
        description: 'Development of a personal sports performance tracking website',
        linkText: 'perf-tracker.netlify.app',
        linkUrl: 'https://perf-tracker.netlify.app/',
        period: '(2023 – 2026)'
      },
      {
        title: 'Video Games',
        description: 'Valorant (Immortal II), League of Legends (Diamond III), Teamfight Tactics (Emerald IV), Counter-Strike 2 (Legendary Eagle)'
      }
    ],
    contactMe: 'Contact me',
  }
};

const t = computed(() => translations[currentLang.value]);

function toggleLanguage() {
  currentLang.value = currentLang.value === 'fr' ? 'en' : 'fr';
}

function goHome() {
  router.push('/');
}

function goToContact() {
  router.push('/contact');
}

// ============= STAR FIELD ANIMATION =============
const spaceCanvasRef = ref(null);
// Parallax background & Monitor 3D effect
const monitorTiltStyle = ref({ transform: 'perspective(1200px) rotateX(2deg) rotateY(0deg)' });
const screenGlowStyle = ref({ opacity: 0.3 });
const nebulaParallax = ref({ transform: 'translate(0, 0)' });
const sunParallax = ref({ transform: 'translate(0, 0)' });
const planetParallax = ref({ transform: 'translate(0, 0)' });
const planet2Parallax = ref({ transform: 'translate(0, 0)' });
const earthParallax = ref({ transform: 'translate(0, 0)' });

// Orbital motion state
const sunOrbit = ref({ x: 0, y: 0 });
const planetOrbit = ref({ x: 0, y: 0 });
const planet2Orbit = ref({ x: 0, y: 0 });
const earthOrbit = ref({ x: 0, y: 0 });
const terminalScrollRef = ref(null);

let spaceAnimationId = null;
let stars = [];
let shootingStars = [];

class Star {
  constructor(canvas) {
    this.canvas = canvas;
    this.reset();
  }
  
  reset() {
    this.x = Math.random() * this.canvas.width;
    this.y = Math.random() * this.canvas.height;
    // Brighter and more visible stars
    this.size = Math.random() < 0.8 ? Math.random() * 1.2 + 0.4 : Math.random() * 2.5 + 0.6;
    this.opacity = Math.random() * 0.8 + 0.2; 
    this.twinkleSpeed = Math.random() * 0.02 + 0.005; 
    this.twinklePhase = Math.random() * Math.PI * 2;
    
    const colorType = Math.random();
    if (colorType < 0.6) {
      this.color = '255, 255, 255';
    } else if (colorType < 0.8) {
      this.color = '220, 240, 255'; // More blue
    } else {
      this.color = '255, 250, 220'; // More gold
    }
  }
  
  update(time) {
    this.currentOpacity = this.opacity * (0.6 + 0.4 * Math.sin(time * this.twinkleSpeed + this.twinklePhase));
  }
  
  draw(ctx) {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.size / 1.5, 0, Math.PI * 2);
    ctx.fillStyle = `rgba(${this.color}, ${this.currentOpacity})`;
    ctx.fill();
    
    // Enhanced glow for visible stars
    if (this.size > 1.2) {
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.size * 3, 0, Math.PI * 2);
      const gradient = ctx.createRadialGradient(this.x, this.y, 0, this.x, this.y, this.size * 3);
      gradient.addColorStop(0, `rgba(${this.color}, ${this.currentOpacity * 0.4})`);
      gradient.addColorStop(1, 'transparent');
      ctx.fillStyle = gradient;
      ctx.fill();
    }
  }
}

class ShootingStar {
  constructor(canvas) {
    this.canvas = canvas;
    this.reset();
  }
  
  reset() {
    this.active = false;
    this.nextSpawn = Math.random() * 8000 + 4000; // Rarer
  }
  
  spawn() {
    this.x = Math.random() * this.canvas.width * 0.8;
    this.y = Math.random() * this.canvas.height * 0.4;
    this.length = Math.random() * 120 + 80;
    this.speed = Math.random() * 20 + 15; // Faster
    this.angle = Math.PI / 4 + (Math.random() - 0.5) * 0.2;
    this.opacity = 1;
    this.active = true;
  }
  
  update() {
    if (!this.active) {
      this.nextSpawn -= 16;
      if (this.nextSpawn <= 0) {
        this.spawn();
      }
      return;
    }
    
    this.x += Math.cos(this.angle) * this.speed;
    this.y += Math.sin(this.angle) * this.speed;
    this.opacity -= 0.025;
    
    if (this.opacity <= 0 || this.x > this.canvas.width || this.y > this.canvas.height) {
      this.reset();
    }
  }
  
  draw(ctx) {
    if (!this.active) return;
    
    const endX = this.x - Math.cos(this.angle) * this.length;
    const endY = this.y - Math.sin(this.angle) * this.length;
    
    const gradient = ctx.createLinearGradient(this.x, this.y, endX, endY);
    gradient.addColorStop(0, `rgba(255, 255, 255, ${this.opacity * 0.8})`);
    gradient.addColorStop(0.5, `rgba(200, 230, 255, ${this.opacity * 0.2})`);
    gradient.addColorStop(1, 'transparent');
    
    ctx.beginPath();
    ctx.moveTo(this.x, this.y);
    ctx.lineTo(endX, endY);
    ctx.strokeStyle = gradient;
    ctx.lineWidth = 1; // Thinner tail
    ctx.stroke();
  }
}

function initStars(canvas) {
  stars = [];
  shootingStars = [];
  const starCount = Math.floor((canvas.width * canvas.height) / 1800); // Increased density
  
  for (let i = 0; i < starCount; i++) {
    stars.push(new Star(canvas));
  }
  
  for (let i = 0; i < 4; i++) { // More shooting stars
    shootingStars.push(new ShootingStar(canvas));
  }
}

function animateSpace(time) {
  const canvas = spaceCanvasRef.value;
  if (!canvas) return;
  
  const ctx = canvas.getContext('2d');
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  
  // Ultra-Fast Orbital Motion (Slightly slowed down per user request)
  const orbitalTime = time * 0.00015; 
  sunOrbit.value = {
    x: Math.cos(orbitalTime * 0.3) * 200,
    y: Math.sin(orbitalTime * 0.15) * 120
  };
  
  planetOrbit.value = {
    x: Math.sin(orbitalTime * 0.6) * 450,
    y: Math.cos(orbitalTime * 0.25) * 250
  };

  planet2Orbit.value = {
    x: Math.cos(orbitalTime * 0.5 + Math.PI) * 350,
    y: Math.sin(orbitalTime * 0.3 + Math.PI) * 180
  };

  earthOrbit.value = {
    x: Math.sin(orbitalTime * 0.4 + 2) * 300,
    y: Math.cos(orbitalTime * 0.2 + 2) * 150
  };
  
  stars.forEach(star => {
    star.update(time);
    star.draw(ctx);
  });
  
  shootingStars.forEach(ss => {
    ss.update();
    ss.draw(ctx);
  });
  
  spaceAnimationId = requestAnimationFrame(animateSpace);
}

function handleSpaceResize() {
  const canvas = spaceCanvasRef.value;
  if (!canvas) return;
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  initStars(canvas);
}

// Mouse movement handler for parallax
function handleMouseMove(e) {
  const mouseXNormalized = (e.clientX / window.innerWidth - 0.5);
  const mouseYNormalized = (e.clientY / window.innerHeight - 0.5);
  
  // Monitor 3D tilt
  const x = mouseXNormalized * 8;
  const y = mouseYNormalized * 6;
  monitorTiltStyle.value = {
    transform: `perspective(1200px) rotateX(${2 - y}deg) rotateY(${x}deg)`
  };
  
  // Parallax layers (different speeds for depth)
  nebulaParallax.value = {
    transform: `translate(${mouseXNormalized * -10}px, ${mouseYNormalized * -10}px)`
  };
  
  sunParallax.value = {
    transform: `translate(${mouseXNormalized * -25}px, ${mouseYNormalized * -25}px)`
  };
  
  planetParallax.value = {
    transform: `translate(${mouseXNormalized * -50}px, ${mouseYNormalized * -50}px)`
  };

  planet2Parallax.value = {
    transform: `translate(${mouseXNormalized * -35}px, ${mouseYNormalized * -35}px)`
  };

  earthParallax.value = {
    transform: `translate(${mouseXNormalized * -60}px, ${mouseYNormalized * -60}px)`
  };
  
  screenGlowStyle.value = {
    opacity: 0.3 + Math.abs(x) * 0.05
  };
}

// Global Scroll Handler to ensure workstation scrolls even if mouse is on background
function handleGlobalWheel(e) {
  if (terminalScrollRef.value && !terminalScrollRef.value.contains(e.target)) {
    terminalScrollRef.value.scrollTop += e.deltaY;
  }
}

function handleMouseLeave() {
  monitorTiltStyle.value = { transform: 'perspective(1200px) rotateX(2deg) rotateY(0deg)' };
  screenGlowStyle.value = { opacity: 0.3 };
  nebulaParallax.value = { transform: 'translate(0, 0)' };
  sunParallax.value = { transform: 'translate(0, 0)' };
  planetParallax.value = { transform: 'translate(0, 0)' };
  planet2Parallax.value = { transform: 'translate(0, 0)' };
  earthParallax.value = { transform: 'translate(0, 0)' };
}

// Combined transformation styles (Parallax + Orbital)
const combinedSunStyle = computed(() => {
  const parallax = sunParallax.value.transform || 'translate(0, 0)';
  return {
    transform: `${parallax} translate(${sunOrbit.value.x}px, ${sunOrbit.value.y}px)`
  };
});

const combinedPlanetStyle = computed(() => {
  const parallax = planetParallax.value.transform || 'translate(0, 0)';
  return {
    transform: `rotate(-15deg) ${parallax} translate(${planetOrbit.value.x}px, ${planetOrbit.value.y}px)`
  };
});

const combinedPlanet2Style = computed(() => {
  const parallax = planet2Parallax.value.transform || 'translate(0, 0)';
  return {
    transform: `rotate(20deg) ${parallax} translate(${planet2Orbit.value.x}px, ${planet2Orbit.value.y}px)`
  };
});

const combinedEarthStyle = computed(() => {
  const parallax = earthParallax.value.transform || 'translate(0, 0)';
  return {
    transform: `rotate(-10deg) ${parallax} translate(${earthOrbit.value.x}px, ${earthOrbit.value.y}px)`
  };
});

onMounted(() => {
  // Initialize space animation
  const canvas = spaceCanvasRef.value;
  if (canvas) {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    initStars(canvas);
    animateSpace(0);
  }
  
  window.addEventListener('resize', handleSpaceResize);
  window.addEventListener('mousemove', handleMouseMove);
  window.addEventListener('mouseleave', handleMouseLeave);
  window.addEventListener('wheel', handleGlobalWheel, { passive: true });
});

onBeforeUnmount(() => {
  if (spaceAnimationId) {
    cancelAnimationFrame(spaceAnimationId);
  }
  window.removeEventListener('resize', handleSpaceResize);
  window.removeEventListener('mousemove', handleMouseMove);
  window.removeEventListener('mouseleave', handleMouseLeave);
  window.removeEventListener('wheel', handleGlobalWheel);
});
</script>

<template>
  <div class="page">
    <!-- Subtle Star Field Canvas (Dynamic Stars & Shooting Stars) -->
    <canvas ref="spaceCanvasRef" class="space-canvas"></canvas>
    
    <!-- Realistic Celestial Environment -->
    <div class="space-environment">
      <!-- Distant Nebula Layers -->
      <div class="nebula-wrapper" :style="nebulaParallax">
        <div class="nebula nebula-1"></div>
        <div class="nebula nebula-2"></div>
      </div>
      
      <!-- Realistic Sun (Deep Glow) -->
      <div class="solar-system" :style="combinedSunStyle">
        <div class="sun-flare"></div>
        <div class="sun-core"></div>
        <div class="sun-corona"></div>
        <div class="sun-glow"></div>
      </div>
      
      <!-- Realistic Planet (Atmospheric Rim & Shadow) -->
      <div class="planet-container" :style="combinedPlanetStyle">
        <div class="planet-body">
          <div class="planet-atmosphere"></div>
          <div class="planet-shadow"></div>
        </div>
        <div class="planet-rings"></div>
      </div>

      <!-- Second Planet (Distant Gas Giant) -->
      <div class="planet-container planet-2" :style="combinedPlanet2Style">
        <div class="planet-body planet-2-body">
          <div class="planet-atmosphere planet-2-atmosphere"></div>
          <div class="planet-shadow"></div>
        </div>
      </div>

      <!-- Planet Earth (The Home World) -->
      <div class="planet-container earth-container" :style="combinedEarthStyle">
        <div class="planet-body earth-body" style="background: transparent; box-shadow: none; overflow: visible;">
          <Earth3D :size="200" />
        </div>
      </div>
    </div>
    
    <div class="background-haze"></div>
    <div class="background-gradient"></div>
    
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
        <router-link to="/about" class="nav-link active">{{ t.about }}</router-link>
        <router-link to="/contact" class="nav-link">{{ t.contact }}</router-link>
      </div>
      <button class="lang-toggle" @click="toggleLanguage">
        <span :class="{ active: currentLang === 'fr' }">FR</span>
        <span class="separator">/</span>
        <span :class="{ active: currentLang === 'en' }">EN</span>
      </button>
    </nav>
    
    <main class="content">
      <!-- Futuristic Floating Glass Display -->
      <div class="glass-workstation" :style="monitorTiltStyle">
        <div class="terminal-container">
          <!-- Ambient Screen Glow -->
          <div class="terminal-glow" :style="screenGlowStyle"></div>
          
          <!-- Floating Frame Details -->
          <div class="frame-edge top-left"></div>
          <div class="frame-edge top-right"></div>
          <div class="frame-edge bottom-left"></div>
          <div class="frame-edge bottom-right"></div>

          <!-- Glass Display Layer -->
          <div class="glass-display">
            <!-- Internal UI Elements -->
            <div class="display-header">
              <div class="status-dots">
                <span class="dot"></span>
                <span class="dot"></span>
                <span class="dot"></span>
              </div>
            </div>

            <!-- Scrollable Content -->
            <div class="terminal-content" ref="terminalScrollRef">
              <!-- Hero Section -->
              <section class="screen-section hero-section">
                <p class="greeting">{{ t.greeting }}</p>
                <h1 class="name">{{ t.name }}</h1>
                <p class="role">{{ t.role }}</p>
                <p class="bio">{{ t.bio }}</p>
                <div class="scroll-indicator">
                  <span>{{ t.scrollHint }}</span>
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M12 5v14M5 12l7 7 7-7"/>
                  </svg>
                </div>
              </section>

              <!-- Skills Section -->
              <section class="screen-section skills-section">
                <h2 class="section-title">{{ t.skillsTitle }}</h2>
                <div class="skills-grid">
                  <div class="skill-category">
                    <h3 class="skill-category-title">Data</h3>
                    <div class="skill-tags">
                      <span v-for="skill in t.skills.data" :key="skill" class="skill-tag">{{ skill }}</span>
                    </div>
                  </div>
                  <div class="skill-category">
                    <h3 class="skill-category-title">Visualisation</h3>
                    <div class="skill-tags">
                      <span v-for="skill in t.skills.viz" :key="skill" class="skill-tag">{{ skill }}</span>
                    </div>
                  </div>
                  <div class="skill-category">
                    <h3 class="skill-category-title">Développement</h3>
                    <div class="skill-tags">
                      <span v-for="skill in t.skills.dev" :key="skill" class="skill-tag">{{ skill }}</span>
                    </div>
                  </div>
                  <div class="skill-category">
                    <h3 class="skill-category-title">Outils</h3>
                    <div class="skill-tags">
                      <span v-for="skill in t.skills.tools" :key="skill" class="skill-tag">{{ skill }}</span>
                    </div>
                  </div>
                </div>
              </section>

              <!-- Experience & Education Sections -->
              <section class="screen-section experience-section">
                <h2 class="section-title">{{ t.experienceTitle }}</h2>
                <div class="timeline">
                  <div v-for="(exp, index) in t.experiences" :key="index" class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                      <h3 class="timeline-title">{{ exp.title }}</h3>
                      <p class="timeline-company">{{ exp.company }}</p>
                      <span class="timeline-period">{{ exp.period }}</span>
                      <p class="timeline-description">{{ exp.description }}</p>
                    </div>
                  </div>
                </div>
              </section>

              <section class="screen-section education-section">
                <h2 class="section-title">{{ t.educationTitle }}</h2>
                <div class="timeline">
                  <div v-for="(edu, index) in t.education" :key="index" class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                      <h3 class="timeline-title">{{ edu.degree }}</h3>
                      <p class="timeline-company">{{ edu.school }}</p>
                      <span class="timeline-period">{{ edu.period }}</span>
                      <p class="timeline-description">{{ edu.description }}</p>
                    </div>
                  </div>
                </div>
              </section>

              <section class="screen-section passions-section">
                <h2 class="section-title">{{ t.passionsTitle }}</h2>
                <div class="timeline">
                  <div v-for="(passion, index) in t.passions" :key="index" class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                      <h3 class="timeline-title">{{ passion.title }}</h3>
                      <p class="timeline-description">
                        {{ passion.description }}
                        <template v-if="passion.linkUrl">
                          : <a :href="passion.linkUrl" target="_blank" rel="noopener noreferrer" class="passion-link">{{ passion.linkText }}</a>
                          {{ passion.period }}
                        </template>
                      </p>
                    </div>
                  </div>
                </div>
              </section>

              <!-- Contact CTA -->
              <section class="screen-section cta-section">
                <button class="cta-button" @click="goToContact">
                  <span>{{ t.contactMe }}</span>
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M5 12h14M12 5l7 7-7 7"/>
                  </svg>
                </button>
              </section>
            </div>
            
            <div class="display-reflection"></div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;500&display=swap');

.page {
  min-height: 100vh;
  width: 100%;
  position: relative;
  font-family: 'Inter', sans-serif;
  color: #fff;
  overflow: hidden;
}

.background-gradient {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(circle at 75% 15%, #151525 0%, #0a0a14 30%, #05050a 60%, #000 100%);
  z-index: 0;
}

// Background haze for realism
.background-haze {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(circle at 20% 80%, rgba(30, 50, 100, 0.05) 0%, transparent 50%);
  z-index: 0;
  pointer-events: none;
}

// ============= SPACE CANVAS =============
.space-canvas {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
  pointer-events: none;
  opacity: 0.9;
}

// ============= REALISTIC CELESTIAL ENVIRONMENT =============
.space-environment {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 2;
  pointer-events: none;
  overflow: hidden;
}

// Distant Nebulae
.nebula-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  transition: transform 0.2s ease-out;
}

.nebula {
  position: absolute;
  border-radius: 50%;
  filter: blur(150px);
  opacity: 0.2;
  mix-blend-mode: screen;
}

.nebula-1 {
  width: 80vw;
  height: 60vw;
  top: -10vw;
  left: -10vw;
  background: radial-gradient(circle, rgba(140, 50, 255, 0.3) 0%, transparent 70%);
  animation: drift 60s linear infinite alternate;
}

.nebula-2 {
  width: 70vw;
  height: 50vw;
  bottom: -20vw;
  right: -10vw;
  background: radial-gradient(circle, rgba(50, 100, 255, 0.2) 0%, transparent 70%);
  animation: drift 45s linear infinite alternate-reverse;
}

@keyframes drift {
  from { transform: translate(-2vw, -1vw) rotate(0deg); }
  to { transform: translate(2vw, 1vw) rotate(5deg); }
}

// ============= REALISTIC SUN =============
.solar-system {
  position: absolute;
  top: 10%;
  right: 15%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.2s linear; // Linear or faster ease for motion
}

.sun-core {
  width: 130px;
  height: 130px;
  border-radius: 50%;
  background: radial-gradient(circle at center, #fff 0%, #fffde0 30%, #ffd000 60%, #ff8c00 100%);
  box-shadow: 
    0 0 60px rgba(255, 200, 50, 0.9),
    0 0 120px rgba(255, 100, 0, 0.4);
  position: relative;
  z-index: 3;
}

.sun-flare {
  position: absolute;
  width: 400%;
  height: 2px;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transform: rotate(-15deg);
  pointer-events: none;
  z-index: 4;
  &::before {
    content: '';
    position: absolute;
    width: 2px;
    height: 400%;
    top: -200%;
    left: 50%;
    background: linear-gradient(180deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  }
}

.sun-corona {
  position: absolute;
  width: 180px;
  height: 180px;
  border-radius: 50%;
  background: radial-gradient(circle at center, rgba(255, 180, 50, 0.5) 0%, transparent 75%);
  animation: sun-vibrate 8s linear infinite;
  z-index: 2;
}

.sun-glow {
  position: absolute;
  width: 800px;
  height: 800px;
  background: radial-gradient(circle at center, rgba(255, 120, 30, 0.12) 0%, rgba(255, 60, 10, 0.03) 45%, transparent 70%);
  mix-blend-mode: screen;
  z-index: 1;
}

@keyframes sun-vibrate {
  0% { transform: scale(1) rotate(0deg); opacity: 0.8; }
  50% { transform: scale(1.15) rotate(180deg); opacity: 1; }
  100% { transform: scale(1) rotate(360deg); opacity: 0.8; }
}

// ============= PLANETS =============
.planet-container {
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.2s linear;
  
  // First Planet (Blue)
  &:not(.planet-2) {
    bottom: 20%;
    left: 10%;
    width: 220px;
    height: 220px;
  }

  // Second Planet (Rust/Orange)
  &.planet-2 {
    top: 25%;
    left: 15%;
    width: 100px;
    height: 100px;
    z-index: 1;
  }

  // Planet Earth
  &.earth-container {
    bottom: 15%;
    left: 8%;
    width: 200px;
    height: 200px;
    z-index: 5;
  }
}

.planet-body {
  border-radius: 50%;
  position: relative;
  overflow: hidden;
  box-shadow: 0 0 50px rgba(0, 0, 0, 0.4);

  &:not(.planet-2-body):not(.earth-body) {
    width: 160px;
    height: 160px;
    background: radial-gradient(circle at 30% 30%, #4b6cb7 0%, #182848 100%);
    box-shadow: inset -30px -30px 60px rgba(0, 0, 0, 0.9);
  }

  &.planet-2-body {
    width: 80px;
    height: 80px;
    background: radial-gradient(circle at 30% 30%, #e67e22 0%, #8e44ad 100%);
    box-shadow: inset -15px -15px 30px rgba(0, 0, 0, 0.9);
  }

  &.earth-body {
    width: 200px;
    height: 200px;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
  }
}

.planet-rings {
  position: absolute;
  width: 320px;
  height: 80px;
  border-radius: 50%;
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: linear-gradient(90deg, transparent 0%, rgba(255, 255, 255, 0.08) 50%, transparent 100%);
  transform: rotateX(75deg);
  z-index: -1;
}

@keyframes planet-pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.02); }
}

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
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.3s ease;
  
  svg { width: 18px; height: 18px; }
  
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
  
  &:hover, &.active { color: #fff; }
  &.active { color: #ff8c32; }
}

.lang-toggle {
  font-size: 0.85rem;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 0.5rem 1rem;
  color: rgba(255, 255, 255, 0.7);
  cursor: pointer;
  display: flex;
  gap: 0.3rem;
  
  span.active { color: #ff8c32; font-weight: 600; }
  .separator { color: rgba(255, 255, 255, 0.3); }
}

.content {
  position: relative;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  padding: 100px 2rem 2rem;
}

// ============= GLASS TERMINAL STYLES =============
.glass-workstation {
  transition: transform 0.2s ease-out;
  transform-style: preserve-3d;
  width: 90%;
  max-width: 1100px;
}

.terminal-container {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2px;
  transform-style: preserve-3d;
}

.terminal-glow {
  position: absolute;
  top: -150px;
  left: -150px;
  right: -150px;
  bottom: -150px;
  background: radial-gradient(circle at center, rgba(138, 43, 226, 0.15) 0%, rgba(65, 105, 225, 0.08) 40%, transparent 70%);
  filter: blur(60px);
  pointer-events: none;
  z-index: -1;
  transition: opacity 0.3s ease;
}

// Animated corners for the sci-fi look
.frame-edge {
  position: absolute;
  width: 40px;
  height: 40px;
  border: 2px solid rgba(255, 140, 50, 0.4);
  z-index: 10;
  
  &.top-left { top: -10px; left: -10px; border-right: none; border-bottom: none; border-radius: 4px 0 0 0; }
  &.top-right { top: -10px; right: -10px; border-left: none; border-bottom: none; border-radius: 0 4px 0 0; }
  &.bottom-left { bottom: -10px; left: -10px; border-right: none; border-top: none; border-radius: 0 0 0 4px; }
  &.bottom-right { bottom: -10px; right: -10px; border-left: none; border-top: none; border-radius: 0 0 4px 0; }
  
  &::after {
    content: '';
    position: absolute;
    width: 6px;
    height: 6px;
    background: #ff8c32;
    border-radius: 50%;
    box-shadow: 0 0 10px #ff8c32;
  }
  
  &.top-left::after { top: -3px; left: -3px; }
  &.top-right::after { top: -3px; right: -3px; }
  &.bottom-left::after { bottom: -3px; left: -3px; }
  &.bottom-right::after { bottom: -3px; right: -3px; }
}

.glass-display {
  width: 100%;
  height: 650px;
  background: rgba(10, 10, 15, 0.65);
  backdrop-filter: blur(30px) saturate(180%);
  -webkit-backdrop-filter: blur(30px) saturate(180%);
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 20px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transform-style: preserve-3d;
  box-shadow: 
    0 25px 80px rgba(0, 0, 0, 0.6),
    inset 0 0 0 1px rgba(255, 255, 255, 0.05);
}

.display-header {
  height: 44px;
  background: rgba(255, 255, 255, 0.04);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 1.5rem;
  flex-shrink: 0;
}

.status-dots {
  display: flex;
  gap: 8px;
  .dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    &:nth-child(1) { background: #ff5f56; }
    &:nth-child(2) { background: #ffbd2e; }
    &:nth-child(3) { background: #27c93f; }
  }
}

.terminal-id {
  font-family: 'Fira Code', monospace;
  font-size: 0.75rem;
  color: rgba(255, 255, 255, 0.4);
  font-weight: 500;
  letter-spacing: 1px;
}

.display-reflection {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 50%;
  background: linear-gradient(
    135deg,
    rgba(255, 255, 255, 0.04) 0%,
    rgba(255, 255, 255, 0.01) 30%,
    transparent 60%
  );
  pointer-events: none;
  z-index: 0;
}

.terminal-content {
  position: relative;
  z-index: 10;
  flex: 1;
  overflow-y: scroll;
  overflow-x: hidden;
  scrollbar-width: none;
  scroll-behavior: smooth;
  -webkit-overflow-scrolling: touch;
  transform-style: preserve-3d;
  &::-webkit-scrollbar { display: none; }
}

.screen-section {
  padding: 2rem 2.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  
  &:last-child {
    border-bottom: none;
  }
}

// Hero Section
.hero-section {
  min-height: calc(100% - 4rem);
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
}

.greeting {
  font-size: 1rem;
  color: rgba(255, 255, 255, 0.6);
  margin-bottom: 0.5rem;
  font-family: 'Fira Code', monospace;
}

.name {
  font-size: 2.2rem;
  font-weight: 700;
  background: linear-gradient(135deg, #fff 0%, #ff8c32 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  margin-bottom: 0.5rem;
}

.role {
  font-size: 1.1rem;
  color: #ff8c32;
  margin-bottom: 1.5rem;
  font-weight: 500;
}

.bio {
  font-size: 0.95rem;
  color: rgba(255, 255, 255, 0.7);
  line-height: 1.7;
  max-width: 500px;
  margin: 0 auto 2rem;
}

.scroll-indicator {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  color: rgba(255, 255, 255, 0.4);
  font-size: 0.8rem;
  animation: bounce 2s infinite;
  
  svg {
    width: 20px;
    height: 20px;
  }
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(8px); }
}

// Section Title
.section-title {
  font-size: 1.4rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  color: #fff;
  display: flex;
  align-items: center;
  gap: 0.75rem;
  
  &::before {
    content: '';
    width: 4px;
    height: 24px;
    background: linear-gradient(180deg, #ff8c32, #ff6432);
    border-radius: 2px;
  }
}

// Passion Link
.passion-link {
  color: #ff8c32;
  text-decoration: none;
  font-weight: 500;
  transition: all 0.2s ease;
  
  &:hover {
    color: #ffab5c;
    text-decoration: underline;
  }
}

// Skills Section
.skills-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.5rem;
}

.skill-category {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  padding: 1rem;
}

.skill-category-title {
  font-size: 0.85rem;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.8);
  margin-bottom: 0.75rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  
  svg {
    width: 16px;
    height: 16px;
    color: #ff8c32;
  }
}

.skill-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.skill-tag {
  font-size: 0.75rem;
  font-family: 'Fira Code', monospace;
  padding: 0.3rem 0.6rem;
  background: rgba(255, 140, 50, 0.15);
  border: 1px solid rgba(255, 140, 50, 0.3);
  border-radius: 6px;
  color: #ffb366;
}

// Timeline Styles
.timeline {
  position: relative;
  padding-left: 1.5rem;
  
  &::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    width: 2px;
    background: linear-gradient(180deg, #ff8c32, rgba(255, 100, 50, 0.3));
    border-radius: 1px;
  }
}

.timeline-item {
  position: relative;
  padding-bottom: 1.5rem;
  
  &:last-child {
    padding-bottom: 0;
  }
}

.timeline-dot {
  position: absolute;
  left: -1.5rem;
  top: 0.25rem;
  width: 10px;
  height: 10px;
  background: #ff8c32;
  border-radius: 50%;
  transform: translateX(-50%);
  box-shadow: 0 0 10px rgba(255, 140, 50, 0.5);
}

.timeline-content {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  padding: 1rem;
}

.timeline-title {
  font-size: 1rem;
  font-weight: 600;
  color: #fff;
  margin-bottom: 0.25rem;
}

.timeline-company {
  font-size: 0.9rem;
  color: #ff8c32;
  margin-bottom: 0.25rem;
}

.timeline-period {
  font-size: 0.75rem;
  font-family: 'Fira Code', monospace;
  color: rgba(255, 255, 255, 0.5);
  padding: 0.2rem 0.5rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 4px;
  display: inline-block;
  margin-bottom: 0.5rem;
}

.timeline-description {
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.6);
  line-height: 1.5;
}

// CTA Section
.cta-section {
  display: flex;
  justify-content: center;
  padding: 2.5rem;
}

.cta-button {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.875rem 2rem;
  background: linear-gradient(135deg, #ff8c32, #ff6432);
  border: none;
  border-radius: 50px;
  color: #fff;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 8px 30px rgba(255, 100, 50, 0.3);
  position: relative;
  z-index: 20;
  
  svg {
    width: 18px;
    height: 18px;
    transition: transform 0.3s ease;
  }
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 40px rgba(255, 100, 50, 0.4);
    
    svg {
      transform: translateX(4px);
    }
  }
}

// Responsive
@media (max-width: 1100px) {
  .glass-display {
    height: 550px;
  }
}

@media (max-width: 900px) {
  .glass-workstation {
    width: 95%;
  }

  .glass-display {
    height: 500px;
  }
  
  .skills-grid {
    grid-template-columns: 1fr;
  }
  
  .name {
    font-size: 1.8rem;
  }
}

@media (max-width: 768px) {
  .navbar { padding: 1rem 1.5rem; }
  .nav-links { display: none; }
  
  .content {
    padding: 80px 0.5rem 1rem;
  }

  .glass-display {
    height: 480px;
    border-radius: 12px;
  }

  .frame-edge {
    width: 25px;
    height: 25px;
  }
  
  .screen-section {
    padding: 1.25rem;
  }
  
  .name {
    font-size: 1.5rem;
  }
  
  .bio {
    font-size: 0.85rem;
  }
}
</style>
