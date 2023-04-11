import axios from "axios";
// import Auth from "../../plugins/auth";
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
      let url = `http://127.0.0.1:8000/api/users`;

      await axios.get(url).then((response) => {
        commit("setUsers", response.data.data);
      });
    },
  },
};
