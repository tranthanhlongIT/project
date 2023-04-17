<template>
  <v-app-bar app color="white" style="box-shadow: 0 0 2rem 0 rgba(33, 37, 41, 0.1)">
    <v-row no-gutters>
      <v-col>
        <v-app-bar-nav-icon @click.prevent="toggleDrawer"></v-app-bar-nav-icon>
      </v-col>
      <v-col cols="2" class="d-flex justify-end">
        <v-menu offset-y rounded="lg" dense>
          <template v-slot:activator="{ on, attrs }">
            <v-btn plain class="my-auto p-0" :ripple="false" v-bind="attrs" v-on="on">
              <v-avatar rounded size="40" class="mr-2">
                <img src="https://picsum.photos/200" alt="" />
              </v-avatar>
              <div class="text-subtitle-1" style="text-transform: capitalize">
                Username
              </div>
              <v-icon>mdi-chevron-down</v-icon>
            </v-btn>
          </template>
          <v-list>
            <v-list-item link>
              <v-list-item-title>Profile</v-list-item-title>
            </v-list-item>
            <v-divider class="m-0 p0"></v-divider>
            <v-list-item link>
              <v-list-item-title>Change Password</v-list-item-title>
            </v-list-item>
            <v-divider class="m-0 p0"></v-divider>
            <v-list-item link>
              <v-list-item-title @click.prevent="">Logout</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-col>
    </v-row>
  </v-app-bar>
</template>

<script>
import { EventBus } from "@/main";

export default {
  name: "app-bar",

  methods: {
    toggleDrawer() {
      EventBus.$emit("drawer");
    },
  },
};
</script>
