import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import axios from "axios";
import VueAxios from "vue-axios";
import { store } from "./store/index";
import vuetify from "./plugins/vuetify";
import * as env from "./plugins/env";
import * as common from "./plugins/common";
import Auth from './plugins/auth';


Vue.use(VueAxios, axios);

Vue.config.productionTip = false;

Vue.prototype.auth = Auth;

export const EventBus = new Vue();

new Vue({
  env,
  common,
  router,
  vuetify,
  store,
  render: (h) => h(App),
}).$mount("#app");
