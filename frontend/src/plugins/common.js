import Vue from "vue";
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";
import Vuelidate from "vuelidate";
import excel from "vue-excel-export";
import AsyncComputed from 'vue-async-computed';

const options = {
  position: "bottom-right",
  timeout: 5000,
  closeOnClick: true,
  pauseOnFocusLoss: true,
  pauseOnHover: true,
  draggable: true,
  draggablePercent: 0.5,
  showCloseButtonOnHover: false,
  hideProgressBar: false,
  closeButton: "button",
  icon: true,
  rtl: false,
};

Vue.use(excel);
Vue.use(Toast, options);
Vue.use(Vuelidate);
Vue.use(AsyncComputed)
