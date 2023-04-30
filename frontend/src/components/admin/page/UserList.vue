<template>
  <div class="m-3">
    <h5 class="indigo--text">User List</h5>
    <v-card>
      <v-card-title>
        <v-btn color="success" small class="my-0" @click.prevent="openDialog('add', {})">
          <v-icon left> mdi-plus </v-icon>
          Add
        </v-btn>
        <v-btn color="info" small class="mx-1 my-0">
          <v-icon left> mdi-file-excel </v-icon>
          Export
        </v-btn>
        <v-spacer></v-spacer>

        <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" single-line hide-details>
        </v-text-field>
      </v-card-title>
      <v-data-table :headers="headers" :items="users" :search="search">
        <template v-slot:[`item.image`]="{ item }">
          <v-avatar class="my-2" v-if="item.image">
            <v-img :src="env.imageURL + item.image"></v-img>
          </v-avatar>
          <v-avatar class="my-2" v-else>
            <v-img src="/admin/img/user-default.jpg"></v-img>
          </v-avatar>
        </template>

        <template v-slot:[`item.role`]="{ item }">
          <v-chip color="primary" small>
            {{ item.role.name }}
          </v-chip>
        </template>

        <template v-slot:[`item.active`]="{ item }">
          <v-chip v-if="item.active == true" class="text-white" color="green" small>
            Active
          </v-chip>
          <v-chip v-else color="red" text-color="white" small> Disable </v-chip>
        </template>

        <template v-slot:[`item.operations`]="{ item }">
          <v-icon small class="mr-2" @click.prevent="openDialog('det', item)">
            mdi-eye
          </v-icon>
          <v-icon small class="mr-2" @click.prevent="openDialog('upd', item)">
            mdi-pencil
          </v-icon>
          <v-icon small @click.prevent="openConfirmation(item)">
            mdi-block-helper
          </v-icon>
        </template>
      </v-data-table>
    </v-card>

    <user-dialog v-if="dialog" :dialog="dialog" :action="action" :selectedUser="user">
      <div v-if="action == 'add'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Add User
      </div>
      <div v-if="action == 'upd'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Edit User
      </div>
      <div v-if="action == 'det'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Show User
      </div>
    </user-dialog>

    <confirmation-dialog v-if="confirmation" type="dis" :confirmation="confirmation" :object="user">
      <div slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Disable User
      </div>
      <div slot="message" class="text-center text-subtitle-1">Are you sure want to disable user</div>
    </confirmation-dialog>
  </div>
</template>

<script>
import { EventBus } from "@/main";
import { mapGetters, mapActions } from "vuex";
import UserDialog from "../components/UserDialog.vue";
import ConfirmationDialog from "../components/ConfirmationDialog.vue";

export default {
  name: "user-list",
  components: {
    "user-dialog": UserDialog,
    "confirmation-dialog": ConfirmationDialog
  },

  data() {
    return {
      user: {},
      search: null,
      action: null,
      dialog: false,
      confirmation: false,
      headers: [
        { text: "ID", value: "id", width: "8%" },
        { text: "Image", value: "image", sortable: false, filterable: false, width: "12%" },
        { text: "Email", value: "email", width: "30%" },
        { text: "Role", align: "center", value: "role", width: "15%" },
        { text: "Active", align: "center", width: "15%", value: "active" },
        { text: "Operation", align: "center", width: "15%", value: "operations", filterable: false, sortable: false },
      ],
    };
  },

  computed: {
    ...mapGetters({
      users: "getUsers",
    }),
  },

  methods: {
    ...mapActions(["getUsers"]),

    openDialog(action, user) {
      this.action = action;
      this.user = Object.assign(user);
      this.dialog = true;
    },

    openConfirmation(user) {
      this.confirmation = true;
      this.user = Object.assign(user);
    }
  },

  created() {
    this.getUsers();

    EventBus.$on("dialog", () => {
      this.dialog = false
    });

    EventBus.$on("confirmation", () => {
      this.confirmation = false
    });
  },
};
</script>
