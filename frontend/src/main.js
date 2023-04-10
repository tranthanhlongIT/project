import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import axios from "axios";
import VueAxios from "vue-axios";
import Vuex from "vuex";
import vuetify from "./plugins/vuetify";

Vue.use(Vuex);

Vue.use(VueAxios, axios);

Vue.config.productionTip = false;

export const EventBus = new Vue();

new Vue({
  router,
  vuetify,
  render: (h) => h(App),
}).$mount("#app");