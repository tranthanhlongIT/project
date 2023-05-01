import Vuex from "vuex";
import Vue from "vue";
import { userStore } from "./modules/user";
import { roomStore } from "./modules/room";
import { historyStore } from "./modules/history";
import { guestStore } from "./modules/guest";

Vue.use(Vuex);
export const store = new Vuex.Store({
  modules: {
    user: userStore,
    room: roomStore,
    history: historyStore,
    guest: guestStore
  },
});
