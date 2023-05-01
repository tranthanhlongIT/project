import axios from "axios";

export const historyStore = {
    state: {
        histories: [],
    },

    getters: {
        getHistories: (state) => state.histories,
    },

    mutations: {
        setHistories: (state, histories) => (state.histories = histories),
    },

    actions: {
        async getHistories({ commit }) {
            const url = this._vm.env.apiURL + "reservations";
            await axios.get(url).then((response) => {
                commit("setHistories", response.data);
            });
        },
    },
};