import Vuex from "vuex";
import Vue from "vue";
import { userStore } from "./modules/user";

Vue.use(Vuex);
export const store = new Vuex.Store({
  modules: {
    user: userStore,
  },
});
