import Vuex from "vuex";
import Vue from "vue";
import { userStore } from "./modules/user";
import { roomStore } from "./modules/room";
import { reservationStore } from "./modules/reservation";
import { guestStore } from "./modules/guest";

Vue.use(Vuex);
export const store = new Vuex.Store({
  modules: {
    user: userStore,
    room: roomStore,
    reservation: reservationStore,
    guest: guestStore
  },
});
