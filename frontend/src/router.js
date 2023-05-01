import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

const routes = [
  {
    path: "/",
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
    path: "/admin",
    component: () => import("./components/admin/AdminIndex.vue"),
    children: [
      {
        name: "dashboard",
        path: "dashboard",
        component: () => import("./components/admin/page/Dashboard.vue"),
      },
      {
        name: "guest",
        path: "guest",
        component: () => import("./components/admin/page/GuestList.vue")
      },
      {
        name: "room",
        path: "room",
        component: () => import("./components/admin/page/RoomList.vue"),
      },
      {
        name: "reservation",
        path: "reservation",
        component: () => import("./components/admin/page/ReservationList.vue"),
      },
      {
        name: "history",
        path: "history",
        component: () => import("./components/admin/page/HistoryList.vue")
      },
      {
        name: "user",
        path: "user",
        component: () => import("./components/admin/page/UserList.vue"),
      },
    ],
  },
];

const router = new Router({
  mode: "history",
  routes: routes,
});

// router.beforeEach((to, from, next) => {
//   if (to.matched.some((record) => record.meta.requiresAuth)) {
//     if (Auth.check()) {
//       next();
//     } else {
//       router.push("login");
//     }
//   } else if (to.matched.some((record) => record.meta.requiresVisitor)) {
//     if (Auth.check()) {
//       router.push("products");
//     } else {
//       next();
//     }
//   } else next();
// });

export default router;
