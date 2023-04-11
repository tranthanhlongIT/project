<template>
  <v-app-bar
    app
    color="white"
    style="box-shadow: 0 0 2rem 0 rgba(33, 37, 41, 0.1)"
  >
    <v-row no-gutters>
      <v-col>
        <v-app-bar-nav-icon
          @click="commitDrawer({ drawer: !drawer })"
        ></v-app-bar-nav-icon>
      </v-col>
      <v-col cols="2" class="d-flex justify-end">
        <v-menu app rounded="lg" offset-y>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              plain
              class="my-auto p-0"
              :ripple="false"
              v-bind="attrs"
              v-on="on"
            >
              <v-avatar rounded size="40" class="mr-2">
                <img src="https://picsum.photos/200" alt="" />
              </v-avatar>
              <div class="text-subtitle-1" style="text-transform: capitalize">
                Username
              </div>
              <v-icon>mdi-chevron-down</v-icon>
            </v-btn>
          </template>
          <v-card>
            <v-list-item-content class="justify-center">
              <div class="mx-auto text-center">
                <v-btn depressed rounded text> Edit Account </v-btn>
                <v-divider></v-divider>
                <v-btn depressed rounded text> Disconnect </v-btn>
              </div>
            </v-list-item-content>
          </v-card>
        </v-menu>
      </v-col>
    </v-row>
  </v-app-bar>
</template>

<script>
import { mapActions, mapGetters } from "vuex";

export default {
  name: "AppBar",
  computed: {
    ...mapGetters({
      drawer: "getDrawer",
    }),
  },
  methods: {
    ...mapActions(["commitDrawer"]),
  },
};
</script>

<style lang="scss" scoped></style>
