import { createRouter, createWebHistory } from "vue-router";
import MandateView from "../views/MandateView.vue";
import AccountView from "../views/AccountView.vue";
import BoardView from "../views/BoardView.vue";

const routes = [
    {
        path: "/",
        name: "home",
        component: MandateView,
    },
    {
        path: "/account",
        name: "account",
        component: AccountView,
    },
    {
        path: "/board",
        name: "board",
        component: BoardView
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router;