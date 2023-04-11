export const componentStore = {
  state: {
    drawer: true,
    dialog: false,
  },

  getters: {
    getDrawer: (state) => state.drawer,
    getDialog: (state) => state.dialog,
  },

  mutations: {
    setDrawer: (state, drawer) => (state.drawer = drawer),
    setDialog: (state, dialog) => (state.dialog = dialog),
  },

  actions: {
    async commitDrawer({ commit }, payload) {
      await commit("setDrawer", payload.drawer);
    },

    async commitDialog({ commit }, payload) {
      await commit("setDialog", payload.dialog);
    },
  },
};
