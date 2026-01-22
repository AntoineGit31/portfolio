import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Contact from '../views/Contact.vue';

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/contact',
        name: 'Contact',
        component: Contact,
    },
    {
        path: '/projects',
        name: 'Projects',
        component: () => import('../views/Projects.vue'),
    },
    {
        path: '/project/:id',
        name: 'ProjectDetail',
        component: () => import('../views/ProjectDetail.vue'),
    },
    {
        path: '/about',
        name: 'About',
        component: () => import('../views/About.vue'),
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
