import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

const routes = [
  {
    path: "/",
    component: () => import("./components/home/HomeIndex.vue"),
    children: [
      {
        path: "home",
        component: () => import('./components/home/main/MainPage.vue')
      }
    ]
  },
  {
    path: "/admin",
    component: () => import("./components/admin/AdminIndex.vue"),
    // children: [
    //   // Dashboard
    //   {
    //     name: 'Dashboard',
    //     path: '',
    //     component: () => import('./components/back/dashboard/Dashboard'),
    //   },
    // ],
  }
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