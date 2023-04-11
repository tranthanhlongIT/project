import axios from "axios";
// import router from "../../router";

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
  },

  actions: {
    async getUsers({ commit }) {
      let url = this._vm.env.apiURL + "users";
      await axios.get(url).then((response) => {
        commit("setUsers", response.data.data);
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
      formData.append("address", payload.user.address);
      formData.append("gender", payload.user.gender);
      formData.append("phone", payload.user.phone);
      formData.append("image", payload.file ?? "");

      console.log(payload.user);

      let url = this._vm.env.apiURL + "users";

      await axios.post(url, formData, config).then((response) => { }).catch((e) => { console.log(e) });
    },
  },
};
