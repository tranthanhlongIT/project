import axios from "axios";
// import router from "../../router";
import { EventBus } from "@/main";

export const userStore = {
  state: {
    users: [],
    user: {},
  },

  getters: {
    getUsers: (state) => state.users,
    getUser: (state) => state.user,
  },

  mutations: {
    setUsers: (state, users) => (state.users = users),
    setUser: (state, user) => (state.user = user),
    addUser: (state, user) => state.users.push(user),
    updateUser: (state, user) => {
      const index = state.users.findIndex((users) => users.id === user.id);
      state.users.splice(index, 1, user);
    },
  },

  actions: {
    async getUsers({ commit }) {
      let url = this._vm.env.apiURL + "users";
      await axios.get(url).then((response) => {
        commit("setUsers", response.data);
      });
    },

    async addUser({ commit }, payload) {
      let config = {
        header: "content-type: form-data/multipart",
      };

      let formData = new FormData();
      formData.append("email", payload.user.email);
      formData.append("password", payload.user.password);
      formData.append("role_id", payload.user.role_id);
      formData.append("active", payload.user.active);
      formData.append("fname", payload.user.fname);
      formData.append("lname", payload.user.lname);
      formData.append("address", payload.user.address ?? "");
      formData.append("gender", payload.user.gender);
      formData.append("phone", payload.user.phone);
      formData.append("image", payload.file ?? "");

      let url = this._vm.env.apiURL + "users";

      await axios
        .post(url, formData, config)
        .then(() => {
          commit("addUser", payload.user);
          EventBus.$emit("reset");
          this._vm.$toast.success("Add successful");
        })
        .catch((error) => {
          this._vm.$toast.error(error.response.data.message);
        });
    },

    async updateUser({ commit }, payload) {
      let config = {
        header: "content-type: form-data/multipart",
      };

      let formData = new FormData();
      formData.append("role_id", payload.user.role_id);
      formData.append("active", payload.user.active);
      formData.append("fname", payload.user.fname);
      formData.append("lname", payload.user.lname);
      formData.append("address", payload.user.address ?? "");
      formData.append("gender", payload.user.gender);
      formData.append("phone", payload.user.phone);
      formData.append("image", payload.file ?? "");
      formData.append("_method", "PATCH");

      let url = this._vm.env.apiURL + "users/" + payload.user.id;

      await axios
        .post(url, formData, config)
        .then(() => {
          commit("updateUser", payload.user);
          this._vm.$toast.success("Update successful");
        })
        .catch((error) => {
          this._vm.$toast.error(error.response.data.message);
        });
    },

    async disableUser({ commit }, payload) {
      let url = this._vm.env.apiURL + "users/disable/" + payload.user.id;

      await axios
        .patch(url)
        .then((response) => {
          commit("updateUser", payload.user);
          this._vm.$toast.success("Disable successful");

          if (response.data.case == "same") {
            EventBus.$emit("setOverlay", true);
            setTimeout(() => {
              Auth.logout();
              router.push("login");
              this._vm.$toast.error("User has been unauthorized");
            }, 3000);
          }
        })
        .catch((e) => {
          this._vm.$toast.error("Disable failed");

          if (e.request.status == 401) {
            Auth.logout();
            router.push("login");
            this._vm.$toast.error("Your session has expired");
          }
        });
    },
  },
};
