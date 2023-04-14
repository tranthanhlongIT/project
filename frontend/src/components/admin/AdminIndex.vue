<template>
  <v-app>
    <nav-drawer />
    <app-bar />
    <app-container />
  </v-app>
</template>

<script>
import NavDrawer from "./components/NavDrawer.vue";
import AppBar from "./components/AppBar.vue";
import AppContainer from "./components/AppContainer.vue";

export default {
  name: "AdminIndex",
  components: {
    "nav-drawer": NavDrawer,
    "app-bar": AppBar,
    "app-container": AppContainer,
  },
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

@import "~/public/admin/css/app.css";
@import "https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css";
</style>
