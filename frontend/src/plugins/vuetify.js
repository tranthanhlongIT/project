import Vue from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";

Vue.use(Vuetify);

const opts = {
  icons: {
    iconfont: 'mdi' || 'fa'
  },
};

export default new Vuetify(opts);
