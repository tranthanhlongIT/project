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
        <template v-for="item in items">
          <li class="sidebar-item" :class="isActive(item.name)">
            <router-link class="sidebar-link" :to="item.path" style="text-decoration: none">
              <v-icon>{{ item.icon }}</v-icon>
              <span class="align-middle">{{ item.name | capitalize }}</span>
            </router-link>
          </li>
        </template>
      </ul>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { EventBus } from "@/main";

export default {
  name: "nav-drawer",

  data() {
    return {
      items: [
        { name: 'dashboard', path: '/admin/dashboard', icon: '' },
        { name: 'guest', path: '/admin/guest', icon: '' },
        { name: 'room', path: '/admin/room', icon: '', icon: '' },
        { name: 'reservation', path: '/admin/reservation', icon: '' },
        { name: 'history', path: '/admin/history', icon: '' },
        { name: 'user', path: '/admin/user', icon: '' },
      ],
      drawer: this.$vuetify.breakpoint.lgAndUp ? true : false,
    };
  },

  methods: {
    isActive(path) {
      if (path == this.$route.name) {
        return "active";
      }
    },
  },

  created() {
    EventBus.$on("drawer", () => {
      this.drawer = !this.drawer;
    })
  },
};
</script>