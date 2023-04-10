<template>
  <v-app>

    <v-navigation-drawer app v-model="drawer" color="#222e3c">
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="text-h6">
            Vue Hotel
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-list dense nav>
        <v-list-item v-for="item in items" :key="item.title" link>
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar app color="white" style="box-shadow: 0 0 2rem 0 rgba(33,37,41,.1)">
      <v-row no-gutters>
        <v-col>
          <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
        </v-col>
        <v-col cols="2 " class="d-flex justify-end">
          <v-menu app rounded="lg" offset-y>
            <template v-slot:activator="{ on }">
              <v-btn plain class="ma-2" retain-focus-on-click="true">
                <v-avatar>
                  <img src="https://picsum.photos/200" alt="">
                </v-avatar>
                Upload
              </v-btn>
            </template>
            <v-card>
              <v-list-item-content class="justify-center">
                <div class="mx-auto text-center">
                  <v-btn depressed rounded text>
                    Edit Account
                  </v-btn>
                  <v-divider></v-divider>
                  <v-btn depressed rounded text>
                    Disconnect
                  </v-btn>
                </div>
              </v-list-item-content>
            </v-card>
          </v-menu>
        </v-col>
      </v-row>
    </v-app-bar>

    <v-main style="background: #f5f7fb">

      <v-container>

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
    drawer: true,
    group: null,
  }),
}
</script>

<style></style>
