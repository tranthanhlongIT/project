import Vue from "vue";
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";
import Vuelidate from "vuelidate";
import excel from "vue-excel-export";
import AsyncComputed from "vue-async-computed";
import VCalendar from 'v-calendar';

const options = {
  position: "top-right",
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
Vue.use(AsyncComputed);
Vue.use(excel);

Vue.use(VCalendar, {
  componentPrefix: 'vc',
});

Vue.filter("toCurrency", function (value) {
  if (typeof value !== "number") {
    return value;
  }
  var formatter = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
  });
  return formatter.format(value);
});