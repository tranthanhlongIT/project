import Vue from "vue";
import Router from "vue-router";
import Auth from "./plugins/auth";

Vue.use(Router);

const routes = [
  {
    path: "/",
    redirect: "/home/",
    component: () => import("./components/home/HomeIndex.vue"),
    children: [
      {
        name: "home",
        path: "home",
        component: () => import("./components/home/main/MainPage.vue"),
      },
    ],
  },
  {
    path: "/admin/login",
    component: () => import("./components/admin/pages/Login.vue"),
    meta: {
      requiresVisitor: true,
    },
  },
  {
    path: "/admin",
    component: () => import("./components/admin/AdminIndex.vue"),
    children: [
      {
        name: "dashboard",
        path: "dashboard",
        component: () => import("./components/admin/pages/Dashboard.vue"),
      },
      {
        name: "guest",
        path: "guest",
        component: () => import("./components/admin/pages/GuestList.vue")
      },
      {
        name: "room",
        path: "room",
        component: () => import("./components/admin/pages/RoomList.vue"),
      },
      {
        name: "reservation",
        path: "reservation",
        component: () => import("./components/admin/pages/ReservationList.vue"),
      },
      {
        name: "history",
        path: "history",
        component: () => import("./components/admin/pages/HistoryList.vue")
      },
      {
        name: "user",
        path: "user",
        component: () => import("./components/admin/pages/UserList.vue"),
      },
    ],
    meta: {
      requiresAuth: true,
    },
  },
  {
    path: '*',
    component: () => import("./components/errors/404.vue"),
  }
];

const router = new Router({
  mode: "history",
  routes: routes,
});

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requiresAuth)) {
    if (Auth.check()) {
      next();
    } else {
      router.go("/admin/login");
    }
  } else if (to.matched.some((record) => record.meta.requiresVisitor)) {
    if (Auth.check()) {
      router.push("/admin/dashboard");
    } else {
      next();
    }
  } else next();
});

export default router;
