<template>
  <div class="m-2">
    <h5>User List</h5>
    <v-card>
      <v-card-title>
        <v-btn color="success" small class="my-0" @click.prevent="openDialog('add', {})">
          Add
          <v-icon right> mdi-plus </v-icon>
        </v-btn>
        <v-btn color="info" small class="mx-1 my-0">
          Export
          <v-icon right> mdi-file-excel </v-icon>
        </v-btn>
        <v-btn color="error" small class="my-0">
          Disable
          <v-icon right> mdi-block-helper </v-icon>
        </v-btn>
        <v-spacer></v-spacer>

        <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" single-line hide-details>
        </v-text-field>
      </v-card-title>
      <v-data-table :headers="headers" :items="objects" :search="search" :loading="loading" show-select
        v-model="selectedObject" loading-text="Fetching data... Please wait" @current-items="getCurrentObjectList">
        <template v-slot:[`item.image`]="{ item }">
          <v-avatar class="my-2" v-if="item.image">
            <v-img lazy-src="/admin/img/user-default.jpg" :src="env.imageURL + item.image"></v-img>
          </v-avatar>
          <v-avatar class="my-2" v-else>
            <v-img lazy-src="/admin/img/user-default.jpg" src="/admin/img/user-default.jpg"></v-img>
          </v-avatar>
        </template>

        <template v-slot:[`item.role`]="{ item }">
          <v-chip color="primary" small>
            {{ item.role }}
          </v-chip>
        </template>

        <template v-slot:[`item.active`]="{ item }">
          <v-chip v-if="item.active == true" class="text-white" color="green" small>
            Active
          </v-chip>
          <v-chip v-else color="red" text-color="white" small> Disable </v-chip>
        </template>

        <template v-slot:[`item.operations`]="{ item }">
          <v-icon small class="mr-2" @click="openDialog('det', item)">
            mdi-eye
          </v-icon>
          <v-icon small class="mr-2" @click="openDialog('upd', item)">
            mdi-pencil
          </v-icon>
          <v-icon small @click="openDialog('dis', item)">
            mdi-block-helper
          </v-icon>
        </template>
      </v-data-table>
    </v-card>

    <UserDialog v-if="dialog" :dialog="dialog" :action="action" :userSelected="object">
      <div v-if="action === 'add'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Add User
      </div>
      <div v-if="action === 'upd'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Edit User
      </div>
      <div v-if="action === 'dis'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Disable User
      </div>
      <div v-if="action === 'det'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Show User
      </div>
    </UserDialog>

    <v-overlay v-if="overlay" :value="overlay">
      <v-progress-circular indeterminate size="64"></v-progress-circular>
    </v-overlay>
  </div>
</template>

<script>
import { EventBus } from "@/main";
import { mapGetters, mapActions } from "vuex";
import UserDialog from "../components/UserDialog.vue";

export default {
  name: "UserList",
  components: {
    UserDialog,
  },

  data() {
    return {
      search: "",
      object: {},
      action: "",
      headers: [
        { text: "ID", value: "id", width: "5%" },
        {
          text: "Image",
          value: "image",
          sortable: false,
          filterable: false,
          width: "15%",
        },
        { text: "Email", value: "email", width: "30%" },
        { text: "Role", align: "center", value: "role", width: "15%" },
        { text: "Active", align: "center", width: "15%", value: "active" },
        {
          text: "Operation",
          align: "center",
          width: "15%",
          value: "operations",
          filterable: false,
          sortable: false,
        },
      ],

      dialog: false,
      overlay: false,
      currentObjectList: [],
      selectedObject: [],
      loading: false,
    };
  },

  computed: {
    ...mapGetters({
      objects: "getUsers",
    }),
  },

  methods: {
    ...mapActions(["getUsers"]),

    openDialog(action, object) {
      this.action = action;
      this.object = Object.assign(object);
      this.dialog = true;
    },

    getCurrentObjectList() { },
  },

  created() {
    this.getUsers();

    EventBus.$on("dialog", () => {
      this.dialog = false
    });
  },
};
</script>
