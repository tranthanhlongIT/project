import axios from "axios";
import Auth from "@/plugins/auth";
import router from "@/router";
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
      const index = state.users.findIndex((users) => users.id == user.id);
      state.users.splice(index, 1, user);
    },
    disableUser: (state, user) => {
      user.active = 0;
      const index = state.users.findIndex((users) => users.id == user.id);
      state.users.splice(index, 1, user);
    },
  },

  actions: {
    async getUsers({ commit }) {
      try {
        const url = this._vm.env.apiURL + "users";

        await axios.get(url).then((response) => {
          commit("setUsers", response.data.data);
        });

      } catch (error) {

        if (error.response.status == 401) {
          Auth.logout();
          router.go("/admin/login");
        }

        this._vm.$toast.error(error.response.data.message);
      }
    },

    async addUser({ commit }, { user, file }) {
      const config = { header: "content-type: form-data/multipart" };
      const formData = addFormData(user, file);
      const url = this._vm.env.apiURL + "users";

      try {
        const response = await axios.post(url, formData, config);

        user.id = response.data.id;
        commit("addUser", user);
        EventBus.$emit("resetField");
        this._vm.$toast.success("Add successful");

      } catch (error) {
        this._vm.$toast.error(error.response.data.message);
      }
    },

    async updateUser({ commit }, { user, file }) {
      const config = { header: "content-type: form-data/multipart", };
      const formData = updateFormData(user, file);
      const url = this._vm.env.apiURL + "users/" + user.id;

      try {
        await axios.post(url, formData, config);

        if (this._vm.auth.user.id == user.id) {

          if (this._vm.auth.user.role.name != user.role.name) {
            Auth.logout();
            router.go("/admin/login");
            this._vm.$toast.success("Update successful. Please login again");
          }

          if (!user.active) {
            Auth.logout();
            router.go("/admin/login");
            this._vm.$toast.success("Disable successful");
          }

        } else {

          commit("updateUser", user);
          this._vm.$toast.success("Update successful");

        }

      } catch (error) {
        this._vm.$toast.error(error.response.data.message);
      }
    },

    async disableUser({ commit }, { object }) {
      const url = this._vm.env.apiURL + "users/disable/" + object.id;

      try {
        await axios.patch(url);

        commit("disableUser", object);
        EventBus.$emit("closeConfirmation");
        this._vm.$toast.success("Disable successful");

      } catch (e) {
        this._vm.$toast.error("Disable failed");
      }
    },
  },
};


function addFormData(user, file) {
  const formData = new FormData();
  formData.append("email", user.email);
  formData.append("password", user.password);
  formData.append("role_id", user.role.id);
  formData.append("active", user.active);
  formData.append("fname", user.fname);
  formData.append("lname", user.lname);
  formData.append("address", user.address ?? "");
  formData.append("gender", user.gender);
  formData.append("phone", user.phone);
  formData.append("image", file ?? "");

  return formData;
}

function updateFormData(user, file) {
  const formData = new FormData();
  formData.append("role_id", user.role.id);
  formData.append("active", user.active);
  formData.append("fname", user.fname);
  formData.append("lname", user.lname);
  formData.append("address", user.address ?? "");
  formData.append("gender", user.gender);
  formData.append("phone", user.phone);
  formData.append("image", file ?? "");
  formData.append("_method", "PATCH");

  return formData;
}