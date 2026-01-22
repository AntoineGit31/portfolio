---
description: Déployer le portfolio sur Vercel (gratuit)
---

# 🚀 Tutoriel Complet : Déployer votre Portfolio sur Vercel

Ce guide vous accompagne étape par étape pour mettre votre portfolio en ligne gratuitement.

---

## 📋 Prérequis

- ✅ Node.js installé (déjà fait)
- ✅ Votre projet portfolio fonctionnel (déjà fait)
- ⬜ Un compte GitHub
- ⬜ Un compte Vercel

---

## Étape 1 : Créer un compte GitHub (si pas déjà fait)

1. Allez sur **[github.com](https://github.com)**
2. Cliquez sur **"Sign up"**
3. Suivez les instructions pour créer votre compte
4. **Vérifiez votre email** pour activer le compte

---

## Étape 2 : Installer Git sur votre ordinateur

### Vérifier si Git est installé
Ouvrez un terminal et tapez :
```bash
git --version
```

### Si Git n'est pas installé :
1. Téléchargez Git : **[git-scm.com/download/windows](https://git-scm.com/download/windows)**
2. Lancez l'installateur et gardez les options par défaut
3. **Redémarrez votre terminal** après l'installation

---

## Étape 3 : Configurer Git (première fois uniquement)

Ouvrez un terminal et exécutez ces commandes en remplaçant par vos informations :

```bash
git config --global user.name "Votre Nom"
git config --global user.email "votre.email@example.com"
```

---

## Étape 4 : Créer un repository GitHub

### Option A : Via le site web GitHub (Recommandé pour les débutants)

1. Allez sur **[github.com/new](https://github.com/new)**
2. Remplissez les informations :
   - **Repository name** : `portfolio` (ou le nom de votre choix)
   - **Description** : `Mon portfolio professionnel`
   - **Visibility** : `Public` (pour que le site soit accessible)
   - ⚠️ **NE PAS cocher** "Add a README file"
3. Cliquez sur **"Create repository"**
4. **Gardez cette page ouverte**, vous aurez besoin des commandes affichées

---

## Étape 5 : Pousser votre code sur GitHub

Ouvrez un terminal **dans le dossier de votre projet** (`c:\Users\Antoine\Desktop\PortfolioV1`) et exécutez ces commandes :

### 5.1 - Initialiser Git dans votre projet
```bash
git init
```

### 5.2 - Ajouter tous les fichiers
```bash
git add .
```

### 5.3 - Créer le premier commit
```bash
git commit -m "Initial commit - Portfolio"
```

### 5.4 - Connecter à GitHub
Remplacez `VOTRE_USERNAME` par votre nom d'utilisateur GitHub :
```bash
git remote add origin https://github.com/VOTRE_USERNAME/portfolio.git
```

### 5.5 - Pousser le code
```bash
git branch -M main
git push -u origin main
```

### 💡 Lors du premier push
- Une fenêtre peut s'ouvrir pour vous authentifier avec GitHub
- Choisissez **"Sign in with your browser"** si proposé
- Autorisez l'accès

---

## Étape 6 : Créer un compte Vercel

1. Allez sur **[vercel.com](https://vercel.com)**
2. Cliquez sur **"Sign Up"**
3. Choisissez **"Continue with GitHub"** (le plus simple !)
4. Autorisez Vercel à accéder à votre compte GitHub

---

## Étape 7 : Déployer sur Vercel

1. Une fois connecté sur Vercel, cliquez sur **"Add New Project"**
2. Vous verrez la liste de vos repositories GitHub
3. Cliquez sur **"Import"** à côté de `portfolio`

### Configuration du projet :
4. **Framework Preset** : Sélectionnez `Vite` (devrait être détecté automatiquement)
5. **Build Command** : `npm run build` (par défaut)
6. **Output Directory** : `dist` (par défaut)
7. Cliquez sur **"Deploy"**

### 🎉 Et voilà !
- Vercel va builder et déployer votre site
- En 1-2 minutes, vous aurez un lien comme : `https://portfolio-xxx.vercel.app`
- **Votre site est maintenant en ligne !**

---

## Étape 8 : Mises à jour futures

Chaque fois que vous modifiez votre portfolio :

```bash
git add .
git commit -m "Description de vos modifications"
git push
```

**➡️ Vercel redéploiera automatiquement votre site !**

---

## 🎨 Bonus : Personnaliser le nom de domaine

### Domaine Vercel gratuit
1. Dans votre projet Vercel, allez dans **"Settings" → "Domains"**
2. Vous pouvez changer le sous-domaine gratuit (ex: `antoine-portfolio.vercel.app`)

### Domaine personnalisé (optionnel, payant)
1. Achetez un domaine sur [Namecheap](https://namecheap.com), [OVH](https://ovh.com), ou [Google Domains](https://domains.google)
2. Dans Vercel, ajoutez votre domaine dans **"Settings" → "Domains"**
3. Suivez les instructions pour configurer les DNS

---

## 🆘 Dépannage

### Erreur "git is not recognized"
→ Redémarrez votre terminal après l'installation de Git

### Erreur d'authentification GitHub
→ Utilisez l'authentification via navigateur ou créez un Personal Access Token

### Le build échoue sur Vercel
→ Vérifiez les logs d'erreur dans le dashboard Vercel
→ Testez localement avec `npm run build`

---

## ✅ Récapitulatif des commandes

```bash
# Installation unique
git config --global user.name "Votre Nom"
git config --global user.email "votre@email.com"

# Premier déploiement
git init
git add .
git commit -m "Initial commit - Portfolio"
git remote add origin https://github.com/VOTRE_USERNAME/portfolio.git
git branch -M main
git push -u origin main

# Mises à jour futures
git add .
git commit -m "Description des changements"
git push
```

---

**Besoin d'aide ?** N'hésitez pas à demander à chaque étape ! 🚀