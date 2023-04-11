import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import axios from "axios";
import VueAxios from "vue-axios";
import { store } from "./store/index";
import vuetify from "./plugins/vuetify";

Vue.use(VueAxios, axios);

Vue.config.productionTip = false;

Vue.prototype.env = {
  apiURL: "http://127.0.0.1:8000/api",
  apiImage: "http://127.0.0.1:8000/api/storage/app/images",
};

export const EventBus = new Vue();

new Vue({
  router,
  vuetify,
  store,
  render: (h) => h(App),
}).$mount("#app");
