import Vuex from "vuex";
import Vue from "vue";
import { userStore } from "./modules/user";
import { roomStore } from "./modules/room";

Vue.use(Vuex);
export const store = new Vuex.Store({
  modules: {
    user: userStore,
    room: roomStore,
  },
});
