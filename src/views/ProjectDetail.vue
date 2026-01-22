<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import CosmicBackground from '../components/CosmicBackground.vue';

const router = useRouter();
const route = useRoute();
const currentLang = ref('fr');

// Get project ID from route
const projectId = computed(() => route.params.id);

// Project data
const projectsData = {
  'csv-visualiser': {
    id: 'csv-visualiser',
    title: 'DataView Pro',
    subtitle: {
      fr: 'Application web de visualisation de données',
      en: 'Web-based data visualization application'
    },
    description: {
      fr: `DataView Pro est une application web moderne et performante permettant de visualiser, filtrer et exporter des fichiers de données tabulaires (CSV et Excel). Conçue pour fonctionner entièrement côté client sans aucun serveur backend, elle offre une expérience utilisateur fluide et intuitive pour manipuler des données volumineuses directement dans le navigateur.

Ce projet répond à un besoin concret : pouvoir rapidement ouvrir, explorer et filtrer des fichiers de données sans avoir à installer de logiciel lourd comme Excel ou des outils payants. L'application est accessible en un double-clic grâce à un lanceur Windows intégré.`,
      en: `DataView Pro is a modern and high-performance web application for visualizing, filtering, and exporting tabular data files (CSV and Excel). Designed to work entirely client-side without any backend server, it offers a smooth and intuitive user experience for handling large datasets directly in the browser.

This project addresses a concrete need: being able to quickly open, explore, and filter data files without installing heavy software like Excel or paid tools. The application is accessible with a double-click thanks to an integrated Windows launcher.`
    },
    technologies: ['HTML5', 'CSS3', 'JavaScript ES6+', 'PapaParse', 'SheetJS', 'Remix Icon'],
    features: {
      fr: [
        'Import multi-formats (CSV, XLSX, XLS)',
        'Système de filtrage avancé (9 opérateurs)',
        'Recherche globale avec surlignage',
        'Tri intelligent des colonnes',
        'Exclusion temporaire de lignes',
        'Modale de détail cellule',
        'Pagination configurable',
        'Export CSV/Excel/Presse-papier',
        'Thème clair/sombre persistant',
        'Statistiques automatiques',
        'Lanceur Windows one-click'
      ],
      en: [
        'Multi-format import (CSV, XLSX, XLS)',
        'Advanced filtering system (9 operators)',
        'Global search with highlighting',
        'Intelligent column sorting',
        'Temporary row exclusion',
        'Cell detail modal',
        'Configurable pagination',
        'CSV/Excel/Clipboard export',
        'Persistent light/dark theme',
        'Automatic statistics',
        'Windows one-click launcher'
      ]
    },
    images: ['/img/dataview-01.png', '/img/dataview-02.png'],
    color: '#6366f1',
    year: '2025',
    // Extended content sections
    sections: {
      fr: [
        {
          title: 'Stack Technique',
          icon: 'tools',
          content: `L'application utilise une stack moderne et légère, optimisée pour les performances côté client.`,
          table: {
            headers: ['Technologie', 'Version', 'Utilisation'],
            rows: [
              ['HTML5', '-', 'Structure sémantique de l\'application'],
              ['CSS3', '-', 'Styling avancé avec variables CSS et dark mode'],
              ['JavaScript ES6+', '-', 'Logique applicative orientée objet'],
              ['PapaParse', '5.4.1', 'Parser CSV robuste gérant les edge cases'],
              ['SheetJS', '0.18.5', 'Lecture et écriture des fichiers Excel'],
              ['Remix Icon', '3.5.0', 'Bibliothèque d\'icônes modernes']
            ]
          }
        },
        {
          title: 'Architecture',
          icon: 'structure',
          content: `L'application suit une architecture Single Page Application (SPA) légère avec une classe JavaScript unique encapsulant toute la logique. Le système utilise des Design Tokens via CSS Custom Properties pour une maintenance facilitée et un pattern Observer pour la gestion des événements. Aucune dépendance framework : vanilla JavaScript pour des performances optimales.`,
          image: '/img/dataview-05.png',
          imageSize: 'small',
          imageCaption: "Bouton d'action"
        },
        {
          title: 'Design Tokens CSS',
          icon: 'palette',
          content: `Le système de design utilise des variables CSS pour une cohérence visuelle et une maintenance simplifiée.`,
          codeBlock: {
            language: 'css',
            code: `:root {
    /* Couleurs de fond */
    --bg-primary: #f8fafc;
    --bg-secondary: #ffffff;
    --bg-tertiary: #f1f5f9;
    
    /* Couleurs d'accent */
    --accent-primary: #6366f1;
    --accent-secondary: #8b5cf6;
    --accent-gradient: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    
    /* Couleurs sémantiques */
    --success: #10b981;
    --warning: #f59e0b;
    --danger: #ef4444;
}

/* Dark Mode Override */
[data-theme="dark"] {
    --bg-primary: #0f172a;
    --bg-secondary: #1e293b;
    --text-primary: #f1f5f9;
}`
          }
        },
        {
          title: 'Structure de la Classe JavaScript',
          icon: 'code',
          content: `L'application est structurée autour d'une classe principale DataViewApp qui gère l'ensemble de la logique.`,
          codeBlock: {
            language: 'javascript',
            code: `class DataViewApp {
    constructor() {
        this.rawData = [];           // Données brutes importées
        this.filteredData = [];      // Données après filtrage
        this.headers = [];           // Noms des colonnes
        this.filters = [];           // Filtres actifs
        this.excludedRows = new Set(); // Lignes exclues
        
        this.currentPage = 1;
        this.rowsPerPage = 100;
        this.sortColumn = null;
        this.sortDirection = 'asc';
        this.init();
    }

    // Gestion des fichiers
    handleFileSelect(e) { /* ... */ }
    parseCSV(file) { /* PapaParse */ }
    parseExcel(file) { /* SheetJS */ }
    
    // Manipulation des données
    applyFilters() { /* Filtres + recherche */ }
    sortData() { /* Tri intelligent */ }
    
    // Export
    exportCSV() { /* Via PapaParse */ }
    exportExcel() { /* Via SheetJS */ }
}`
          }
        },
        {
          title: 'Système de Filtrage',
          icon: 'filter',
          content: `Le cœur de l'application réside dans son système de filtres puissant avec 9 opérateurs disponibles. Les filtres sont cumulables avec une logique ET.`,
          table: {
            headers: ['Opérateur', 'Description', 'Exemple'],
            rows: [
              ['Contient', 'Recherche une sous-chaîne', 'Département contient "Data"'],
              ['Égal à', 'Correspondance exacte', 'Poste = "Data Scientist"'],
              ['Commence par', 'Préfixe de la valeur', 'Nom commence par "Dup"'],
              ['Finit par', 'Suffixe de la valeur', 'Email finit par "@gmail.com"'],
              ['Ne contient pas', 'Exclusion', 'Département ne contient pas "RH"'],
              ['Supérieur à', 'Comparaison numérique', 'Salaire > 50000'],
              ['Inférieur à', 'Comparaison numérique', 'Salaire < 45000'],
              ['Est vide', 'Cellule vide', 'Notes est vide'],
              ['N\'est pas vide', 'Cellule remplie', 'Email n\'est pas vide']
            ]
          },
          image: '/img/dataview-03.png',
          imageSize: 'small',
          imageCaption: 'Interface de création de filtre'
        },
        {
          title: 'Détail de cellule',
          icon: 'download',
          content: `L'application permet de visualiser en détail le contenu d'une cellule par un simple clic, facilitant la lecture de textes longs ou de données complexes.`,
          image: '/img/dataview-04.png',
          imageSize: 'medium',
          imageCaption: 'Visualisation détaillée d\'une cellule'
        },
        {
          title: 'Points Forts',
          icon: 'star',
          content: null,
          highlights: [
            { title: 'Zero backend', description: 'Fonctionne entièrement dans le navigateur, aucune donnée envoyée à un serveur' },
            { title: 'Performances', description: 'Gestion efficace de fichiers volumineux grâce à la pagination' },
            { title: 'UX moderne', description: 'Interface intuitive avec glassmorphism et dark mode' },
            { title: 'Portabilité', description: 'Simple dossier à copier, fonctionne sur n\'importe quel PC Windows' },
            { title: 'Code maintenable', description: 'Architecture objet claire, CSS modulaire avec variables' }
          ]
        },
        {
          title: 'Structure du Projet',
          icon: 'folder',
          content: null,
          codeBlock: {
            language: 'text',
            code: `DataView Pro/
├── index.html          # Structure HTML de l'application
├── app.js              # Logique JavaScript (classe DataViewApp)
├── styles.css          # Feuille de styles complète
├── Lancer DataView.bat # Script de lancement Windows
└── exemple_donnees.csv # Fichier d'exemple pour démonstration`
          }
        }
      ],
      en: [
        {
          title: 'Technical Stack',
          icon: 'tools',
          content: `The application uses a modern and lightweight stack, optimized for client-side performance.`,
          table: {
            headers: ['Technology', 'Version', 'Usage'],
            rows: [
              ['HTML5', '-', 'Semantic application structure'],
              ['CSS3', '-', 'Advanced styling with CSS variables and dark mode'],
              ['JavaScript ES6+', '-', 'Object-oriented application logic'],
              ['PapaParse', '5.4.1', 'Robust CSV parser handling edge cases'],
              ['SheetJS', '0.18.5', 'Excel file reading and writing'],
              ['Remix Icon', '3.5.0', 'Modern icon library']
            ]
          }
        },
        {
          title: 'Architecture',
          icon: 'structure',
          content: `The application follows a lightweight Single Page Application (SPA) architecture with a single JavaScript class encapsulating all logic. The system uses Design Tokens via CSS Custom Properties for easier maintenance and an Observer pattern for event handling. No framework dependency: vanilla JavaScript for optimal performance.`,
          image: '/img/dataview-05.png',
          imageSize: 'small',
          imageCaption: 'Action button'
        },
        {
          title: 'CSS Design Tokens',
          icon: 'palette',
          content: `The design system uses CSS variables for visual consistency and simplified maintenance.`,
          codeBlock: {
            language: 'css',
            code: `:root {
    /* Background colors */
    --bg-primary: #f8fafc;
    --bg-secondary: #ffffff;
    --bg-tertiary: #f1f5f9;
    
    /* Accent colors */
    --accent-primary: #6366f1;
    --accent-secondary: #8b5cf6;
    --accent-gradient: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    
    /* Semantic colors */
    --success: #10b981;
    --warning: #f59e0b;
    --danger: #ef4444;
}

/* Dark Mode Override */
[data-theme="dark"] {
    --bg-primary: #0f172a;
    --bg-secondary: #1e293b;
    --text-primary: #f1f5f9;
}`
          }
        },
        {
          title: 'JavaScript Class Structure',
          icon: 'code',
          content: `The application is structured around a main DataViewApp class that manages all the logic.`,
          codeBlock: {
            language: 'javascript',
            code: `class DataViewApp {
    constructor() {
        this.rawData = [];           // Imported raw data
        this.filteredData = [];      // Data after filtering
        this.headers = [];           // Column names
        this.filters = [];           // Active filters
        this.excludedRows = new Set(); // Excluded rows
        
        this.currentPage = 1;
        this.rowsPerPage = 100;
        this.sortColumn = null;
        this.sortDirection = 'asc';
        this.init();
    }

    // File handling
    handleFileSelect(e) { /* ... */ }
    parseCSV(file) { /* PapaParse */ }
    parseExcel(file) { /* SheetJS */ }
    
    // Data manipulation
    applyFilters() { /* Filters + search */ }
    sortData() { /* Smart sorting */ }
    
    // Export
    exportCSV() { /* Via PapaParse */ }
    exportExcel() { /* Via SheetJS */ }
}`
          }
        },
        {
          title: 'Filtering System',
          icon: 'filter',
          content: `The core of the application lies in its powerful filtering system with 9 available operators. Filters are cumulative with AND logic.`,
          table: {
            headers: ['Operator', 'Description', 'Example'],
            rows: [
              ['Contains', 'Search for substring', 'Department contains "Data"'],
              ['Equals', 'Exact match', 'Position = "Data Scientist"'],
              ['Starts with', 'Value prefix', 'Name starts with "Dup"'],
              ['Ends with', 'Value suffix', 'Email ends with "@gmail.com"'],
              ['Does not contain', 'Exclusion', 'Department does not contain "HR"'],
              ['Greater than', 'Numeric comparison', 'Salary > 50000'],
              ['Less than', 'Numeric comparison', 'Salary < 45000'],
              ['Is empty', 'Empty cell', 'Notes is empty'],
              ['Is not empty', 'Filled cell', 'Email is not empty']
            ]
          },
          image: '/img/dataview-03.png',
          imageSize: 'small',
          imageCaption: 'Filter creation interface'
        },
        {
          title: 'Cell Detail',
          icon: 'download',
          content: `The application allows you to view the content of a cell in detail with a simple click, making it easier to read long texts or complex data.`,
          image: '/img/dataview-04.png',
          imageSize: 'medium',
          imageCaption: 'Detailed cell visualization'
        },
        {
          title: 'Key Strengths',
          icon: 'star',
          content: null,
          highlights: [
            { title: 'Zero backend', description: 'Works entirely in the browser, no data sent to any server' },
            { title: 'Performance', description: 'Efficient handling of large files through pagination' },
            { title: 'Modern UX', description: 'Intuitive interface with glassmorphism and dark mode' },
            { title: 'Portability', description: 'Simple folder to copy, works on any Windows PC' },
            { title: 'Maintainable code', description: 'Clear object architecture, modular CSS with variables' }
          ]
        },
        {
          title: 'Project Structure',
          icon: 'folder',
          content: null,
          codeBlock: {
            language: 'text',
            code: `DataView Pro/
├── index.html          # Application HTML structure
├── app.js              # JavaScript logic (DataViewApp class)
├── styles.css          # Complete stylesheet
├── Launch DataView.bat # Windows launch script
└── sample_data.csv     # Sample file for demonstration`
          }
        }
      ]
    }
  },
  'applyflow': {
    id: 'applyflow',
    title: 'ApplyFlow',
    subtitle: {
      fr: 'Outil de Prospection Automatisée',
      en: 'Automated Prospecting Tool'
    },
    description: {
      fr: `ApplyFlow est une application web complète que j'ai développée de A à Z pour automatiser et optimiser ma recherche de stage. Face à l'inefficacité des plateformes d'emploi traditionnelles (plus de 100 candidatures sans retour), j'ai créé cet outil qui permet de prospecter directement auprès des entreprises, de découvrir leurs contacts, de générer des emails personnalisés et de les envoyer via Gmail — le tout avec une validation humaine obligatoire à chaque étape.

Les plateformes d'emploi comme LinkedIn, Indeed ou Welcome to the Jungle sont saturées. Les candidatures se perdent parmi des centaines d'autres, et le taux de réponse est extrêmement faible. Les candidatures spontanées par email ont un bien meilleur taux de conversion, mais elles demandent un travail manuel considérable.

ApplyFlow automatise toute cette chaîne de prospection tout en gardant l'humain au centre du processus. L'outil recherche, analyse, génère et propose — mais c'est toujours moi qui valide et approuve avant tout envoi. Cette approche "Human-in-the-Loop" garantit la qualité et la pertinence de chaque candidature.`,
      en: `ApplyFlow is a complete web application I developed from scratch to automate and optimize my internship search. Facing the inefficiency of traditional job platforms (over 100 applications without response), I created this tool that allows prospecting directly with companies, discovering their contacts, generating personalized emails and sending them via Gmail — all with mandatory human validation at each step.

Job platforms like LinkedIn, Indeed or Welcome to the Jungle are saturated. Applications get lost among hundreds of others, and the response rate is extremely low. Spontaneous email applications have a much better conversion rate, but they require considerable manual work.

ApplyFlow automates this entire prospecting chain while keeping humans at the center of the process. The tool searches, analyzes, generates and proposes — but I always validate and approve before any sending. This "Human-in-the-Loop" approach guarantees the quality and relevance of each application.`
    },
    technologies: ['Python 3.11', 'FastAPI', 'Next.js 14', 'PostgreSQL', 'Redis', 'Celery', 'Docker', 'TypeScript', 'Gmail API', 'BeautifulSoup'],
    features: {
      fr: [
        'Recherche intelligente d\'entreprises',
        'Découverte automatique de contacts',
        'Génération d\'emails personnalisés',
        'Interface de validation Human-in-the-Loop',
        'Envoi groupé intelligent avec délai anti-spam',
        'Dashboard et statistiques en temps réel',
        'Détection automatique des réponses et bounces',
        'Journal d\'audit complet (RGPD)',
        'Import CSV et gestion des doublons',
        'Mode sombre / clair'
      ],
      en: [
        'Intelligent company search',
        'Automatic contact discovery',
        'Personalized email generation',
        'Human-in-the-Loop validation interface',
        'Smart batch sending with anti-spam delay',
        'Real-time dashboard and statistics',
        'Automatic response and bounce detection',
        'Complete audit log (GDPR)',
        'CSV import and duplicate management',
        'Dark / light mode'
      ]
    },
    images: ['/img/applyflow-01.png', '/img/applyflow-05.png'],
    color: '#D4A574',
    year: '2026',
    demoVideo: 'https://youtu.be/JCWBwvvsNbA',
    hideScreenshots: true,
    sections: {
      fr: [
        {
          title: 'Recherche Intelligente d\'Entreprises',
          icon: 'filter',
          content: `L'outil permet de lancer des recherches ciblées par localisation (ville, département ou région), secteur d'activité (Data, Tech, Consulting, etc.) et mots-clés spécifiques. Chaque entreprise trouvée est analysée et reçoit un score de pertinence basé sur sa maturité data, la présence de termes techniques sur son site, et d'autres critères.`,
          image: '/img/applyflow-02.png',
          imageSize: 'large',
          imageCaption: 'Interface de recherche avec filtres avancés'
        },
        {
          title: 'Découverte Automatique de Contacts',
          icon: 'robot',
          content: `Une fois les entreprises identifiées, ApplyFlow part à la recherche des contacts pertinents grâce à plusieurs techniques complémentaires.`,
          table: {
            headers: ['Technique', 'Description'],
            rows: [
              ['Crawling intelligent', 'Analyse des pages "Contact", "Équipe", "À propos", "Carrières"'],
              ['Extraction de PDFs', 'Détection d\'emails dans les documents PDF accessibles'],
              ['Analyse des sitemaps', 'Exploration exhaustive de la structure du site'],
              ['Intégration Hunter.io', 'Vérification et enrichissement des emails professionnels'],
              ['Validation', 'Vérification de l\'existence réelle de chaque adresse email']
            ]
          },
          image: '/img/applyflow-03.png',
          imageSize: 'large',
          imageCaption: 'Découverte et validation des contacts'
        },
        {
          title: 'Génération d\'Emails Personnalisés',
          icon: 'code',
          content: `Chaque email est généré automatiquement en fonction du nom de l'entreprise et son secteur, des informations collectées sur le site, et d'un template personnalisable. Les emails incluent automatiquement une accroche adaptée au contexte, une présentation succincte du profil et une phrase d'opt-out RGPD obligatoire.`,
          image: '/img/applyflow-04.png',
          imageSize: 'large',
          imageCaption: 'Génération d\'email personnalisé'
        },
        {
          title: 'Interface de Validation (Human-in-the-Loop)',
          icon: 'star',
          content: `C'est le cœur de l'application. Chaque brouillon passe par une étape de validation obligatoire avec prévisualisation de l'email tel qu'il sera reçu, possibilité d'édition du contenu, score de qualité avec indicateurs visuels sur la personnalisation, et actions disponibles : Approuver, Rejeter, ou Marquer "À rechercher". Rien ne part sans approbation explicite.`,
          image: '/img/applyflow-05.png',
          imageSize: 'large',
          imageCaption: 'Interface de validation des brouillons'
        },
        {
          title: 'Envoi Groupé Intelligent',
          icon: 'list',
          content: `Une fois les emails approuvés, l'envoi se fait de manière contrôlée avec une file d'attente visuelle pour le suivi en temps réel, un délai anti-spam configurable entre chaque email (60-180 secondes), une pièce jointe automatique (CV en PDF), et une authentification OAuth2 sécurisée à Gmail.`,
          image: '/img/applyflow-06.png',
          imageSize: 'large',
          imageCaption: 'File d\'attente d\'envoi avec suivi temps réel'
        },
        {
          title: 'Dashboard et Statistiques',
          icon: 'chart',
          content: `Un tableau de bord complet pour suivre l'avancement de la prospection avec des compteurs en temps réel (emails envoyés, en attente, réponses reçues), des graphiques d'évolution des envois dans le temps, des métriques de performance par campagne et des alertes pour les réponses et les bounces.`,
          image: '/img/applyflow-07.png',
          imageSize: 'large',
          imageCaption: 'Dashboard avec métriques de performance'
        },
        {
          title: 'Journal d\'Audit Complet',
          icon: 'folder',
          content: `Pour la conformité RGPD et le suivi des actions, l'application maintient une traçabilité totale où chaque action est enregistrée (création, modification, envoi), avec un horodatage précis et un historique consultable avec filtrage par type d'action ou par entité.`,
          image: '/img/applyflow-08.png',
          imageSize: 'large',
          imageCaption: 'Journal d\'audit pour conformité RGPD'
        },
        {
          title: 'Stack Technique Backend',
          icon: 'tools',
          content: `Le backend est construit sur une architecture moderne et performante avec Python et FastAPI.`,
          table: {
            headers: ['Technologie', 'Version', 'Rôle'],
            rows: [
              ['Python', '3.11', 'Langage principal'],
              ['FastAPI', '-', 'Framework API REST haute performance'],
              ['SQLAlchemy', '-', 'ORM pour la gestion de la base de données'],
              ['Pydantic', '-', 'Validation et sérialisation des données'],
              ['Celery', '-', 'Gestion des tâches asynchrones (envois, découverte)'],
              ['PostgreSQL', '-', 'Base de données relationnelle'],
              ['Redis', '-', 'Broker de messages pour Celery'],
              ['BeautifulSoup', '-', 'Parsing HTML pour le crawling web'],
              ['pdfminer.six', '-', 'Extraction de texte depuis les PDFs']
            ]
          }
        },
        {
          title: 'Stack Technique Frontend',
          icon: 'palette',
          content: `Le frontend utilise les dernières technologies React avec un design system personnalisé.`,
          table: {
            headers: ['Technologie', 'Version', 'Rôle'],
            rows: [
              ['Next.js', '14', 'Framework React avec App Router'],
              ['React', '18', 'Bibliothèque UI'],
              ['TypeScript', '-', 'Typage statique'],
              ['CSS Custom Properties', '-', 'Système de design tokens']
            ]
          }
        },
        {
          title: 'Services Externes',
          icon: 'database',
          content: `L'application s'intègre avec plusieurs APIs tierces pour enrichir ses fonctionnalités.`,
          table: {
            headers: ['Service', 'Rôle'],
            rows: [
              ['Gmail API', 'Envoi d\'emails avec OAuth2'],
              ['Serper.dev', 'Recherche d\'entreprises via Google'],
              ['Hunter.io', 'Vérification et découverte d\'emails']
            ]
          }
        },
        {
          title: 'Architecture du Projet',
          icon: 'structure',
          content: `L'application est organisée en deux parties principales (backend et frontend) orchestrées par Docker Compose.`,
          codeBlock: {
            language: 'text',
            code: `ApplyFlow/
├── backend/                    # API FastAPI
│   ├── app/
│   │   ├── api/               # Endpoints REST (12 fichiers)
│   │   │   ├── companies.py   # CRUD entreprises
│   │   │   ├── contacts.py    # CRUD contacts
│   │   │   ├── drafts.py      # Gestion des brouillons
│   │   │   ├── sends.py       # Envoi et suivi
│   │   │   ├── prospection.py # Recherche intelligente
│   │   │   └── ...
│   │   ├── models/            # Modèles SQLAlchemy
│   │   ├── schemas/           # Schémas Pydantic
│   │   ├── services/          # Logique métier
│   │   │   ├── gmail_service.py
│   │   │   ├── contact_discovery_service.py
│   │   │   └── ...
│   │   └── workers/           # Tâches Celery
│   │
│   └── Dockerfile
│
├── frontend/                   # Application Next.js
│   ├── src/
│   │   ├── app/               # Pages (App Router)
│   │   │   ├── dashboard/
│   │   │   ├── prospection/
│   │   │   ├── drafts/
│   │   │   ├── sends/
│   │   │   └── ...
│   │   ├── components/        # Composants réutilisables
│   │   └── lib/               # Utilitaires et API client
│   │
│   └── Dockerfile
│
├── docker-compose.yml         # Orchestration 4 conteneurs
└── LANCER.bat                 # Script de démarrage Windows`
          }
        },
        {
          title: 'Conformité RGPD',
          icon: 'filter',
          content: `L'application a été conçue dans le respect total du Règlement Général sur la Protection des Données.`,
          table: {
            headers: ['Exigence', 'Implémentation'],
            rows: [
              ['Minimisation des données', 'Seules les données nécessaires sont collectées'],
              ['Base légale', 'Intérêt légitime pour prospection B2B'],
              ['Droit à l\'effacement', 'Suppression en un clic de tout contact'],
              ['Opt-out', 'Phrase de désinscription dans chaque email'],
              ['Traçabilité', 'Journal d\'audit complet'],
              ['Sécurité', 'Tokens OAuth chiffrés, connexions HTTPS']
            ]
          }
        },
        {
          title: 'Chiffres Clés',
          icon: 'chart',
          content: null,
          highlights: [
            { title: '+15 000 lignes de code', description: 'Backend Python + Frontend TypeScript' },
            { title: '4 conteneurs Docker', description: 'Backend, Frontend, PostgreSQL, Redis' },
            { title: '12 endpoints API', description: 'Architecture RESTful complète' },
            { title: '+400 contacts découverts', description: 'En quelques sessions de prospection' },
            { title: 'Taux de réponse supérieur', description: 'Significativement meilleur que les plateformes classiques' }
          ]
        },
        {
          title: 'Design System',
          icon: 'palette',
          content: `J'ai créé un design system complet inspiré du style "Tech Noir" avec une palette de couleurs utilisant des dégradés sombres et des accents ambre (#D4A574) et violet (#8B5CF6). La typographie utilise Clash Display pour les titres et Satoshi pour le corps de texte. L'interface inclut des composants personnalisés (boutons, cartes, modales, toasts, formulaires), des animations fluides avec micro-interactions, et est entièrement responsive (mobile/tablette/desktop).`
        },
        {
          title: 'Points Forts',
          icon: 'star',
          content: null,
          highlights: [
            { title: 'Développement Backend', description: 'Conception d\'API REST avec FastAPI, modélisation BDD, tâches asynchrones Celery' },
            { title: 'Développement Frontend', description: 'Architecture React moderne avec Next.js 14, TypeScript, design system from scratch' },
            { title: 'Intégrations API', description: 'Gmail OAuth2, Serper.dev, Hunter.io pour un workflow automatisé' },
            { title: 'DevOps', description: 'Conteneurisation Docker, orchestration multi-conteneurs' },
            { title: 'Web Scraping', description: 'Crawling éthique, extraction PDF, analyse de sitemaps' },
            { title: 'Conformité RGPD', description: 'Traçabilité, opt-out, droit à l\'effacement' }
          ]
        }
      ],
      en: [
        {
          title: 'Intelligent Company Search',
          icon: 'filter',
          content: `The tool allows launching targeted searches by location (city, department or region), business sector (Data, Tech, Consulting, etc.) and specific keywords. Each company found is analyzed and receives a relevance score based on its data maturity, the presence of technical terms on its website, and other criteria.`,
          image: '/img/applyflow-02.png',
          imageSize: 'large',
          imageCaption: 'Search interface with advanced filters'
        },
        {
          title: 'Automatic Contact Discovery',
          icon: 'robot',
          content: `Once companies are identified, ApplyFlow searches for relevant contacts using several complementary techniques.`,
          table: {
            headers: ['Technique', 'Description'],
            rows: [
              ['Intelligent crawling', 'Analysis of "Contact", "Team", "About", "Careers" pages'],
              ['PDF extraction', 'Email detection in accessible PDF documents'],
              ['Sitemap analysis', 'Exhaustive exploration of site structure'],
              ['Hunter.io integration', 'Verification and enrichment of professional emails'],
              ['Validation', 'Verification of the actual existence of each email address']
            ]
          },
          image: '/img/applyflow-03.png',
          imageSize: 'large',
          imageCaption: 'Contact discovery and validation'
        },
        {
          title: 'Personalized Email Generation',
          icon: 'code',
          content: `Each email is automatically generated based on the company name and sector, information collected from the website, and a customizable template. Emails automatically include a context-appropriate hook, a brief profile presentation, and a mandatory GDPR opt-out phrase.`,
          image: '/img/applyflow-04.png',
          imageSize: 'large',
          imageCaption: 'Personalized email generation'
        },
        {
          title: 'Validation Interface (Human-in-the-Loop)',
          icon: 'star',
          content: `This is the heart of the application. Each draft goes through a mandatory validation step with email preview exactly as it will be received, content editing capability, quality score with visual indicators on personalization, and available actions: Approve, Reject, or Mark "To research". Nothing is sent without explicit approval.`,
          image: '/img/applyflow-05.png',
          imageSize: 'large',
          imageCaption: 'Draft validation interface'
        },
        {
          title: 'Smart Batch Sending',
          icon: 'list',
          content: `Once emails are approved, sending is done in a controlled manner with a visual queue for real-time tracking, a configurable anti-spam delay between each email (60-180 seconds), automatic attachment (CV in PDF), and secure OAuth2 authentication to Gmail.`,
          image: '/img/applyflow-06.png',
          imageSize: 'large',
          imageCaption: 'Send queue with real-time tracking'
        },
        {
          title: 'Dashboard and Statistics',
          icon: 'chart',
          content: `A comprehensive dashboard to track prospecting progress with real-time counters (emails sent, pending, responses received), graphs showing sending evolution over time, performance metrics by campaign, and alerts for responses and bounces.`,
          image: '/img/applyflow-07.png',
          imageSize: 'large',
          imageCaption: 'Dashboard with performance metrics'
        },
        {
          title: 'Complete Audit Log',
          icon: 'folder',
          content: `For GDPR compliance and action tracking, the application maintains total traceability where each action is recorded (creation, modification, sending), with precise timestamps and a searchable history with filtering by action type or entity.`,
          image: '/img/applyflow-08.png',
          imageSize: 'large',
          imageCaption: 'Audit log for GDPR compliance'
        },
        {
          title: 'Backend Technical Stack',
          icon: 'tools',
          content: `The backend is built on a modern, high-performance architecture with Python and FastAPI.`,
          table: {
            headers: ['Technology', 'Version', 'Role'],
            rows: [
              ['Python', '3.11', 'Main language'],
              ['FastAPI', '-', 'High-performance REST API framework'],
              ['SQLAlchemy', '-', 'ORM for database management'],
              ['Pydantic', '-', 'Data validation and serialization'],
              ['Celery', '-', 'Asynchronous task management (sending, discovery)'],
              ['PostgreSQL', '-', 'Relational database'],
              ['Redis', '-', 'Message broker for Celery'],
              ['BeautifulSoup', '-', 'HTML parsing for web crawling'],
              ['pdfminer.six', '-', 'Text extraction from PDFs']
            ]
          }
        },
        {
          title: 'Frontend Technical Stack',
          icon: 'palette',
          content: `The frontend uses the latest React technologies with a custom design system.`,
          table: {
            headers: ['Technology', 'Version', 'Role'],
            rows: [
              ['Next.js', '14', 'React framework with App Router'],
              ['React', '18', 'UI library'],
              ['TypeScript', '-', 'Static typing'],
              ['CSS Custom Properties', '-', 'Design token system']
            ]
          }
        },
        {
          title: 'External Services',
          icon: 'database',
          content: `The application integrates with several third-party APIs to enhance its functionality.`,
          table: {
            headers: ['Service', 'Role'],
            rows: [
              ['Gmail API', 'Email sending with OAuth2'],
              ['Serper.dev', 'Company search via Google'],
              ['Hunter.io', 'Email verification and discovery']
            ]
          }
        },
        {
          title: 'Project Architecture',
          icon: 'structure',
          content: `The application is organized into two main parts (backend and frontend) orchestrated by Docker Compose.`,
          codeBlock: {
            language: 'text',
            code: `ApplyFlow/
├── backend/                    # FastAPI API
│   ├── app/
│   │   ├── api/               # REST Endpoints (12 files)
│   │   │   ├── companies.py   # Companies CRUD
│   │   │   ├── contacts.py    # Contacts CRUD
│   │   │   ├── drafts.py      # Draft management
│   │   │   ├── sends.py       # Sending and tracking
│   │   │   ├── prospection.py # Intelligent search
│   │   │   └── ...
│   │   ├── models/            # SQLAlchemy models
│   │   ├── schemas/           # Pydantic schemas
│   │   ├── services/          # Business logic
│   │   │   ├── gmail_service.py
│   │   │   ├── contact_discovery_service.py
│   │   │   └── ...
│   │   └── workers/           # Celery tasks
│   │
│   └── Dockerfile
│
├── frontend/                   # Next.js Application
│   ├── src/
│   │   ├── app/               # Pages (App Router)
│   │   │   ├── dashboard/
│   │   │   ├── prospection/
│   │   │   ├── drafts/
│   │   │   ├── sends/
│   │   │   └── ...
│   │   ├── components/        # Reusable components
│   │   └── lib/               # Utilities and API client
│   │
│   └── Dockerfile
│
├── docker-compose.yml         # 4-container orchestration
└── LANCER.bat                 # Windows startup script`
          }
        },
        {
          title: 'GDPR Compliance',
          icon: 'filter',
          content: `The application was designed in full compliance with the General Data Protection Regulation.`,
          table: {
            headers: ['Requirement', 'Implementation'],
            rows: [
              ['Data minimization', 'Only necessary data is collected'],
              ['Legal basis', 'Legitimate interest for B2B prospecting'],
              ['Right to erasure', 'One-click deletion of any contact'],
              ['Opt-out', 'Unsubscribe phrase in every email'],
              ['Traceability', 'Complete audit log'],
              ['Security', 'Encrypted OAuth tokens, HTTPS connections']
            ]
          }
        },
        {
          title: 'Key Figures',
          icon: 'chart',
          content: null,
          highlights: [
            { title: '+15,000 lines of code', description: 'Python Backend + TypeScript Frontend' },
            { title: '4 Docker containers', description: 'Backend, Frontend, PostgreSQL, Redis' },
            { title: '12 API endpoints', description: 'Complete RESTful architecture' },
            { title: '+400 contacts discovered', description: 'In a few prospecting sessions' },
            { title: 'Higher response rate', description: 'Significantly better than traditional platforms' }
          ]
        },
        {
          title: 'Design System',
          icon: 'palette',
          content: `I created a complete design system inspired by the "Tech Noir" style with a color palette using dark gradients and amber (#D4A574) and violet (#8B5CF6) accents. Typography uses Clash Display for headings and Satoshi for body text. The interface includes custom components (buttons, cards, modals, toasts, forms), smooth animations with micro-interactions, and is fully responsive (mobile/tablet/desktop).`
        },
        {
          title: 'Key Strengths',
          icon: 'star',
          content: null,
          highlights: [
            { title: 'Backend Development', description: 'REST API design with FastAPI, database modeling, async Celery tasks' },
            { title: 'Frontend Development', description: 'Modern React architecture with Next.js 14, TypeScript, design system from scratch' },
            { title: 'API Integrations', description: 'Gmail OAuth2, Serper.dev, Hunter.io for automated workflow' },
            { title: 'DevOps', description: 'Docker containerization, multi-container orchestration' },
            { title: 'Web Scraping', description: 'Ethical crawling, PDF extraction, sitemap analysis' },
            { title: 'GDPR Compliance', description: 'Traceability, opt-out, right to erasure' }
          ]
        }
      ]
    }
  },
  'perftracker': {
    id: 'perftracker',
    title: 'Perf Tracker',
    subtitle: {
      fr: 'Application de Suivi de Performances Sportives',
      en: 'Sports Performance Tracking Application'
    },
    description: {
      fr: `Perf Tracker est une Progressive Web App (PWA) moderne et responsive permettant de suivre et visualiser ses performances sportives sur le long terme. L'application offre un suivi personnalisé par profil utilisateur, avec des graphiques interactifs pour analyser la progression sur chaque exercice.

Conçue pour les sportifs qui souhaitent suivre leur évolution en musculation, cardio et exercices divers, avec calcul automatique du 1RM et indicateurs de progression visuels.`,
      en: `Perf Tracker is a modern and responsive Progressive Web App (PWA) for tracking and visualizing sports performances over the long term. The application offers personalized tracking by user profile, with interactive charts to analyze progression on each exercise.

Designed for athletes who want to track their progress in weight training, cardio and various exercises, with automatic 1RM calculation and visual progression indicators.`
    },
    technologies: ['HTML5', 'CSS3', 'JavaScript ES6+', 'Firebase Firestore', 'Chart.js', 'Service Worker', 'PWA'],
    features: {
      fr: [
        'Gestion multi-profils avec avatar',
        'Suivi évolution corporelle',
        'Bibliothèque de 25+ exercices',
        'Graphiques multi-axes interactifs',
        'Calcul automatique du 1RM',
        'Indicateurs de progression colorés',
        'Mode sombre/clair',
        'PWA installable hors-ligne'
      ],
      en: [
        'Multi-profile management with avatar',
        'Body evolution tracking',
        '25+ exercise library',
        'Interactive multi-axis charts',
        'Automatic 1RM calculation',
        'Color-coded progression indicators',
        'Dark/light mode',
        'Offline installable PWA'
      ]
    },
    images: ['/img/perf-01.png'],
    color: '#f472b6',
    year: '2025',
    hideScreenshots: true,
    sections: {
      fr: [
        {
          title: 'Interface Principale',
          icon: 'star',
          content: `L'application offre une interface moderne et épurée, conçue mobile-first pour une utilisation optimale en salle de sport. Le design utilise des animations fluides, des cartes avec effets de survol, et des transitions CSS soignées.`,
          image: '/img/perf-01.png',
          imageSize: 'large',
          imageCaption: 'Page d\'accueil'
        },
        {
          title: 'Gestion Multi-Profils',
          icon: 'user',
          content: `Création de profils utilisateurs avec informations personnelles (nom, prénom, taille, poids, pourcentage de masse grasse). Système de mot de passe pour l'accès en Mode Éditeur, avec Mode Lecteur pour consultation sans modification. Avatar généré automatiquement via l'API DiceBear.`,
          image: '/img/perf-02.png',
          imageSize: 'large',
          imageCaption: 'Liste des profils avec avatar'
        },
        {
          title: 'Suivi de l\'Évolution Corporelle',
          icon: 'chart',
          content: `Historique du poids et de la masse grasse stocké dans Firestore. Graphique linéaire Chart.js montrant l'évolution du poids dans le temps, avec mise à jour en temps réel des données.`,
          image: '/img/perf-03.png',
          imageSize: 'large',
          imageCaption: 'Graphique d\'évolution du poids'
        },
        {
          title: 'Bibliothèque d\'Exercices',
          icon: 'grid',
          content: `L'application intègre une bibliothèque de 25+ exercices pré-configurés, organisés par catégories musculaires : Pectoraux (développé couché, incliné, écarté poulie), Dos (tractions, rowing, tirage), Épaules (élévations latérales, développé militaire), Bras (curl biceps, dips, extension triceps), Jambes (squat, fentes, presse), Abdos (gainage, crunch, planche) et Cardio (course, vélo, marche, rowing).`,
          imageGrid: [
            { image: '/img/perf-04.png', caption: 'Catégories musculaires' },
            { image: '/img/perf-05.png', caption: 'Liste des exercices' }
          ]
        },
        {
          title: 'Tracking des Performances',
          icon: 'list',
          content: `Selon le type d'exercice, le formulaire de saisie s'adapte automatiquement. Pour la musculation : Poids (kg), Répétitions, RPE (1-10), Date. Pour les abdos : Durée (secondes), RPE, Date. Pour le cardio : Durée (minutes), Distance (km), RPE, Date.`,
          image: '/img/perf-06.png',
          imageSize: 'large',
          imageCaption: 'Graphique de performance avec multi-axes'
        },
        {
          title: 'Visualisation Avancée',
          icon: 'chart',
          content: `Graphique multi-axes avec Poids + RPE sur des axes Y séparés. Calcul automatique du 1RM (One Rep Max) avec la formule d'Epley. Points de données interactifs avec tooltips détaillés. Zoom et pan sur le graphique (pinch sur mobile, scroll sur desktop).`,
          codeBlock: {
            language: 'javascript',
            code: `// Calcul du 1RM avec la formule d'Epley
function calculate1RM(weight, reps) {
    if (reps === 1) return weight;
    return weight * (1 + 0.0333 * reps);
}

// Configuration Chart.js multi-axes
const config = {
    type: 'line',
    data: {
        datasets: [
            {
                label: 'Poids (kg)',
                data: weightData,
                yAxisID: 'y-weight',
                borderColor: '#f472b6'
            },
            {
                label: 'RPE',
                data: rpeData,
                yAxisID: 'y-rpe',
                borderColor: '#6366f1'
            }
        ]
    },
    options: {
        scales: {
            'y-weight': { position: 'left' },
            'y-rpe': { position: 'right', max: 10 }
        },
        plugins: {
            zoom: {
                pan: { enabled: true },
                zoom: { wheel: { enabled: true } }
            }
        }
    }
};`
          }
        },
        {
          title: 'Indicateur de Progression',
          icon: 'trending',
          content: `Sur chaque carte d'exercice, une barre de progression colorée indique l'évolution : Vert pour progression > 2%, Orange pour stable (±2%), Rouge pour régression > 2%. Le tooltip affiche le détail : pourcentage de progression et dernière performance.`,
          table: {
            headers: ['Couleur', 'Condition', 'Signification'],
            rows: [
              ['Vert', '> +2%', 'Progression positive'],
              ['Orange', '±2%', 'Performance stable'],
              ['Rouge', '> -2%', 'Régression détectée']
            ]
          }
        },
        {
          title: 'Mode Sombre / Clair',
          icon: 'palette',
          content: `Bascule instantanée entre thème clair et sombre. Préférence sauvegardée dans le localStorage. Détection automatique de la préférence système (prefers-color-scheme). Transitions CSS fluides entre les modes.`
        },
        {
          title: 'Progressive Web App (PWA)',
          icon: 'download',
          content: `L'application est installable sur mobile et desktop. Service Worker pour le fonctionnement hors-ligne, cache des ressources statiques. Manifest avec icônes 192x192 et 512x512. Instructions d'installation intégrées pour iOS (Safari) et Android.`,
          image: '/img/perf-07.png',
          imageSize: 'large',
          imageCaption: 'Installation PWA sur mobile'
        },
        {
          title: 'Architecture des Données',
          icon: 'structure',
          content: `Base de données NoSQL Firestore avec structure hiérarchique optimisée pour les requêtes en temps réel.`,
          codeBlock: {
            language: 'text',
            code: `/profiles/{profileId}
  ├── firstName, lastName, height, weight, fat, password, createdAt
  │
  ├── /weightHistory/{historyId}
  │     └── weight, fat, date
  │
  └── /exercises/{exerciseId}
        ├── name, category, imageBase64, fromLibrary, createdAt
        │
        └── /performances/{perfId}
              └── weight, reps, rpe, date (ou time, distance pour cardio/abdos)`
          }
        },
        {
          title: 'Structure du Projet',
          icon: 'folder',
          content: `Architecture modulaire avec ES6 Modules (import/export), formulaires dynamiques adaptés au type d'exercice, calculs avancés (1RM, score de progression), et gestion offline via Service Worker.`,
          codeBlock: {
            language: 'text',
            code: `Perf_Tracker/
├── index.html          # Page d'accueil
├── profile.html        # Dashboard profil
├── exercise.html       # Détail exercice + graphique
├── style.css           # Styles globaux (1000+ lignes)
├── app.js              # Configuration Firebase
├── exerciseLibrary.js  # Base de données exercices
├── service-worker.js   # PWA offline
├── manifest.json       # Manifest PWA
├── icons/              # Icônes PWA (192px, 512px)
├── images/             # Images des exercices (25+)
└── videos/             # Vidéos de démonstration`
          }
        }
      ],
      en: [
        {
          title: 'Main Interface',
          icon: 'star',
          content: `The application offers a modern and clean interface, designed mobile-first for optimal use in the gym. The design uses smooth animations, cards with hover effects, and polished CSS transitions.`,
          image: '/img/perf-01.png',
          imageSize: 'large',
          imageCaption: 'Home page'
        },
        {
          title: 'Multi-Profile Management',
          icon: 'user',
          content: `Create user profiles with personal information (first name, last name, height, weight, body fat percentage). Password system for Editor Mode access, with Reader Mode for consultation without modification. Avatar automatically generated via DiceBear API.`,
          image: '/img/perf-02.png',
          imageSize: 'large',
          imageCaption: 'Profile list with avatar'
        },
        {
          title: 'Body Evolution Tracking',
          icon: 'chart',
          content: `Weight and body fat history stored in Firestore. Chart.js line graph showing weight evolution over time, with real-time data updates.`,
          image: '/img/perf-03.png',
          imageSize: 'large',
          imageCaption: 'Weight evolution chart'
        },
        {
          title: 'Exercise Library',
          icon: 'grid',
          content: `The application includes a library of 25+ pre-configured exercises, organized by muscle categories: Chest (bench press, incline, cable fly), Back (pull-ups, rowing, lat pulldown), Shoulders (lateral raises, military press), Arms (bicep curl, dips, tricep extension), Legs (squat, lunges, leg press), Abs (plank, crunch) and Cardio (running, cycling, walking, rowing).`,
          imageGrid: [
            { image: '/img/perf-04.png', caption: 'Muscle categories' },
            { image: '/img/perf-05.png', caption: 'Exercise list' }
          ]
        },
        {
          title: 'Performance Tracking',
          icon: 'list',
          content: `Depending on the exercise type, the input form adapts automatically. For weight training: Weight (kg), Reps, RPE (1-10), Date. For abs: Duration (seconds), RPE, Date. For cardio: Duration (minutes), Distance (km), RPE, Date.`,
          image: '/img/perf-06.png',
          imageSize: 'large',
          imageCaption: 'Performance chart with multi-axes'
        },
        {
          title: 'Advanced Visualization',
          icon: 'chart',
          content: `Multi-axis chart with Weight + RPE on separate Y axes. Automatic 1RM (One Rep Max) calculation using Epley formula. Interactive data points with detailed tooltips. Zoom and pan on chart (pinch on mobile, scroll on desktop).`,
          codeBlock: {
            language: 'javascript',
            code: `// 1RM calculation with Epley formula
function calculate1RM(weight, reps) {
    if (reps === 1) return weight;
    return weight * (1 + 0.0333 * reps);
}

// Chart.js multi-axes configuration
const config = {
    type: 'line',
    data: {
        datasets: [
            {
                label: 'Weight (kg)',
                data: weightData,
                yAxisID: 'y-weight',
                borderColor: '#f472b6'
            },
            {
                label: 'RPE',
                data: rpeData,
                yAxisID: 'y-rpe',
                borderColor: '#6366f1'
            }
        ]
    },
    options: {
        scales: {
            'y-weight': { position: 'left' },
            'y-rpe': { position: 'right', max: 10 }
        },
        plugins: {
            zoom: {
                pan: { enabled: true },
                zoom: { wheel: { enabled: true } }
            }
        }
    }
};`
          }
        },
        {
          title: 'Progression Indicator',
          icon: 'trending',
          content: `On each exercise card, a colored progress bar indicates evolution: Green for progression > 2%, Orange for stable (±2%), Red for regression > 2%. The tooltip shows details: progression percentage and last performance.`,
          table: {
            headers: ['Color', 'Condition', 'Meaning'],
            rows: [
              ['Green', '> +2%', 'Positive progression'],
              ['Orange', '±2%', 'Stable performance'],
              ['Red', '> -2%', 'Regression detected']
            ]
          }
        },
        {
          title: 'Dark / Light Mode',
          icon: 'palette',
          content: `Instant toggle between light and dark themes. Preference saved in localStorage. Automatic detection of system preference (prefers-color-scheme). Smooth CSS transitions between modes.`
        },
        {
          title: 'Progressive Web App (PWA)',
          icon: 'download',
          content: `The application is installable on mobile and desktop. Service Worker for offline functionality, static resource caching. Manifest with 192x192 and 512x512 icons. Built-in installation instructions for iOS (Safari) and Android.`,
          image: '/img/perf-07.png',
          imageSize: 'large',
          imageCaption: 'PWA installation on mobile'
        },
        {
          title: 'Data Architecture',
          icon: 'structure',
          content: `NoSQL Firestore database with hierarchical structure optimized for real-time queries.`,
          codeBlock: {
            language: 'text',
            code: `/profiles/{profileId}
  ├── firstName, lastName, height, weight, fat, password, createdAt
  │
  ├── /weightHistory/{historyId}
  │     └── weight, fat, date
  │
  └── /exercises/{exerciseId}
        ├── name, category, imageBase64, fromLibrary, createdAt
        │
        └── /performances/{perfId}
              └── weight, reps, rpe, date (or time, distance for cardio/abs)`
          }
        },
        {
          title: 'Project Structure',
          icon: 'folder',
          content: `Modular architecture with ES6 Modules (import/export), dynamic forms adapted to exercise type, advanced calculations (1RM, progression score), and offline management via Service Worker.`,
          codeBlock: {
            language: 'text',
            code: `Perf_Tracker/
├── index.html          # Home page
├── profile.html        # Profile dashboard
├── exercise.html       # Exercise detail + chart
├── style.css           # Global styles (1000+ lines)
├── app.js              # Firebase configuration
├── exerciseLibrary.js  # Exercise database
├── service-worker.js   # PWA offline
├── manifest.json       # PWA Manifest
├── icons/              # PWA icons (192px, 512px)
├── images/             # Exercise images (25+)
└── videos/             # Demo videos`
          }
        }
      ]
    }
  },
  'csv-analyst': {
    id: 'csv-analyst',
    title: 'CSV Analyst',
    subtitle: {
      fr: 'Plateforme de Data Wrangling',
      en: 'Data Wrangling Platform'
    },
    description: {
      fr: `CSV Analyst est une application web complète de Data Wrangling (préparation et nettoyage de données) qui permet aux utilisateurs d'importer, analyser, transformer et exporter leurs fichiers CSV de manière intuitive et visuelle. Conçue pour les Data Analysts, Data Scientists et professionnels manipulant régulièrement des données tabulaires.

L'objectif principal est de simplifier le processus souvent fastidieux de nettoyage de données en proposant des outils visuels et une fonctionnalité de "Magic Clean" qui automatise les corrections les plus courantes.`,
      en: `CSV Analyst is a comprehensive Data Wrangling web application that allows users to import, analyze, transform and export their CSV files in an intuitive and visual way. Designed for Data Analysts, Data Scientists and professionals who regularly work with tabular data.

The main goal is to simplify the often tedious data cleaning process by providing visual tools and a "Magic Clean" feature that automates the most common corrections.`
    },
    technologies: ['React 18', 'TypeScript', 'Vite', 'Framer Motion', 'Python', 'FastAPI', 'Pandas', 'NumPy', 'SciPy', 'Pydantic'],
    features: {
      fr: [
        'Upload Drag & Drop avec détection automatique',
        'Health Score et analyse de qualité',
        'Magic Clean automatisé',
        'Pipeline de transformations Undo/Redo',
        'Visualisations interactives',
        'Export CSV et rapport de profiling',
        'Thèmes Dark/Light'
      ],
      en: [
        'Drag & Drop upload with automatic detection',
        'Health Score and quality analysis',
        'Automated Magic Clean',
        'Undo/Redo transformation pipeline',
        'Interactive visualizations',
        'CSV export and profiling report',
        'Dark/Light themes'
      ]
    },
    images: ['/img/analyst-01.png'],
    color: '#f59e0b',
    year: '2025',
    hideScreenshots: true,
    sections: {
      fr: [
        {
          title: 'Upload de Fichiers',
          icon: 'upload',
          content: `Glissez-déposez vos fichiers CSV directement dans la zone d'upload. Détection automatique de l'encodage (UTF-8, Latin-1, etc.) et du séparateur (, ; |). Validation du format et de la taille avant traitement, avec animations de progression pendant le chargement.`,
          image: '/img/analyst-01.png',
          imageSize: 'large',
          imageCaption: 'Interface d\'upload avec Drag & Drop'
        },
        {
          title: 'Vue d\'Ensemble et Health Score',
          icon: 'chart',
          content: `La page Overview offre une vue complète du dataset avec un Health Score sous forme de jauge circulaire animée représentant la qualité globale sur 100. Le score est calculé selon le pourcentage de valeurs manquantes, duplicatas et problèmes détectés, avec un code couleur : Vert (>80), Orange (50-80), Rouge (<50).`,
          image: '/img/analyst-02.png',
          imageSize: 'large',
          imageCaption: 'Dashboard Overview avec Health Score'
        },
        {
          title: 'Métriques Clés et Schéma',
          icon: 'grid',
          content: `Affichage du nombre de lignes/colonnes, taille du fichier, utilisation mémoire, pourcentage de cellules manquantes et lignes dupliquées. Le schéma interactif affiche pour chaque colonne : nom, type inféré (integer, float, string, datetime, categorical), taux de complétion, cardinalité et indicateur de colonne ID potentielle.`,
          image: '/img/analyst-03.png',
          imageSize: 'large',
          imageCaption: 'Détail des colonnes et statistiques'
        },
        {
          title: 'Cleaning Studio',
          icon: 'tools',
          content: `Le cœur de l'application permet de nettoyer et transformer les données avec des outils puissants : Fill Missing (imputation par mean, median, mode, constant), Drop Duplicates, Cast Type, Rename, Drop Column, Handle Outliers (Z-Score, IQR, Winsorization), Filter Rows et Find & Replace avec support regex.`,
          image: '/img/analyst-04.png',
          imageSize: 'large',
          imageCaption: 'Interface Cleaning Studio avec outils de transformation'
        },
        {
          title: 'Magic Clean',
          icon: 'star',
          content: `Fonctionnalité phare qui automatise le nettoyage : analyse automatique des problèmes, puis application séquentielle des corrections - remplissage des valeurs manquantes (median pour numériques, mode pour catégorielles), suppression des duplicatas, clipping des outliers (méthode IQR), et suppression des colonnes constantes. Un rapport détaillé affiche toutes les actions effectuées.`,
          image: '/img/analyst-05.png',
          imageSize: 'large',
          imageCaption: 'Magic Clean avec rapport des actions'
        },
        {
          title: 'Pipeline de Transformation',
          icon: 'list',
          content: `Historique visuel de toutes les transformations appliquées, design en timeline avec numérotation des étapes. Description de chaque action et son impact (lignes avant/après). Bouton Undo pour annuler la dernière transformation et Reset pour revenir à l'état initial. Chaque transformation crée une nouvelle version du dataset, permettant l'undo/redo sans perte de données.`,
          codeBlock: {
            language: 'python',
            code: `# Services Backend - Transformation Pipeline
class TransformationService:
    """Gestion du pipeline de transformations avec versioning"""
    
    def apply_transform(self, dataset_id: str, transform: Transform):
        # Récupère la version actuelle
        current = self.session_manager.get_dataset(dataset_id)
        
        # Applique la transformation
        new_df = self._execute_transform(current.df, transform)
        
        # Crée une nouvelle version
        new_version = DatasetVersion(
            df=new_df,
            transform=transform,
            parent_version=current.version_id,
            rows_before=len(current.df),
            rows_after=len(new_df)
        )
        
        # Sauvegarde dans l'historique
        self.session_manager.push_version(dataset_id, new_version)
        return new_version`
          }
        },
        {
          title: 'Visualisations Analytiques',
          icon: 'chart',
          content: `Outils d'exploration visuelle des données : statistiques par colonne (mean, std, min, max, quartiles, skewness, kurtosis pour numériques; top values et distribution pour catégorielles), histogrammes avec 30 bins, matrice de corrélation en heatmap interactive, scatter plots et box plots pour visualiser distributions et outliers.`,
          image: '/img/analyst-06.png',
          imageSize: 'large',
          imageCaption: 'Page Analysis avec visualisations'
        },
        {
          title: 'Graphiques Avancés',
          icon: 'chart',
          content: `Histogrammes de fréquence pour analyser la distribution des valeurs numériques. Configuration dynamique du nombre de bins et sélection de la colonne à visualiser.`,
          image: '/img/analyst-08.png',
          imageSize: 'medium',
          imageCaption: 'Histogramme de fréquence'
        },
        {
          title: 'Matrice de Corrélation',
          icon: 'grid',
          content: `Heatmap interactive des corrélations entre toutes les variables numériques du dataset. Les couleurs vont du bleu (corrélation négative) au rouge (corrélation positive), permettant d'identifier rapidement les relations entre variables.`,
          image: '/img/analyst-09.png',
          imageSize: 'medium',
          imageCaption: 'Matrice de corrélation heatmap'
        },
        {
          title: 'Graphiques de Dispersion',
          icon: 'scatter',
          content: `Scatter plots pour explorer les relations entre deux variables. Sélection dynamique des axes X et Y pour identifier patterns, clusters et outliers dans les données.`,
          image: '/img/analyst-10.png',
          imageSize: 'medium',
          imageCaption: 'Scatter plot interactif'
        },
        {
          title: 'Export et Rapport',
          icon: 'download',
          content: `Export CSV du dataset nettoyé avec aperçu avant téléchargement. Génération d'un rapport de profiling détaillé contenant toutes les statistiques et visualisations de l'analyse.`,
          image: '/img/analyst-07.png',
          imageSize: 'large',
          imageCaption: 'Interface d\'export avec preview'
        },
        {
          title: 'Architecture du Projet',
          icon: 'structure',
          content: `Architecture API REST avec communication frontend/backend via endpoints JSON. Gestion session-based des datasets en mémoire avec système de versioning. Pipeline Pattern où chaque transformation est enregistrée et réversible.`,
          codeBlock: {
            language: 'text',
            code: `csv-analyst/
├── frontend/
│   ├── src/
│   │   ├── api/          # Client API (Axios)
│   │   ├── components/   # HealthScore, Skeleton...
│   │   ├── pages/        # Home, Overview, Cleaning, Analysis, Export
│   │   ├── styles/       # Design system CSS
│   │   └── types/        # Types TypeScript
│   └── vite.config.ts
│
├── backend/
│   ├── routers/          # Endpoints API
│   ├── services/         # profiler, transformer, session_manager
│   ├── models/           # Modèles Pydantic
│   └── main.py           # Point d'entrée FastAPI
│
└── docker-compose.yml    # Orchestration`
          }
        }
      ],
      en: [
        {
          title: 'File Upload',
          icon: 'upload',
          content: `Drag and drop your CSV files directly into the upload zone. Automatic detection of encoding (UTF-8, Latin-1, etc.) and separator (, ; |). Format and size validation before processing, with progress animations during loading.`,
          image: '/img/analyst-01.png',
          imageSize: 'large',
          imageCaption: 'Upload interface with Drag & Drop'
        },
        {
          title: 'Overview and Health Score',
          icon: 'chart',
          content: `The Overview page provides a complete view of the dataset with a Health Score as an animated circular gauge representing overall quality out of 100. The score is calculated based on percentage of missing values, duplicates and detected issues, with color coding: Green (>80), Orange (50-80), Red (<50).`,
          image: '/img/analyst-02.png',
          imageSize: 'large',
          imageCaption: 'Overview Dashboard with Health Score'
        },
        {
          title: 'Key Metrics and Schema',
          icon: 'grid',
          content: `Display of row/column count, file size, memory usage, percentage of missing cells and duplicate rows. The interactive schema shows for each column: name, inferred type (integer, float, string, datetime, categorical), completion rate, cardinality and potential ID column indicator.`,
          image: '/img/analyst-03.png',
          imageSize: 'large',
          imageCaption: 'Column details and statistics'
        },
        {
          title: 'Cleaning Studio',
          icon: 'tools',
          content: `The heart of the application allows cleaning and transforming data with powerful tools: Fill Missing (imputation by mean, median, mode, constant), Drop Duplicates, Cast Type, Rename, Drop Column, Handle Outliers (Z-Score, IQR, Winsorization), Filter Rows and Find & Replace with regex support.`,
          image: '/img/analyst-04.png',
          imageSize: 'large',
          imageCaption: 'Cleaning Studio interface with transformation tools'
        },
        {
          title: 'Magic Clean',
          icon: 'star',
          content: `Flagship feature that automates cleaning: automatic problem analysis, then sequential application of corrections - filling missing values (median for numeric, mode for categorical), removing duplicates, clipping outliers (IQR method), and removing constant columns. A detailed report shows all actions performed.`,
          image: '/img/analyst-05.png',
          imageSize: 'large',
          imageCaption: 'Magic Clean with action report'
        },
        {
          title: 'Transformation Pipeline',
          icon: 'list',
          content: `Visual history of all applied transformations, timeline design with step numbering. Description of each action and its impact (rows before/after). Undo button to revert the last transformation and Reset to return to initial state. Each transformation creates a new version of the dataset, enabling undo/redo without data loss.`,
          codeBlock: {
            language: 'python',
            code: `# Backend Services - Transformation Pipeline
class TransformationService:
    """Pipeline transformation management with versioning"""
    
    def apply_transform(self, dataset_id: str, transform: Transform):
        # Get current version
        current = self.session_manager.get_dataset(dataset_id)
        
        # Apply transformation
        new_df = self._execute_transform(current.df, transform)
        
        # Create new version
        new_version = DatasetVersion(
            df=new_df,
            transform=transform,
            parent_version=current.version_id,
            rows_before=len(current.df),
            rows_after=len(new_df)
        )
        
        # Save to history
        self.session_manager.push_version(dataset_id, new_version)
        return new_version`
          }
        },
        {
          title: 'Analytical Visualizations',
          icon: 'chart',
          content: `Visual data exploration tools: column statistics (mean, std, min, max, quartiles, skewness, kurtosis for numeric; top values and distribution for categorical), histograms with 30 bins, correlation matrix as interactive heatmap, scatter plots and box plots to visualize distributions and outliers.`,
          image: '/img/analyst-06.png',
          imageSize: 'large',
          imageCaption: 'Analysis page with visualizations'
        },
        {
          title: 'Advanced Charts',
          icon: 'chart',
          content: `Frequency histograms to analyze numerical value distribution. Dynamic configuration of bin count and column selection for visualization.`,
          image: '/img/analyst-08.png',
          imageSize: 'medium',
          imageCaption: 'Frequency histogram'
        },
        {
          title: 'Correlation Matrix',
          icon: 'grid',
          content: `Interactive heatmap of correlations between all numerical variables in the dataset. Colors range from blue (negative correlation) to red (positive correlation), allowing quick identification of relationships between variables.`,
          image: '/img/analyst-09.png',
          imageSize: 'medium',
          imageCaption: 'Correlation matrix heatmap'
        },
        {
          title: 'Scatter Plots',
          icon: 'scatter',
          content: `Scatter plots to explore relationships between two variables. Dynamic X and Y axis selection to identify patterns, clusters and outliers in the data.`,
          image: '/img/analyst-10.png',
          imageSize: 'medium',
          imageCaption: 'Interactive scatter plot'
        },
        {
          title: 'Export and Report',
          icon: 'download',
          content: `CSV export of the cleaned dataset with preview before download. Generation of a detailed profiling report containing all statistics and visualizations from the analysis.`,
          image: '/img/analyst-07.png',
          imageSize: 'large',
          imageCaption: 'Export interface with preview'
        },
        {
          title: 'Project Architecture',
          icon: 'structure',
          content: `REST API architecture with frontend/backend communication via JSON endpoints. Session-based dataset management in memory with versioning system. Pipeline Pattern where each transformation is recorded and reversible.`,
          codeBlock: {
            language: 'text',
            code: `csv-analyst/
├── frontend/
│   ├── src/
│   │   ├── api/          # API Client (Axios)
│   │   ├── components/   # HealthScore, Skeleton...
│   │   ├── pages/        # Home, Overview, Cleaning, Analysis, Export
│   │   ├── styles/       # CSS Design system
│   │   └── types/        # TypeScript Types
│   └── vite.config.ts
│
├── backend/
│   ├── routers/          # API Endpoints
│   ├── services/         # profiler, transformer, session_manager
│   ├── models/           # Pydantic Models
│   └── main.py           # FastAPI Entry point
│
└── docker-compose.yml    # Orchestration`
          }
        }
      ]
    }
  },
  'lol-draft-predictor': {
    id: 'lol-draft-predictor',
    title: 'LoL Pro Stats',
    subtitle: {
      fr: 'Dashboard & Assistant de Draft IA',
      en: 'Dashboard & AI Draft Assistant'
    },
    description: {
      fr: `LoL Pro Stats est une application web de statistiques et d'analyse pour League of Legends, combinant un dashboard de performance joueur premium avec un assistant de draft alimenté par Intelligence Artificielle. Ce projet fusionne la data visualisation avancée avec le Machine Learning pour offrir des recommandations de picks stratégiques en temps réel.

L'objectif principal est de créer un outil complet permettant aux joueurs d'analyser leurs performances à travers des statistiques détaillées et des visualisations interactives, tout en optimisant leurs choix de champions en draft grâce à un modèle de Machine Learning entraîné sur plus de 38 000 matchs réels.`,
      en: `LoL Pro Stats is a statistics and analysis web application for League of Legends, combining a premium player performance dashboard with an AI-powered draft assistant. This project merges advanced data visualization with Machine Learning to provide real-time strategic pick recommendations.

The main objective is to create a comprehensive tool allowing players to analyze their performances through detailed statistics and interactive visualizations, while optimizing their champion choices in draft thanks to a Machine Learning model trained on over 38,000 real matches.`
    },
    technologies: ['Python', 'PyTorch', 'Streamlit', 'Plotly', 'Riot API', 'Set Transformer', 'Pandas', 'NumPy'],
    features: {
      fr: [
        'Dashboard statistiques joueur premium',
        'Historique des matchs détaillé',
        'Champion Pool avec analytics',
        'Graphiques interactifs Plotly',
        'Assistant de draft IA (Set Transformer)',
        'Connexion LCU client local',
        'Recommandations de picks en temps réel',
        '82 meta-features extraites',
        'Matrices matchup et synergie'
      ],
      en: [
        'Premium player statistics dashboard',
        'Detailed match history',
        'Champion Pool with analytics',
        'Interactive Plotly charts',
        'AI Draft Assistant (Set Transformer)',
        'Local LCU client connection',
        'Real-time pick recommendations',
        '82 extracted meta-features',
        'Matchup and synergy matrices'
      ]
    },
    images: ['/img/lol-01.png', '/img/lol-06.png'],
    color: '#8b5cf6',
    year: '2025',
    sections: {
      fr: [
        {
          title: 'Profil Joueur Premium',
          icon: 'star',
          content: `Recherche par Riot ID (format Nom#TAG), affichage de l'icône invocateur HD avec niveau, et design glassmorphism moderne inspiré de OP.GG et U.GG.`
        },
        {
          title: 'Statistiques Classées',
          icon: 'chart',
          content: `Visualisation côte à côte Solo/Duo et Flex avec badge de rang et code couleur dynamique par tier (Iron à Challenger). Barre de progression LP animée, ratio victoires/défaites et winrate calculé.`,
          image: '/img/lol-02.png',
          imageSize: 'medium',
          imageCaption: 'Statistiques ranked Solo/Duo et Flex'
        },
        {
          title: 'Historique des Matchs',
          icon: 'list',
          content: `Cartes détaillées par match avec bandeau victoire/défaite coloré. Icône champion + badge de rôle (Top, Jungle, Mid, ADC, Support). KDA avec code couleur selon performance, affichage des 6 items + trinket, stats avancées (CS/min, DMG/min, Vision/min, Gold/min) et détails expandables.`,
          image: '/img/lol-03.png',
          imageSize: 'large',
          imageCaption: 'Historique des matchs avec détails'
        },
        {
          title: 'Champion Pool',
          icon: 'grid',
          content: `Grille de cartes par champion joué avec barre de winrate gradient couleur (vert > 55%, orange 45-55%, rouge < 45%). KDA moyen et stats détaillées par champion, CS/min et DMG/min moyens, compteur de parties jouées avec slider interactif.`,
          image: '/img/lol-04.png',
          imageSize: 'medium',
          imageCaption: 'Champion Pool avec statistiques'
        },
        {
          title: 'Analytics Avancés',
          icon: 'chart',
          content: `Graphiques interactifs Plotly : KDA Timeline (évolution sur 20 matchs avec moyenne mobile), CS Progression (graphique bars du farming par match), Winrate Timeline (courbe de winrate glissant sur 10 parties), Performance Radar (visualisation radar multi-axes) et Champion Comparison (Top 5 champions avec double axe winrate + KDA).`,
          image: '/img/lol-05.png',
          imageSize: 'large',
          imageCaption: 'Graphiques analytiques interactifs'
        },
        {
          title: 'Draft Assistant IA',
          icon: 'robot',
          content: `Un assistant intelligent qui recommande le meilleur choix de champion pendant la phase de draft, basé sur la composition actuelle de votre équipe, la composition adverse, votre rôle, et les synergies/matchups calculés. Synchronisation automatique avec le client LoL local via LCU API pour détection en temps réel des picks et bans.`,
          image: '/img/lol-06.png',
          imageSize: 'large',
          imageCaption: 'Assistant de draft avec recommandations IA'
        },
        {
          title: 'Interface de Draft Manuel',
          icon: 'tools',
          content: `Draft Board visuel avec 5 slots Ally vs 5 slots Enemy. Sélection de champions via recherche autocomplete, zone "En attente de placement" pour organiser les picks, sélection du rôle et bouton "Analyser & Prédire" pour lancer la prédiction.`
        },
        {
          title: 'Architecture Set Transformer',
          icon: 'structure',
          content: `Le modèle utilise l'architecture Set Transformer basée sur le papier de recherche "Set Transformer: A Framework for Attention-based Permutation-Invariant Neural Networks" (Lee et al., 2019). Cette architecture gère nativement les compositions de taille variable (draft partiel) avec un mécanisme d'attention multi-têtes pour capturer les interactions entre champions.`,
          codeBlock: {
            language: 'python',
            code: `class SetTransformer(nn.Module):
    """
    Complete Set Transformer for Draft Prediction
    """
    def __init__(
        self,
        num_champions,
        num_roles=5,
        embedding_dim=128,
        hidden_dim=256,
        num_heads=8,
        num_inducing_points=32,
        num_encoder_layers=3,
        ln=True
    ):
        super().__init__()
        
        # Champion embedding layer
        self.champion_embedding = nn.Embedding(num_champions, embedding_dim)
        
        # Role embedding layer
        self.role_embedding = nn.Embedding(num_roles, embedding_dim)
        
        # Allied champions encoder (handles variable-size sets)
        self.allied_encoder = nn.ModuleList()
        for i in range(num_encoder_layers):
            input_dim = embedding_dim if i == 0 else hidden_dim
            self.allied_encoder.append(
                InducedSetAttentionBlock(
                    input_dim, hidden_dim, num_heads, 
                    num_inducing_points, ln=ln
                )
            )
        
        # MLP prediction head
        # Input: allied_pool + enemy_pool + role + candidate_champ + meta_features
        mlp_input_dim = hidden_dim * 2 + embedding_dim * 2 + 82  # 82 meta features
        
        self.mlp = nn.Sequential(
            nn.Linear(mlp_input_dim, hidden_dim * 2),
            nn.LayerNorm(hidden_dim * 2),
            nn.ReLU(),
            nn.Dropout(0.3),
            nn.Linear(hidden_dim * 2, hidden_dim),
            nn.LayerNorm(hidden_dim),
            nn.ReLU(),
            nn.Dropout(0.2),
            nn.Linear(hidden_dim, hidden_dim // 2),
            nn.ReLU(),
            nn.Linear(hidden_dim // 2, 1),
            nn.Sigmoid()
        )`
          }
        },
        {
          title: 'Induced Set Attention Block (ISAB)',
          icon: 'code',
          content: `Le bloc ISAB utilise des points d'induction pour réduire la complexité de O(n²) à O(nm) où m << n, permettant un traitement efficace des grandes compositions.`,
          codeBlock: {
            language: 'python',
            code: `class InducedSetAttentionBlock(nn.Module):
    """
    Induced Set Attention Block (ISAB)
    Complexity: O(nm) instead of O(n^2) where m << n
    """
    def __init__(self, dim_input, dim_output, num_heads, num_inds, ln=False):
        super().__init__()
        self.I = nn.Parameter(torch.Tensor(1, num_inds, dim_output))
        nn.init.xavier_uniform_(self.I)
        self.mab0 = MultiheadAttentionBlock(dim_output, dim_input, dim_output, num_heads, ln=ln)
        self.mab1 = MultiheadAttentionBlock(dim_input, dim_output, dim_output, num_heads, ln=ln)
    
    def forward(self, X):
        H = self.mab0(self.I.repeat(X.size(0), 1, 1), X)
        return self.mab1(X, H)`
          }
        },
        {
          title: '82 Meta-Features Extraites',
          icon: 'filter',
          content: `Le modèle extrait 82 features pour chaque prédiction de pick.`,
          table: {
            headers: ['Catégorie', 'Nombre', 'Exemples'],
            rows: [
              ['Matchup', '8', 'Winrate, gold_diff@15, xp_diff@15, lane_priority'],
              ['Synergy', '5', 'Winrate, wombo_potential, engage_synergy, peel_synergy'],
              ['Champion Stats', '14', 'Winrate global, pickrate, banrate, KDA, scaling'],
              ['Composition', '18', 'AD/AP ratio, classes, melee/ranged, mobility'],
              ['Macro', '15', 'Engage, teamfight, splitpush, waveclear, siege'],
              ['Contexte', '8', 'Draft phase, team size diff, pick order, side'],
              ['Dérivées', '14', 'Variance, threat density, power spike alignment']
            ]
          }
        },
        {
          title: "Dataset d'Entraînement",
          icon: 'database',
          content: `Le modèle a été entraîné sur un dataset massif collecté via Riot API.`,
          table: {
            headers: ['Métrique', 'Valeur'],
            rows: [
              ['Matchs collectés', '38,161'],
              ["Exemples d'entraînement", '381,610 (10 joueurs x match)'],
              ['Split train/validation', '80% / 20%'],
              ['Taille dataset', '43.9 MB'],
              ['Matrices matchup', '3.34 MB'],
              ['Matrices synergie', '1.34 MB']
            ]
          }
        },
        {
          title: 'Stack Technique',
          icon: 'tools',
          content: `L'application utilise une stack moderne combinant Python pour le backend/ML et Streamlit pour l'interface.`,
          table: {
            headers: ['Technologie', 'Utilisation'],
            rows: [
              ['Streamlit', 'Framework web Python pour applications data'],
              ['Plotly', 'Graphiques interactifs (timelines, radar, bars)'],
              ['PyTorch', 'Framework Deep Learning'],
              ['Set Transformer', 'Architecture permutation-invariante'],
              ['Riot Games API', 'Account-v1, Summoner-v4, Match-v5, League-v4'],
              ['LCU API', 'Connexion client local League of Legends'],
              ['Data Dragon CDN', 'Assets (icônes champions, items, sorts)']
            ]
          }
        },
        {
          title: 'Points Forts',
          icon: 'star',
          content: null,
          highlights: [
            { title: 'Data Engineering', description: 'Pipeline de collecte et enrichissement de données via API' },
            { title: 'Machine Learning', description: "Implémentation d'une architecture deep learning de recherche (Set Transformer)" },
            { title: 'Feature Engineering', description: 'Extraction de 82 features pertinentes pour le domaine' },
            { title: 'Design UI/UX', description: 'Thème premium avec glassmorphism et attention aux détails visuels' },
            { title: 'Intégration Système', description: 'Connexion au client LoL local pour automatisation' }
          ]
        },
        {
          title: 'Structure du Projet',
          icon: 'folder',
          content: null,
          codeBlock: {
            language: 'text',
            code: `ML_LOL/
├── app.py                      # Application principale
├── config.py                   # Configuration (URLs, ML params)
│
├── pages/                      # Pages Streamlit
│   ├── Player_Stats.py         # Dashboard statistiques joueur
│   └── Draft_In_Game.py        # Assistant draft IA
│
├── api/                        # Wrapper Riot API
│   ├── client.py               # Client HTTP avec rate limiting
│   ├── account.py              # API Account-v1 (Riot ID → PUUID)
│   ├── match.py                # API Match-v5
│   ├── lcu_client.py           # Client LCU local
│   └── lcu_draft.py            # Capture draft depuis LCU
│
├── components/                 # Composants UI
│   ├── styles.py               # CSS personnalise (600+ lignes)
│   ├── profile_card.py         # Carte profil joueur
│   ├── ranked_card.py          # Carte stats ranked
│   ├── match_card.py           # Carte match detaillee
│   └── analytics.py            # Graphiques Plotly (5 types)
│
├── ml/                         # Module Machine Learning
│   ├── set_transformer.py      # Architecture Set Transformer
│   ├── model_trainer.py        # Script d'entrainement
│   ├── predictor.py            # Predicteur pour inference
│   ├── features/               # Extracteurs de features (82)
│   └── data/                   # Datasets et modeles
│
└── utils/                      # Utilitaires
    ├── champions.py            # Liste et donnees champions
    └── champion_roles.py       # Mapping champions → roles`
          }
        }
      ],
      en: [
        {
          title: 'Premium Player Profile',
          icon: 'star',
          content: `Search by Riot ID (Name#TAG format), HD summoner icon display with level, and modern glassmorphism design inspired by OP.GG and U.GG.`
        },
        {
          title: 'Ranked Statistics',
          icon: 'chart',
          content: `Side-by-side Solo/Duo and Flex visualization with rank badge and dynamic color coding by tier (Iron to Challenger). Animated LP progress bar, win/loss ratio and calculated winrate.`,
          image: '/img/lol-02.png',
          imageSize: 'medium',
          imageCaption: 'Ranked Solo/Duo and Flex statistics'
        },
        {
          title: 'Match History',
          icon: 'list',
          content: `Detailed cards per match with colored win/loss banner. Champion icon + role badge (Top, Jungle, Mid, ADC, Support). KDA with performance-based color coding, display of 6 items + trinket, advanced stats (CS/min, DMG/min, Vision/min, Gold/min) and expandable details.`,
          image: '/img/lol-03.png',
          imageSize: 'large',
          imageCaption: 'Match history with details'
        },
        {
          title: 'Champion Pool',
          icon: 'grid',
          content: `Champion card grid with gradient color winrate bar (green > 55%, orange 45-55%, red < 45%). Average KDA and detailed stats per champion, average CS/min and DMG/min, game counter with interactive slider.`,
          image: '/img/lol-04.png',
          imageSize: 'medium',
          imageCaption: 'Champion Pool with statistics'
        },
        {
          title: 'Advanced Analytics',
          icon: 'chart',
          content: `Interactive Plotly charts: KDA Timeline (evolution over 20 matches with moving average), CS Progression (bar chart of farming per match), Winrate Timeline (rolling winrate curve over 10 games), Performance Radar (multi-axis radar visualization) and Champion Comparison (Top 5 champions with dual winrate + KDA axis).`,
          image: '/img/lol-05.png',
          imageSize: 'large',
          imageCaption: 'Interactive analytics charts'
        },
        {
          title: 'AI Draft Assistant',
          icon: 'robot',
          content: `An intelligent assistant that recommends the best champion choice during the draft phase, based on your current team composition, the enemy composition, your role, and calculated synergies/matchups. Automatic synchronization with the local LoL client via LCU API for real-time detection of picks and bans.`,
          image: '/img/lol-06.png',
          imageSize: 'large',
          imageCaption: 'Draft assistant with AI recommendations'
        },
        {
          title: 'Manual Draft Interface',
          icon: 'tools',
          content: `Visual Draft Board with 5 Ally slots vs 5 Enemy slots. Champion selection via autocomplete search, "Awaiting placement" zone to organize picks, role selection and "Analyze & Predict" button to launch the prediction.`
        },
        {
          title: 'Set Transformer Architecture',
          icon: 'structure',
          content: `The model uses the Set Transformer architecture based on the research paper "Set Transformer: A Framework for Attention-based Permutation-Invariant Neural Networks" (Lee et al., 2019). This architecture natively handles variable-size compositions (partial draft) with a multi-head attention mechanism to capture interactions between champions.`,
          codeBlock: {
            language: 'python',
            code: `class SetTransformer(nn.Module):
    """
    Complete Set Transformer for Draft Prediction
    """
    def __init__(
        self,
        num_champions,
        num_roles=5,
        embedding_dim=128,
        hidden_dim=256,
        num_heads=8,
        num_inducing_points=32,
        num_encoder_layers=3,
        ln=True
    ):
        super().__init__()
        
        # Champion embedding layer
        self.champion_embedding = nn.Embedding(num_champions, embedding_dim)
        
        # Role embedding layer
        self.role_embedding = nn.Embedding(num_roles, embedding_dim)
        
        # Allied champions encoder (handles variable-size sets)
        self.allied_encoder = nn.ModuleList()
        for i in range(num_encoder_layers):
            input_dim = embedding_dim if i == 0 else hidden_dim
            self.allied_encoder.append(
                InducedSetAttentionBlock(
                    input_dim, hidden_dim, num_heads, 
                    num_inducing_points, ln=ln
                )
            )
        
        # MLP prediction head
        # Input: allied_pool + enemy_pool + role + candidate_champ + meta_features
        mlp_input_dim = hidden_dim * 2 + embedding_dim * 2 + 82  # 82 meta features
        
        self.mlp = nn.Sequential(
            nn.Linear(mlp_input_dim, hidden_dim * 2),
            nn.LayerNorm(hidden_dim * 2),
            nn.ReLU(),
            nn.Dropout(0.3),
            nn.Linear(hidden_dim * 2, hidden_dim),
            nn.LayerNorm(hidden_dim),
            nn.ReLU(),
            nn.Dropout(0.2),
            nn.Linear(hidden_dim, hidden_dim // 2),
            nn.ReLU(),
            nn.Linear(hidden_dim // 2, 1),
            nn.Sigmoid()
        )`
          }
        },
        {
          title: 'Induced Set Attention Block (ISAB)',
          icon: 'code',
          content: `The ISAB block uses inducing points to reduce complexity from O(n²) to O(nm) where m << n, enabling efficient processing of large compositions.`,
          codeBlock: {
            language: 'python',
            code: `class InducedSetAttentionBlock(nn.Module):
    """
    Induced Set Attention Block (ISAB)
    Complexity: O(nm) instead of O(n^2) where m << n
    """
    def __init__(self, dim_input, dim_output, num_heads, num_inds, ln=False):
        super().__init__()
        self.I = nn.Parameter(torch.Tensor(1, num_inds, dim_output))
        nn.init.xavier_uniform_(self.I)
        self.mab0 = MultiheadAttentionBlock(dim_output, dim_input, dim_output, num_heads, ln=ln)
        self.mab1 = MultiheadAttentionBlock(dim_input, dim_output, dim_output, num_heads, ln=ln)
    
    def forward(self, X):
        H = self.mab0(self.I.repeat(X.size(0), 1, 1), X)
        return self.mab1(X, H)`
          }
        },
        {
          title: '82 Extracted Meta-Features',
          icon: 'filter',
          content: `The model extracts 82 features for each pick prediction.`,
          table: {
            headers: ['Category', 'Count', 'Examples'],
            rows: [
              ['Matchup', '8', 'Winrate, gold_diff@15, xp_diff@15, lane_priority'],
              ['Synergy', '5', 'Winrate, wombo_potential, engage_synergy, peel_synergy'],
              ['Champion Stats', '14', 'Global winrate, pickrate, banrate, KDA, scaling'],
              ['Composition', '18', 'AD/AP ratio, classes, melee/ranged, mobility'],
              ['Macro', '15', 'Engage, teamfight, splitpush, waveclear, siege'],
              ['Context', '8', 'Draft phase, team size diff, pick order, side'],
              ['Derived', '14', 'Variance, threat density, power spike alignment']
            ]
          }
        },
        {
          title: 'Training Dataset',
          icon: 'database',
          content: `The model was trained on a massive dataset collected via Riot API.`,
          table: {
            headers: ['Metric', 'Value'],
            rows: [
              ['Matches collected', '38,161'],
              ['Training examples', '381,610 (10 players x match)'],
              ['Train/validation split', '80% / 20%'],
              ['Dataset size', '43.9 MB'],
              ['Matchup matrices', '3.34 MB'],
              ['Synergy matrices', '1.34 MB']
            ]
          }
        },
        {
          title: 'Technical Stack',
          icon: 'tools',
          content: `The application uses a modern stack combining Python for backend/ML and Streamlit for the interface.`,
          table: {
            headers: ['Technology', 'Usage'],
            rows: [
              ['Streamlit', 'Python web framework for data applications'],
              ['Plotly', 'Interactive charts (timelines, radar, bars)'],
              ['PyTorch', 'Deep Learning framework'],
              ['Set Transformer', 'Permutation-invariant architecture'],
              ['Riot Games API', 'Account-v1, Summoner-v4, Match-v5, League-v4'],
              ['LCU API', 'Local League of Legends client connection'],
              ['Data Dragon CDN', 'Assets (champion icons, items, spells)']
            ]
          }
        },
        {
          title: 'Key Strengths',
          icon: 'star',
          content: null,
          highlights: [
            { title: 'Data Engineering', description: 'Data collection and enrichment pipeline via API' },
            { title: 'Machine Learning', description: 'Implementation of a research deep learning architecture (Set Transformer)' },
            { title: 'Feature Engineering', description: 'Extraction of 82 domain-relevant features' },
            { title: 'UI/UX Design', description: 'Premium theme with glassmorphism and attention to visual details' },
            { title: 'System Integration', description: 'Connection to local LoL client for automation' }
          ]
        },
        {
          title: 'Project Structure',
          icon: 'folder',
          content: null,
          codeBlock: {
            language: 'text',
            code: `ML_LOL/
├── app.py                      # Main application
├── config.py                   # Configuration (URLs, ML params)
│
├── pages/                      # Streamlit pages
│   ├── Player_Stats.py         # Player stats dashboard
│   └── Draft_In_Game.py        # AI draft assistant
│
├── api/                        # Riot API wrapper
│   ├── client.py               # HTTP client with rate limiting
│   ├── account.py              # Account-v1 API (Riot ID → PUUID)
│   ├── match.py                # Match-v5 API
│   ├── lcu_client.py           # Local LCU client
│   └── lcu_draft.py            # Draft capture from LCU
│
├── components/                 # UI components
│   ├── styles.py               # Custom CSS (600+ lines)
│   ├── profile_card.py         # Player profile card
│   ├── ranked_card.py          # Ranked stats card
│   ├── match_card.py           # Detailed match card
│   └── analytics.py            # Plotly charts (5 types)
│
├── ml/                         # Machine Learning module
│   ├── set_transformer.py      # Set Transformer architecture
│   ├── model_trainer.py        # Training script
│   ├── predictor.py            # Inference predictor
│   ├── features/               # Feature extractors (82)
│   └── data/                   # Datasets and models
│
└── utils/                      # Utilities
    ├── champions.py            # Champion list and data
    └── champion_roles.py       # Champions → roles mapping`
          }
        }
      ]
    }
  },
  'solidityguard': {
    id: 'solidityguard',
    title: 'SolidityGuard',
    subtitle: {
      fr: 'Système d\'Audit de Sécurité Intelligent pour Smart Contracts',
      en: 'Intelligent Security Audit System for Smart Contracts'
    },
    description: {
      fr: `SolidityGuard est une solution de cybersécurité full-stack conçue pour auditer les contrats intelligents Solidity avant leur déploiement sur la blockchain (Ethereum, BSC, Polygon).

L'application résout un problème critique : la lenteur et le coût des audits manuels. Grâce à l'intégration d'un modèle de langage (LLM) local, SolidityGuard analyse la logique sémantique du code pour détecter des failles de sécurité complexes (Réentrance, Honeypots, Backdoors) là où les outils traditionnels ne voient que du code source.`,
      en: `SolidityGuard is a full-stack cybersecurity solution designed to audit Solidity smart contracts before their deployment on the blockchain (Ethereum, BSC, Polygon).

The application addresses a critical problem: the slowness and cost of manual audits. By integrating a local Large Language Model (LLM), SolidityGuard analyzes the semantic logic of the code to detect complex security flaws (Reentrancy, Honeypots, Backdoors) where traditional tools only see source code.`
    },
    technologies: ['HTML5', 'CSS3 Modern', 'JavaScript ES6', 'Python 3', 'Flask', 'Ollama', 'Llama 3.2', 'Prompt Engineering'],
    features: {
      fr: [
        'Interface d\'upload interactive',
        'Analyse sémantique par IA',
        'Détection de failles critiques',
        'Inférence 100% locale',
        'Dashboard de résultats dynamique',
        'Système de scénarios de démo',
        'Design Cyber-Security Premium'
      ],
      en: [
        'Interactive upload interface',
        'AI semantic analysis',
        'Critical flaw detection',
        '100% local inference',
        'Dynamic results dashboard',
        'Demo scenario system',
        'Premium Cyber-Security Design'
      ]
    },
    images: ['/img/smart-04.png'],
    color: '#38bdf8',
    year: '2025',
    hideScreenshots: false,
    sections: {
      fr: [
        {
          title: 'Audit de Sécurité Intelligent',
          icon: 'shield',
          content: `Une solution complète pour sécuriser vos smart contracts avant déploiement. SolidityGuard utilise l'intelligence artificielle pour identifier des vulnérabilités complexes que l'analyse statique traditionnelle pourrait manquer.`,
          image: '/img/smart-01.png',
          imageSize: 'large',
          imageCaption: 'Interface principale de SolidityGuard'
        },
        {
          title: 'Interface d\'Upload interactive',
          icon: 'upload',
          content: `L'application propose une zone de dépôt interactive (Drag & Drop) gérée nativement en JavaScript. La validation côté client vérifie l'extension .sol et la taille du fichier avant l'envoi, avec un feedback visuel dynamique au survol et à la sélection.`
        },
        {
          title: 'Pipeline d\'Analyse Temps Réel',
          icon: 'cpu',
          content: `Pour améliorer l'expérience utilisateur pendant l'inférence de l'IA, j'ai implémenté un système de chargement progressif affichant l'avancée étape par étape (Scan, Détection, Vérification, Rapport).`,
          codeBlock: {
            language: 'javascript',
            code: `// Extrait de la logique de chargement dans script.js
async function startAnalysis() {
    showSection('loading');
    const fileContent = await readFileContent(currentFile);
    const response = await fetch('/api/analyze', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code: fileContent })
    });
    // ... logic de gestion de réponse
}`
          }
        },
        {
          title: 'Analyse Sémantique par IA',
          icon: 'brain',
          content: `Le code est envoyé au backend Python qui interroge Llama 3.2 via Ollama en local. Un prompt engineering rigoureux force l'IA à agir comme un auditeur senior, convertissant l'analyse sémantique en un rapport complet avec descriptions et recommandations.`,
          image: '/img/smart-02.png',
          imageSize: 'large',
          imageCaption: 'Analyse d\'un fichier Solidity en cours'
        },
        {
          title: 'Dashboard de Résultats Dynamique',
          icon: 'chart',
          content: `Le rapport final est généré dynamiquement en injectant les données de l'API dans le DOM. Un code couleur intuitif indique la sévérité des failles détectées : Sûr (Vert), Moyen (Jaune), Élevé (Orange) et Critique (Rouge).`,
          image: '/img/smart-03.png',
          imageSize: 'large',
          imageCaption: 'Rapport d\'analyse détaillé'
        },
        {
          title: 'Détection des Failles Common Web3',
          icon: 'search',
          content: `Le système est configuré pour détecter les vecteurs d'attaque les plus courants :`,
          table: {
            headers: ['Type de Faille', 'Description du Risque', 'Action IA'],
            rows: [
              ['Reentrancy', 'Vider les fonds via appels récursifs', 'Identifier les calls avant mise à jour'],
              ['Dangerous Delegatecall', 'Exécution de code arbitraire', 'Analyser l\'origine de l\'adresse'],
              ['Integer Overflow', 'Erreurs de calcul critiques', 'Vérifier SafeMath et version'],
              ['Honeypot Patterns', 'Blocage du retrait des jetons', 'Détecter les blocages logiques']
            ]
          }
        },
        {
          title: 'Design Cyber-Security Premium',
          icon: 'palette',
          content: `L'esthétique repose sur un design moderne avec glassmorphism, effets de background animés par particules et variables CSS centralisées.`,
          codeBlock: {
            language: 'css',
            code: `:root {
    --color-bg-primary: #0a0f1e;
    --color-primary-light: #38bdf8;
    --glass-bg: rgba(255, 255, 255, 0.03);
    --transition-smooth: all 0.4s ease-out;
}`
          }
        },
        {
          title: 'Inférence Locale et Confidentialité',
          icon: 'lock',
          content: `Contrairement aux outils cloud, SolidityGuard tourne à 100% en local. Le code source ne quitte jamais l'infrastructure de l'utilisateur, garantissant que les données sensibles ne sont jamais exposées.`
        }
      ],
      en: [
        {
          title: 'Intelligent Security Audit',
          icon: 'shield',
          content: `A comprehensive solution to secure your smart contracts before deployment. SolidityGuard uses artificial intelligence to identify complex vulnerabilities that traditional static analysis might miss.`,
          image: '/img/smart-01.png',
          imageSize: 'large',
          imageCaption: 'Main SolidityGuard interface'
        },
        {
          title: 'Interactive Upload Interface',
          icon: 'upload',
          content: `The application features an interactive drop zone (Drag & Drop) managed natively in JavaScript. Client-side validation checks the .sol extension and file size before sending, with dynamic visual feedback.`
        },
        {
          title: 'Real-Time Analysis Pipeline',
          icon: 'cpu',
          content: `To improve the user experience during AI inference, I implemented a progressive loading system showing step-by-step progress (Scan, Detection, Verification, Report).`,
          codeBlock: {
            language: 'javascript',
            code: `// Loading logic extract from script.js
async function startAnalysis() {
    showSection('loading');
    const fileContent = await readFileContent(currentFile);
    const response = await fetch('/api/analyze', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code: fileContent })
    });
    // ... response handling logic
}`
          }
        },
        {
          title: 'AI Semantic Analysis',
          icon: 'brain',
          content: `The code is sent to the Python backend which queries Llama 3.2 via Ollama locally. Rigorous prompt engineering forces the AI to act as a senior auditor, converting semantic analysis into a complete report.`,
          image: '/img/smart-02.png',
          imageSize: 'large',
          imageCaption: 'Solidity file analysis in progress'
        },
        {
          title: 'Dynamic Results Dashboard',
          icon: 'chart',
          content: `The final report is dynamically generated. An intuitive color code indicates the severity of detected flaws: Safe (Green), Medium (Yellow), High (Orange), and Critical (Red).`,
          image: '/img/smart-03.png',
          imageSize: 'large',
          imageCaption: 'Detailed analysis report'
        },
        {
          title: 'Common Web3 Flaw Detection',
          icon: 'search',
          content: `The system is configured to detect the most frequent attack vectors:`,
          table: {
            headers: ['Flaw Type', 'Risk Description', 'AI Action'],
            rows: [
              ['Reentrancy', 'Drain funds via recursive calls', 'Identify calls before updates'],
              ['Dangerous Delegatecall', 'Arbitrary code execution', 'Analyze call address origin'],
              ['Integer Overflow', 'Critical calculation errors', 'Check SafeMath and version'],
              ['Honeypot Patterns', 'Token withdrawal blockage', 'Detect logical blockages']
            ]
          }
        },
        {
          title: 'Premium Cyber-Security Design',
          icon: 'palette',
          content: `The aesthetics rely on modern design with glassmorphism, particle-animated backgrounds, and centralized CSS variables.`,
          codeBlock: {
            language: 'css',
            code: `:root {
    --color-bg-primary: #0a0f1e;
    --color-primary-light: #38bdf8;
    --glass-bg: rgba(255, 255, 255, 0.03);
    --transition-smooth: all 0.4s ease-out;
}`
          }
        },
        {
          title: 'Local Inference and Privacy',
          icon: 'lock',
          content: `Unlike cloud tools, SolidityGuard runs 100% locally. Source code never leaves the user's infrastructure, ensuring sensitive data is never exposed.`
        }
      ]
    }
  }
};

// Map index to project ID
const projectIdMap = ['csv-visualiser', 'applyflow', 'perftracker', 'csv-analyst', 'lol-draft-predictor', 'solidityguard'];

// Get current project
const project = computed(() => {
  const id = projectId.value;
  // Support both numeric index and string ID
  if (!isNaN(id)) {
    return projectsData[projectIdMap[parseInt(id)]];
  }
  return projectsData[id];
});

const translations = {
  fr: {
    backToProjects: 'Retour aux projets',
    technologies: 'Technologies',
    features: 'Fonctionnalités',
    screenshots: 'Captures d\'écran',
    year: 'Année',
    home: 'Accueil',
    projects: 'Projets',
    about: 'À propos',
    contact: 'Contact',
    backToTop: 'Revenir en haut',
  },
  en: {
    backToProjects: 'Back to projects',
    technologies: 'Technologies',
    features: 'Features',
    screenshots: 'Screenshots',
    year: 'Year',
    home: 'Home',
    projects: 'Projects',
    about: 'About',
    contact: 'Contact',
    backToTop: 'Back to top',
  }
};

const t = computed(() => translations[currentLang.value]);

function toggleLanguage() {
  currentLang.value = currentLang.value === 'fr' ? 'en' : 'fr';
}

function goToProjects() {
  router.push('/projects');
}

// Copy code to clipboard
function copyCode(code) {
  navigator.clipboard.writeText(code).then(() => {
    // Could add toast notification here
    console.log('Code copied to clipboard');
  });
}

// Parallax effect
const scrollY = ref(0);
const heroParallax = computed(() => ({
  transform: `translateY(${scrollY.value * 0.3}px)`
}));

function handleScroll() {
  scrollY.value = window.scrollY;
}

// Show back to top button when scrolled down
const showBackToTop = computed(() => scrollY.value > 200);

// Scroll to top function
function scrollToTop() {
  const pageTop = document.getElementById('page-top');
  if (pageTop) {
    pageTop.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
}

// Intersection observer for animations
const observedElements = ref([]);

onMounted(() => {
  window.addEventListener('scroll', handleScroll);
  
  // Animate elements on scroll
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-in');
      }
    });
  }, { threshold: 0.1 });
  
  document.querySelectorAll('.animate-on-scroll').forEach((el) => {
    observer.observe(el);
  });
});

onBeforeUnmount(() => {
  window.removeEventListener('scroll', handleScroll);
});
</script>

<template>
  <div id="page-top" class="page" v-if="project">
    <!-- Cosmic Background -->
    <CosmicBackground :accentColor="project.color" />
    
    <!-- Navbar -->
    <nav class="navbar">
      <button 
        class="shiny-cta" 
        @click="goToProjects"
        :style="{ '--shiny-cta-highlight': project.color, '--shiny-cta-highlight-subtle': project.color + 'aa' }"
      >
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M19 12H5M12 19l-7-7 7-7"/>
        </svg>
        <span>{{ t.backToProjects }}</span>
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
    
    <!-- Hero Section -->
    <header class="hero" :style="heroParallax">
      <div class="hero-content">
        <div class="hero-badge" :style="{ borderColor: project.color }">
          <span :style="{ color: project.color }">{{ t.year }}: {{ project.year }}</span>
        </div>
        <h1 class="hero-title">{{ project.title }}</h1>
        <p class="hero-subtitle">{{ project.subtitle[currentLang] }}</p>
        
        <!-- YouTube Demo Button -->
        <a 
          v-if="project.demoVideo" 
          :href="project.demoVideo" 
          target="_blank" 
          rel="noopener noreferrer"
          class="demo-video-btn"
          :style="{ '--accent': project.color }"
        >
          <svg class="youtube-icon" viewBox="0 0 24 24" fill="currentColor">
            <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
          </svg>
          <span>{{ currentLang === 'fr' ? 'Voir la démo' : 'Watch demo' }}</span>
        </a>
      </div>
      
      <div class="hero-image-container">
        <div class="hero-image-glow" :style="{ background: `radial-gradient(circle, ${project.color}60 0%, transparent 70%)` }"></div>
        <img :src="project.images[0]" :alt="project.title" class="hero-image" />
      </div>
      
      <div class="scroll-indicator">
        <span>Scroll</span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M12 5v14M5 12l7 7 7-7"/>
        </svg>
      </div>
    </header>
    
    <!-- Main Content -->
    <main class="content">
      <!-- Description Section -->
      <section class="section description-section animate-on-scroll">
        <div class="section-content">
          <div class="description-text">
            <p v-for="(paragraph, index) in project.description[currentLang].split('\n\n')" :key="index">
              {{ paragraph }}
            </p>
          </div>
        </div>
      </section>
      
      <!-- Technologies Section -->
      <section class="section tech-section animate-on-scroll">
        <div class="section-content">
          <h2 class="section-title">
            <span class="title-icon" :style="{ background: project.color }">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
              </svg>
            </span>
            {{ t.technologies }}
          </h2>
          <div class="tech-grid">
            <div 
              v-for="(tech, index) in project.technologies" 
              :key="index" 
              class="tech-card"
              :style="{ '--delay': `${index * 0.1}s`, '--accent': project.color }"
            >
              <span class="tech-name">{{ tech }}</span>
            </div>
          </div>
        </div>
      </section>
      
      <!-- Features Section -->
      <section class="section features-section animate-on-scroll">
        <div class="section-content">
          <h2 class="section-title">
            <span class="title-icon" :style="{ background: project.color }">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </span>
            {{ t.features }}
          </h2>
          <div class="features-list">
            <div 
              v-for="(feature, index) in project.features[currentLang]" 
              :key="index" 
              class="feature-item"
              :style="{ '--delay': `${index * 0.1}s` }"
            >
              <div class="feature-icon" :style="{ background: project.color }">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                  <path d="M5 12l5 5L20 7"/>
                </svg>
              </div>
              <span class="feature-text">{{ feature }}</span>
            </div>
          </div>
        </div>
      </section>
      
      <!-- Extended Sections (if available) -->
      <template v-if="project.sections && project.sections[currentLang]">
        <section 
          v-for="(section, sIndex) in project.sections[currentLang]" 
          :key="'section-' + sIndex"
          class="section extended-section animate-on-scroll"
        >
          <div class="section-content">
            <h2 class="section-title">
              <span class="title-icon" :style="{ background: project.color }">
                <svg v-if="section.icon === 'tools'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/>
                </svg>
                <svg v-else-if="section.icon === 'structure'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
                </svg>
                <svg v-else-if="section.icon === 'palette'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <circle cx="12" cy="12" r="10"/><circle cx="12" cy="8" r="2" fill="currentColor"/><circle cx="8" cy="14" r="2" fill="currentColor"/><circle cx="16" cy="14" r="2" fill="currentColor"/>
                </svg>
                <svg v-else-if="section.icon === 'code'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/>
                </svg>
                <svg v-else-if="section.icon === 'filter'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/>
                </svg>
                <svg v-else-if="section.icon === 'star'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                </svg>
                <svg v-else-if="section.icon === 'folder'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/>
                </svg>
                <svg v-else-if="section.icon === 'download'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4M7 10l5 5 5-5M12 15V3"/>
                </svg>
                <svg v-else-if="section.icon === 'chart'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M18 20V10M12 20V4M6 20v-6"/>
                </svg>
                <svg v-else-if="section.icon === 'list'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/><line x1="8" y1="18" x2="21" y2="18"/><circle cx="4" cy="6" r="1" fill="currentColor"/><circle cx="4" cy="12" r="1" fill="currentColor"/><circle cx="4" cy="18" r="1" fill="currentColor"/>
                </svg>
                <svg v-else-if="section.icon === 'grid'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
                </svg>
                <svg v-else-if="section.icon === 'robot'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="8" width="18" height="12" rx="2"/><circle cx="9" cy="14" r="2"/><circle cx="15" cy="14" r="2"/><path d="M12 2v4M4 8V6a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v2"/>
                </svg>
                <svg v-else-if="section.icon === 'database'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <ellipse cx="12" cy="5" rx="9" ry="3"/><path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"/><path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"/>
                </svg>
                <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <circle cx="12" cy="12" r="10"/>
                </svg>
              </span>
              {{ section.title }}
            </h2>
            
            <!-- Section content text -->
            <p v-if="section.content" class="section-text">{{ section.content }}</p>
            
            <!-- Data table -->
            <div v-if="section.table" class="data-table-wrapper">
              <table class="data-table">
                <thead>
                  <tr>
                    <th v-for="(header, hIndex) in section.table.headers" :key="hIndex" :style="{ borderColor: project.color }">
                      {{ header }}
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(row, rIndex) in section.table.rows" :key="rIndex">
                    <td v-for="(cell, cIndex) in row" :key="cIndex">{{ cell }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
            
            <!-- Code block -->
            <div v-if="section.codeBlock" class="code-block-wrapper">
              <div class="code-block-header">
                <span class="code-language">{{ section.codeBlock.language }}</span>
                <button class="copy-code-btn" @click="copyCode(section.codeBlock.code)">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>
                  </svg>
                  <span>{{ currentLang === 'fr' ? 'Copier' : 'Copy' }}</span>
                </button>
              </div>
              <pre class="code-block"><code>{{ section.codeBlock.code }}</code></pre>
            </div>
            
            <!-- Highlights grid -->
            <div v-if="section.highlights" class="highlights-grid">
              <div 
                v-for="(highlight, hIndex) in section.highlights" 
                :key="hIndex" 
                class="highlight-card"
                :style="{ '--accent': project.color, '--delay': `${hIndex * 0.1}s` }"
              >
                <h4 class="highlight-title">{{ highlight.title }}</h4>
                <p class="highlight-description">{{ highlight.description }}</p>
              </div>
            </div>
            
            <!-- Section image with size support -->
            <div v-if="section.image" class="section-image-wrapper" :class="['size-' + (section.imageSize || 'large')]">
              <img :src="section.image" :alt="section.title" class="section-image" />
              <p v-if="section.imageCaption" class="image-caption">{{ section.imageCaption }}</p>
            </div>
            
            <!-- Image grid for side-by-side images -->
            <div v-if="section.imageGrid" class="section-image-grid">
              <div 
                v-for="(gridImage, gIndex) in section.imageGrid" 
                :key="gIndex" 
                class="grid-image-wrapper"
              >
                <img :src="gridImage.image" :alt="gridImage.caption || section.title" class="grid-image" />
                <p v-if="gridImage.caption" class="image-caption">{{ gridImage.caption }}</p>
              </div>
            </div>
          </div>
        </section>
      </template>
      
      <!-- Screenshots Section -->
      <section v-if="!project.hideScreenshots" class="section screenshots-section animate-on-scroll">
        <div class="section-content">
          <h2 class="section-title">
            <span class="title-icon" :style="{ background: project.color }">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
              </svg>
            </span>
            {{ t.screenshots }}
          </h2>
          <div class="screenshots-grid" :class="{ 'multi-screenshots': project.images.length > 1 }">
            <div 
              v-for="(image, imgIndex) in project.images" 
              :key="imgIndex"
              class="screenshot-card"
              :class="{ 'main-screenshot': imgIndex === 0 }"
            >
              <div class="screenshot-glow" :style="{ background: `radial-gradient(circle, ${project.color}40 0%, transparent 70%)` }"></div>
              <img :src="image" :alt="`${project.title} screenshot ${imgIndex + 1}`" />
            </div>
          </div>
        </div>
      </section>
      
      <!-- CTA Section -->
      <section class="section cta-section animate-on-scroll">
        <div class="cta-card">
          <h3>{{ currentLang === 'fr' ? 'Intéressé par ce projet ?' : 'Interested in this project?' }}</h3>
          <p>{{ currentLang === 'fr' ? 'N\'hésitez pas à me contacter pour en savoir plus.' : 'Feel free to contact me to learn more.' }}</p>
          <router-link to="/contact" class="cta-button" :style="{ background: `linear-gradient(135deg, ${project.color}, ${project.color}cc)` }">
            <span>{{ t.contact }}</span>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M5 12h14M12 5l7 7-7 7"/>
            </svg>
          </router-link>
        </div>
      </section>
    </main>
    
    <!-- Back to Top Button -->
    <button 
      class="shiny-cta back-to-top-btn"
      @click="scrollToTop"
      :style="{ '--shiny-cta-highlight': project.color, '--shiny-cta-highlight-subtle': project.color + 'aa' }"
    >
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M12 19V5M5 12l7-7 7 7"/>
      </svg>
      <span>{{ t.backToTop }}</span>
    </button>
  </div>
  
  <!-- Loading / Not Found -->
  <div class="page not-found" v-else>
    <div class="background">
      <div class="gradient-orb orb-1"></div>
    </div>
    <div class="not-found-content">
      <h1>404</h1>
      <p>{{ currentLang === 'fr' ? 'Projet non trouvé' : 'Project not found' }}</p>
      <button @click="goToProjects" class="back-btn">
        {{ t.backToProjects }}
      </button>
    </div>
  </div>
</template>

<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

.page {
  min-height: 100vh;
  width: 100%;
  position: relative;
  z-index: 1;
  font-family: 'Inter', sans-serif;
  color: #fff;
  overflow-x: hidden;
  background: transparent;
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

// Hero
.hero {
  position: relative;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 6rem 2rem 4rem;
  z-index: 1;
}

.hero-content {
  text-align: center;
  margin-bottom: 3rem;
}

.hero-badge {
  display: inline-flex;
  padding: 0.5rem 1.5rem;
  border: 1px solid;
  border-radius: 50px;
  font-size: 0.85rem;
  font-weight: 500;
  margin-bottom: 1.5rem;
  background: rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
}

.hero-title {
  font-size: clamp(3rem, 8vw, 5rem);
  font-weight: 800;
  margin: 0 0 1rem 0;
  background: linear-gradient(135deg, #fff 0%, rgba(255,255,255,0.7) 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  letter-spacing: -0.02em;
}

.hero-subtitle {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.7);
  max-width: 600px;
  margin: 0 auto;
}

// YouTube Demo Button
.demo-video-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  margin-top: 1.5rem;
  padding: 0.85rem 1.75rem;
  background: rgba(255, 0, 0, 0.15);
  border: 1px solid rgba(255, 0, 0, 0.3);
  border-radius: 50px;
  color: #fff;
  font-size: 0.95rem;
  font-weight: 500;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  backdrop-filter: blur(10px);
  
  .youtube-icon {
    width: 24px;
    height: 24px;
    color: #ff0000;
    transition: transform 0.3s ease;
  }
  
  &:hover {
    background: rgba(255, 0, 0, 0.25);
    border-color: rgba(255, 0, 0, 0.5);
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(255, 0, 0, 0.2);
    
    .youtube-icon {
      transform: scale(1.1);
    }
  }
  
  &:active {
    transform: translateY(0);
  }
}

.hero-image-container {
  position: relative;
  width: min(95vw, 1200px);
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 
    0 50px 100px rgba(0, 0, 0, 0.5),
    0 0 0 1px rgba(255, 255, 255, 0.1);
}

.hero-image-glow {
  position: absolute;
  inset: -50%;
  z-index: 0;
  filter: blur(60px);
  opacity: 0.5;
}

.hero-image {
  position: relative;
  width: 100%;
  height: auto;
  object-fit: contain;
  z-index: 1;
  image-rendering: -webkit-optimize-contrast;
}

.scroll-indicator {
  position: absolute;
  bottom: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  color: rgba(255, 255, 255, 0.5);
  font-size: 0.85rem;
  animation: bounce 2s infinite;
  
  svg {
    width: 20px;
    height: 20px;
  }
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(10px); }
}

// Content
.content {
  position: relative;
  z-index: 1;
  padding: 0 2rem 6rem;
  
  // Subtle gradient overlay to improve text readability over water
  &::before {
    content: '';
    position: absolute;
    top: -100px;
    left: 0;
    right: 0;
    height: 300px;
    background: linear-gradient(
      to bottom,
      transparent 0%,
      rgba(0, 0, 0, 0.3) 50%,
      rgba(0, 0, 0, 0.5) 100%
    );
    pointer-events: none;
    z-index: -1;
  }
}

.section {
  max-width: 1000px;
  margin: 0 auto 6rem;
  opacity: 0;
  transform: translateY(40px);
  transition: all 0.8s cubic-bezier(0.16, 1, 0.3, 1);
  
  // Glassmorphism backdrop for readability
  padding: 2rem;
  background: rgba(0, 0, 0, 0.4);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.08);
  
  &.animate-in {
    opacity: 1;
    transform: translateY(0);
  }
}

.section-title {
  display: flex;
  align-items: center;
  gap: 1rem;
  font-size: 1.8rem;
  font-weight: 700;
  margin-bottom: 2rem;
  color: #fff;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
}

.title-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border-radius: 12px;
  
  svg {
    width: 24px;
    height: 24px;
    color: #fff;
  }
}

// Description
.description-section {
  .description-text {
    p {
      font-size: 1.1rem;
      line-height: 1.8;
      color: rgba(255, 255, 255, 0.9);
      margin-bottom: 1.5rem;
      text-shadow: 0 1px 4px rgba(0, 0, 0, 0.4);
      
      &:last-child {
        margin-bottom: 0;
      }
    }
  }
}

// Technologies
.tech-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.tech-card {
  padding: 1rem 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
  animation: fadeInUp 0.6s ease forwards;
  animation-delay: var(--delay);
  opacity: 0;
  
  &:hover {
    background: rgba(255, 255, 255, 0.1);
    border-color: var(--accent);
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  }
  
  .tech-name {
    font-size: 1rem;
    font-weight: 600;
    color: #fff;
  }
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

// Features
.features-list {
  display: grid;
  gap: 1rem;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.25rem 1.5rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  transition: all 0.3s ease;
  animation: fadeInUp 0.6s ease forwards;
  animation-delay: var(--delay);
  opacity: 0;
  
  &:hover {
    background: rgba(255, 255, 255, 0.06);
    transform: translateX(10px);
  }
}

.feature-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 10px;
  flex-shrink: 0;
  
  svg {
    width: 20px;
    height: 20px;
    color: #fff;
  }
}

.feature-text {
  font-size: 1rem;
  color: rgba(255, 255, 255, 0.9);
}

// Extended Sections
.extended-section {
  .section-content {
    overflow: hidden; // Clearfix for floated thumbnails
    
    &::after {
      content: '';
      display: table;
      clear: both;
    }
  }
  
  .section-text {
    font-size: 1.05rem;
    line-height: 1.8;
    color: rgba(255, 255, 255, 0.85);
    margin-bottom: 1.5rem;
    text-shadow: 0 1px 4px rgba(0, 0, 0, 0.3);
  }
}

// Data Tables
.data-table-wrapper {
  overflow-x: auto;
  margin: 1.5rem 0;
  border-radius: 12px;
  background: rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.95rem;
  
  th, td {
    padding: 1rem 1.25rem;
    text-align: left;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  }
  
  th {
    background: rgba(255, 255, 255, 0.05);
    color: #fff;
    font-weight: 600;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    border-bottom: 2px solid;
  }
  
  td {
    color: rgba(255, 255, 255, 0.8);
  }
  
  tbody tr {
    transition: background 0.2s ease;
    
    &:hover {
      background: rgba(255, 255, 255, 0.03);
    }
    
    &:last-child td {
      border-bottom: none;
    }
  }
}

// Code Blocks
.code-block-wrapper {
  margin: 1.5rem 0;
  border-radius: 12px;
  overflow: hidden;
  background: #0d1117;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.code-block-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.75rem 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  
  .code-language {
    font-size: 0.8rem;
    font-weight: 600;
    color: rgba(255, 255, 255, 0.6);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }
  
  .copy-code-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.4rem 0.8rem;
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.7);
    background: rgba(255, 255, 255, 0.1);
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
    
    svg {
      width: 14px;
      height: 14px;
    }
    
    &:hover {
      background: rgba(255, 255, 255, 0.2);
      color: #fff;
    }
  }
}

.code-block {
  margin: 0;
  padding: 1.25rem;
  overflow-x: auto;
  font-family: 'Roboto Mono', 'Fira Code', monospace;
  font-size: 0.85rem;
  line-height: 1.6;
  
  code {
    color: #e6edf3;
    white-space: pre;
  }
}

// Highlights Grid
.highlights-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1rem;
  margin-top: 1rem;
}

.highlight-card {
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  transition: all 0.3s ease;
  animation: fadeInUp 0.6s ease forwards;
  animation-delay: var(--delay);
  opacity: 0;
  
  &:hover {
    background: rgba(255, 255, 255, 0.06);
    border-color: var(--accent);
    transform: translateY(-4px);
  }
  
  .highlight-title {
    font-size: 1.1rem;
    font-weight: 600;
    color: #fff;
    margin: 0 0 0.5rem 0;
  }
  
  .highlight-description {
    font-size: 0.95rem;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.7);
    margin: 0;
  }
}

// Section Image with size variants
.section-image-wrapper {
  margin-top: 1.5rem;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: rgba(0, 0, 0, 0.2);
  
  // Large images (full width) - default
  &.size-large {
    .section-image {
      width: 100%;
    }
  }
  
  // Medium images (max 600px, centered)
  &.size-medium {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 1.5rem;
    
    .section-image {
      max-width: 600px;
      width: auto;
      max-height: 400px;
      object-fit: contain;
    }
  }
  
  // Small images (natural size, centered)
  &.size-small {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 1.5rem;
    
    .section-image {
      width: auto;
      max-width: 100%;
      max-height: 350px;
      object-fit: contain;
    }
  }
  
  // Thumbnail (very small, inline or side)
  &.size-thumbnail {
    display: inline-flex;
    flex-direction: column;
    align-items: center;
    padding: 1rem;
    float: right;
    margin-left: 1.5rem;
    margin-bottom: 1rem;
    max-width: 280px;
    position: relative;
    z-index: 2;
    
    .section-image {
      width: auto;
      max-width: 100%;
      max-height: 250px;
      object-fit: contain;
    }
  }
  
  .section-image {
    display: block;
    transition: transform 0.4s ease;
    border-radius: 12px;
    
    &:hover {
      transform: scale(1.02);
    }
  }
  
  .image-caption {
    margin: 1rem 0 0 0;
    font-size: 0.9rem;
    color: rgba(255, 255, 255, 0.6);
    text-align: center;
    font-style: italic;
  }
}

// Image Grid for side-by-side images
.section-image-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.5rem;
  margin-top: 1.5rem;
  
  @media (max-width: 768px) {
    grid-template-columns: 1fr;
  }
  
  .grid-image-wrapper {
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(0, 0, 0, 0.2);
    
    .grid-image {
      width: 100%;
      display: block;
      transition: transform 0.4s ease;
      
      &:hover {
        transform: scale(1.02);
      }
    }
    
    .image-caption {
      margin: 1rem;
      font-size: 0.9rem;
      color: rgba(255, 255, 255, 0.6);
      text-align: center;
      font-style: italic;
    }
  }
}

// Screenshots - Updated for multiple images
.screenshots-grid {
  display: grid;
  gap: 1.5rem;
  
  &.multi-screenshots {
    grid-template-columns: 1fr;
  }
}

.screenshot-card {
  position: relative;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 
    0 30px 60px rgba(0, 0, 0, 0.4),
    0 0 0 1px rgba(255, 255, 255, 0.1);
  
  img {
    width: 100%;
    display: block;
    transition: transform 0.5s ease;
  }
  
  &:hover img {
    transform: scale(1.02);
  }
}

.screenshot-glow {
  position: absolute;
  inset: -30%;
  z-index: 0;
  filter: blur(60px);
  opacity: 0.4;
  pointer-events: none;
}

// CTA
.cta-section {
  text-align: center;
}

.cta-card {
  padding: 4rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 24px;
  backdrop-filter: blur(20px);
  
  h3 {
    font-size: 2rem;
    font-weight: 700;
    margin: 0 0 1rem 0;
  }
  
  p {
    font-size: 1.1rem;
    color: rgba(255, 255, 255, 0.7);
    margin: 0 0 2rem 0;
  }
}

.cta-button {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  border: none;
  border-radius: 50px;
  color: #fff;
  font-size: 1rem;
  font-weight: 600;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  
  svg {
    width: 20px;
    height: 20px;
    transition: transform 0.3s ease;
  }
  
  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
    
    svg {
      transform: translateX(5px);
    }
  }
}

// Back to Top Button (positioned, uses shiny-cta for appearance)
.back-to-top-btn {
  position: fixed !important;
  bottom: 2rem;
  right: 2rem;
  z-index: 1000;
}

// Transition animations
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.3s ease;
}

.fade-slide-enter-from,
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(20px);
}

// Not Found
.not-found {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
}

.not-found-content {
  text-align: center;
  z-index: 1;
  
  h1 {
    font-size: 8rem;
    font-weight: 800;
    background: linear-gradient(135deg, #ff8c32, #ff6432);
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
    margin: 0;
  }
  
  p {
    font-size: 1.5rem;
    color: rgba(255, 255, 255, 0.7);
    margin: 1rem 0 2rem;
  }
  
  .back-btn {
    padding: 1rem 2rem;
    background: linear-gradient(135deg, #ff8c32, #ff6432);
    border: none;
    border-radius: 50px;
    color: #fff;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    
    &:hover {
      transform: translateY(-3px);
    }
  }
}

// Responsive
@media (max-width: 768px) {
  .navbar {
    padding: 1rem 1.5rem;
  }
  
  .nav-links {
    display: none;
  }
  
  .hero {
    padding: 5rem 1.5rem 3rem;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-subtitle {
    font-size: 1rem;
  }
  
  .content {
    padding: 0 1.5rem 4rem;
  }
  
  .section {
    margin-bottom: 4rem;
  }
  
  .section-title {
    font-size: 1.4rem;
  }
  
  .cta-card {
    padding: 2rem;
    
    h3 {
      font-size: 1.5rem;
    }
  }
}
</style>
