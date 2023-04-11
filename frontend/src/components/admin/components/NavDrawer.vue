<template>
  <v-navigation-drawer app v-model="drawer" color="#222e3c">
    <v-list-item>
      <v-list-item-content>
        <v-list-item-title class="text-h5 text-white m-2">
          Vue Hotel
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
    <v-list dense nav class="p-0">
      <ul class="sidebar-nav p-0">
        <li class="sidebar-header">Main</li>
        <li class="sidebar-item" :class="isActive('dashboard')">
          <router-link class="sidebar-link" to="/admin/dashboard" style="text-decoration: none">
            <i class="align-middle" data-feather="sliders"></i>
            <span class="align-middle">Dashboard</span>
          </router-link>
        </li>
        <li class="sidebar-item" :class="isActive('user')">
          <router-link class="sidebar-link" to="/admin/user" style="text-decoration: none">
            <i class="align-middle" data-feather="sliders"></i>
            <span class="align-middle">Users</span>
          </router-link>
        </li>
        <li class="sidebar-item" :class="isActive('room')">
          <router-link class="sidebar-link" to="/admin/room" style="text-decoration: none">
            <i class="align-middle" data-feather="sliders"></i>
            <span class="align-middle">Rooms</span>
          </router-link>
        </li>
        <li class="sidebar-item" :class="isActive('reservation')">
          <router-link class="sidebar-link" to="/admin/reservation" style="text-decoration: none">
            <i class="align-middle" data-feather="sliders"></i>
            <span class="align-middle">Reservation</span>
          </router-link>
        </li>
        <li class="sidebar-item" :class="isActive('history')">
          <router-link class="sidebar-link" to="/admin/history" style="text-decoration: none">
            <i class="align-middle" data-feather="sliders"></i>
            <span class="align-middle">History</span>
          </router-link>
        </li>
      </ul>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { EventBus } from "@/main";

export default {
  name: "NavDrawer",

  data() {
    return {
      drawer: true,
    };
  },

  methods: {
    isActive(path) {
      if (path === this.$route.name) {
        return "active";
      }
    },
  },

  created() {
    EventBus.$on("drawer", () => {
      this.drawer = !this.drawer;
    })
  }
};
</script>

<style scoped></style>
