<template>
  <v-app>

    <v-navigation-drawer app v-model="drawer">

    </v-navigation-drawer>

    <v-app-bar app>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>

    <v-main>

      <v-container fluid>

        <router-view></router-view>
      </v-container>
    </v-main>

    <v-footer app>
    </v-footer>
  </v-app>
</template>

<script >
export default {
  data: () => ({
    drawer: false,
    group: null,
  }),
}
</script>

<style>
@import "~/public/admin/css/app.css";
</style>