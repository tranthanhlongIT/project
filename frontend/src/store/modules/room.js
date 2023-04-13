import axios from "axios";

export const roomStore = {
  state: {
    rooms: [],
    room: {},
  },

  getters: {
    getRooms: (state) => state.rooms,
    getRoom: (state) => state.room,
  },

  mutations: {
    setRooms: (state, rooms) => (state.rooms = rooms),
    setRoom: (state, room) => (state.room = room),
  },

  actions: {
    async getRooms({ commit }) {
      let url = this._vm.env.apiURL + "rooms";
      await axios.get(url).then((response) => {
        commit("setRooms", response.data);
      });
    },

    async getRoom({ commit }, payload) {
      let url = this._vm.env.apiURL + "rooms/" + payload.number;
      axios.get(url).then((response) => {
        commit("setRoom", response.data);
      });
    },
  },
};
