import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

const routes = [
  {
    path: "/home",
    component: () => import("./components/front/FrontIndex.vue"),
    children: [
      {
        path: "/home",
        component: () => import('./components/front/main/MainPage.vue')
      }
    ]
  },
  {
    path: "/dashboard",
    component: () => import("./components/back/BackIndex.vue"),
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
  linkActiveClass: "nav-item active",
  scrollBehavior: (to) => {
    if (to.hash) {
      return { selector: to.hash };
    } else {
      return { x: 0, y: 0 };
    }
  },
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