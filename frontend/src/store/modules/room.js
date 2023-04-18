import { EventBus } from "@/main";
import axios from "axios";

export const roomStore = {
  state: {
    room: {},
    rooms: [],
  },

  getters: {
    getRooms: (state) => state.rooms,
    getRoom: (state) => state.room,
  },

  mutations: {
    setRooms: (state, rooms) => (state.rooms = rooms),
    setRoom: (state, room) => (state.room = room),
    updateRoom: (state, room) => {
      const index = state.rooms.findIndex((r) => r.id === room.id);
      state.rooms.splice(index, 1, room);
    },
  },

  actions: {
    async getRooms({ commit }) {
      const url = this._vm.env.apiURL + "rooms";
      await axios.get(url).then((response) => {
        commit("setRooms", response.data);
      });
    },

    async getRoom({ commit }, payload) {
      const url = this._vm.env.apiURL + "rooms/" + payload.number;
      await axios.get(url).then((response) => {
        commit("setRoom", response.data);
      });
    },

    async addRoom({ commit }, payload) {
      const config = {
        header: "content-type: form-data/multipart",
      };

      const formData = new FormData();
      formData.append("type_id", payload.room.type_id);
      formData.append("floor_id", payload.room.floor_id);
      formData.append("size_id", payload.room.size_id);
      formData.append("number", payload.room.number);
      formData.append("name", payload.room.name);
      formData.append("description", payload.room.description ?? "");
      formData.append("price", payload.room.price);
      formData.append("services", JSON.stringify(payload.room.service));
      files.forEach((file) => formData.append("images[]", file));

      const url = this._vm.env.apiURL + "rooms";

      try {
        await axios.post(url, formData, config);
        EventBus.$emit("reset");
        EventBus.$emit("addChild", payload.room);
        this._vm.$toast.success("Add successful");
      } catch (e) {
        this._vm.$toast.error(error.response.data.message);
      }
    },

    async updateRoom({ commit }, payload) {
      const config = {
        header: "content-type: form-data/multipart",
      };

      const formData = new FormData();
      formData.append("type_id", payload.room.type_id);
      formData.append("floor_id", payload.room.floor_id);
      formData.append("size_id", payload.room.size_id);
      formData.append("number", payload.room.number);
      formData.append("name", payload.room.name);
      formData.append("description", payload.room.description ?? "");
      formData.append("price", payload.room.price);
      formData.append("services", JSON.stringify(payload.room.service));
      files.forEach((file) => formData.append("images[]", file));
      formData.append("_method", "PATCH");

      const url = this._vm.env.apiURL + "rooms";

      try {
        await axios.post(url, formData, config)
        commit("updateRoom", payload.room);
        this._vm.$toast.success("Add successful");
      } catch (e) {
        this._vm.$toast.error(error.response.data.message);
      }
    },
  },
};
