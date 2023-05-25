<template>
  <v-app>
    <router-view />
  </v-app>
</template>

<script>
export default {
};
</script>

<style>
html {
  overflow: overlay;
}

::-webkit-scrollbar {
  width: 6px;
}

::-webkit-scrollbar-button {
  display: none;
}

::-webkit-scrollbar-track {
  background-color: #00000000;
}

::-webkit-scrollbar-track-piece {
  background-color: #00000000;
}

::-webkit-scrollbar-thumb {
  background-color: #00000040;
  border-radius: 25px;
}

@media (min-width: 1140px) {
  .container {
    max-width: 1140px !important;
  }
}

@import "~/public/home/css/bootstrap.min.css";
@import "~/public/home/css/owl.carousel.min.css";
@import "~/public/home/css/magnific-popup.css";
@import "~/public/home/css/font-awesome.min.css";
@import "~/public/home/css/themify-icons.css";
@import "~/public/home/css/nice-select.css";
@import "~/public/home/css/flaticon.css";
@import "~/public/home/css/gijgo.css";
@import "~/public/home/css/animate.css";
@import "~/public/home/css/slicknav.css";
@import "~/public/home/css/style.css";
</style>
