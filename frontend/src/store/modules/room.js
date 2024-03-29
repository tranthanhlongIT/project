import axios from "axios";
import Auth from "@/plugins/auth";
import { EventBus } from "@/main";

export const roomStore = {
  state: {
    room: {},
    rooms: [],
    reservation_rooms: [],
  },

  getters: {
    getRooms: (state) => state.rooms,
    getRoom: (state) => state.room,
    getReservationRooms: (state) => state.reservation_rooms,
  },

  mutations: {
    setRooms: (state, rooms) => (state.rooms = rooms),
    setRoom: (state, room) => (state.room = room),
    setReservationRooms: (state, rooms) => (state.reservation_rooms = rooms),
    updateRoom: (state, room) => {
      const index = state.rooms.findIndex((r) => r.id == room.id);
      state.rooms.splice(index, 1, room);
    },
    deleteRoom: (state, id) => {
      // const index = state.rooms.findIndex((r) => r.id == id);
      // state.rooms.splice(index, 1);
    }
  },

  actions: {
    async getRooms({ commit }) {
      try {
        const url = this._vm.env.apiURL + "rooms";

        await axios.get(url).then((response) => {
          commit("setRooms", response.data.data);
        });

      } catch (error) {

        if (error.response.status == 401) {
          Auth.logout();
          router.go("/admin/login");
        }

        this._vm.$toast.error(error.response.data.message);
      }
    },

    async getReservationRooms({ commit }, { date }) {
      try {
        const url = this._vm.env.apiURL + "rooms/reservation-rooms?date=" + date;

        await axios.get(url).then((response) => {
          commit("setReservationRooms", response.data.data);
        });

      } catch (error) {
        this._vm.$toast.error(error.response.data.message);
      }
    },

    async getRoom({ commit }, { number }) {
      try {
        const url = this._vm.env.apiURL + "rooms/" + number;

        await axios.get(url).then((response) => {
          commit("setRoom", response.data.data);
        });

      } catch (error) {
        this._vm.$toast.error(error.response.data.message);
      }

    },

    async addRoom({ commit }, { room, files }) {
      const config = { header: "content-type: form-data/multipart", };
      const formData = addFormData(room, files);
      const url = this._vm.env.apiURL + "rooms";

      try {
        await axios.post(url, formData, config);

        EventBus.$emit("resetField");
        EventBus.$emit("addChild", room);
        this._vm.$toast.success("Add successful");

      } catch (error) {
        this._vm.$toast.error(error.response.data.message);
      }
    },

    async updateRoom({ commit }, { room, files }) {
      const config = { header: "content-type: form-data/multipart", };
      const formData = updateFormData(room, files);
      const url = this._vm.env.apiURL + "rooms/" + room.id;

      try {
        await axios.post(url, formData, config);

        commit("setRoom", room);
        EventBus.$emit("updateChild", room);
        this._vm.$toast.success("Update successful");

      } catch (error) {
        this._vm.$toast.error(error.response.data.message);
      }
    },

    async deleteRoom({ commit }, { id }) {
      const url = this._vm.env.apiURL + "rooms/" + id;

      try {
        await axios.delete(url);

        commit("deleteRoom", id);
        EventBus.$emit("deleteChild");
        EventBus.$emit("closeConfirmation");
        this._vm.$toast.success("Delete successful");

      } catch (e) {
        this._vm.$toast.error("Delete failed");
      }
    },
  },
};

function addFormData(room, files) {
  const formData = new FormData();
  formData.append("type_id", room.type.id);
  formData.append("floor_id", room.floor.id);
  formData.append("size_id", room.size.id);
  formData.append("number", room.number);
  formData.append("name", room.name);
  formData.append("description", room.description ?? "");
  formData.append("price", room.price);
  formData.append("services", JSON.stringify(room.services));
  files.forEach((file) => { formData.append("images[]", file) });

  return formData;
}

function updateFormData(room, files) {
  const formData = new FormData();
  formData.append("type_id", room.type.id);
  formData.append("floor_id", room.floor.id);
  formData.append("size_id", room.size.id);
  formData.append("number", room.number);
  formData.append("name", room.name);
  formData.append("description", room.description ?? "");
  formData.append("price", room.price);
  formData.append("services", JSON.stringify(room.services));
  files.forEach((file) => formData.append("images[]", processFile(file)));
  formData.append("_method", "PATCH");

  return formData;
}

function processFile(file) {
  if (file instanceof File) {
    return file;
  }

  return new File([file.blob], file.name, { type: file.type });
}
