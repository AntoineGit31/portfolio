<script setup>
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import Carousel3D from '../components/Carousel3D.vue';

const router = useRouter();
const currentLang = ref('fr');

// Project data
const projects = [
  {
    image: '/img/img01.png',
    title: 'CSV Visualiser',
    description: {
      fr: 'Site web de visualisation de fichiers CSV : filtres avancés et interface intuitive, plus simple qu\'Excel.',
      en: 'CSV file visualization website with advanced filters and intuitive interface, simpler than Excel.'
    }
  },
  {
    image: '/img/img02.png',
    title: 'ApplyFlow',
    description: {
      fr: 'Outil de prospection automatisé pour la recherche professionnelle (CDI, stages, alternances...).',
      en: 'Automated prospecting tool for professional job search (full-time, internships, apprenticeships...).'
    }
  },
  {
    image: '/img/img03.png',
    title: 'PerfTracker',
    description: {
      fr: 'Application web mobile pour suivre ses performances en musculation au fil du temps.',
      en: 'Mobile web application to track weight training performances over time.'
    }
  },
  {
    image: '/img/img04.png',
    title: 'CSV Analyst',
    description: {
      fr: 'Lecteur CSV avec nettoyage automatique, génération de graphiques, filtres et export des données.',
      en: 'CSV reader with automatic cleaning, chart generation, filters and data export.'
    }
  },
  {
    image: '/img/img05.png',
    title: 'LoL Draft Predictor',
    description: {
      fr: 'Prédicteur in-game pour League of Legends basé sur le machine learning.',
      en: 'In-game League of Legends predictor based on machine learning.'
    }
  },
  {
    image: '/img/img06.png',
    title: 'Smart Contract Scanner',
    description: {
      fr: 'Outil d\'analyse de sécurité pour les smart contracts en Solidity (cryptomonnaies, ETH).',
      en: 'Security analysis tool for smart contracts in Solidity (cryptocurrencies, ETH).'
    }
  }
];

const translations = {
  fr: {
    title: 'Projets',
    subtitle: 'Faites glisser ou scrollez pour explorer',
    viewProject: 'Voir ce projet',
    backHome: 'Retour',
    home: 'Accueil',
    projects: 'Projets',
    about: 'À propos',
    contact: 'Contact',
  },
  en: {
    title: 'Projects',
    subtitle: 'Drag or scroll to explore',
    viewProject: 'View project',
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

function handleCardClick(index) {
  router.push(`/project/${index}`);
}
</script>

<template>
  <div class="page">
    <!-- Navbar -->
    <nav class="navbar">
      <button class="shiny-cta" @click="goHome">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M19 12H5M12 19l-7-7 7-7"/>
        </svg>
        <span>{{ t.backHome }}</span>
      </button>
      <div class="nav-links">
        <router-link to="/" class="nav-link">{{ t.home }}</router-link>
        <router-link to="/projects" class="nav-link active">{{ t.projects }}</router-link>
        <router-link to="/about" class="nav-link">{{ t.about }}</router-link>
        <router-link to="/contact" class="nav-link">{{ t.contact }}</router-link>
      </div>
      <button class="lang-toggle" @click="toggleLanguage">
        <span :class="{ active: currentLang === 'fr' }">FR</span>
        <span class="separator">/</span>
        <span :class="{ active: currentLang === 'en' }">EN</span>
      </button>
    </nav>
    
    <!-- Header overlay -->
    <header class="header-overlay">
      <h1 class="title">{{ t.title }}</h1>
      <p class="subtitle">{{ t.subtitle }}</p>
    </header>
    
    <!-- 3D Carousel -->
    <div class="carousel-container">
      <Carousel3D :projects="projects" :lang="currentLang" :viewProjectText="t.viewProject" @cardClick="handleCardClick" />
    </div>
  </div>
</template>

<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

.page {
  min-height: 100vh;
  width: 100%;
  position: relative;
  font-family: 'Inter', sans-serif;
  color: #fff;
  overflow: hidden;
  background: transparent;
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
  background: rgba(0, 0, 0, 0.4);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
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

.header-overlay {
  position: fixed;
  top: 100px;
  left: 0;
  right: 0;
  z-index: 50;
  text-align: center;
  pointer-events: none;
}

.title {
  font-size: 3rem;
  font-weight: 700;
  background: linear-gradient(135deg, #fff 0%, #ff8c32 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  margin: 0 0 0.5rem 0;
  text-shadow: 0 4px 30px rgba(255, 140, 50, 0.3);
}

.subtitle {
  font-size: 1rem;
  color: rgba(255, 255, 255, 0.6);
  margin: 0;
}

.carousel-container {
  position: fixed;
  inset: 0;
  z-index: 1;
}

@media (max-width: 768px) {
  .navbar { padding: 1rem 1.5rem; }
  .nav-links { display: none; }
  
  .header-overlay {
    top: 80px;
  }
  
  .title {
    font-size: 2rem;
  }
  
  .subtitle {
    font-size: 0.9rem;
  }
}
</style>
