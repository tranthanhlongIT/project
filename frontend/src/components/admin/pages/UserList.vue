<template>
  <div>
    <div v-if="!loading" class="m-3">
      <h5 class="indigo--text">User List</h5>
      <v-card>
        <v-sheet class="px-4 py-2" style="border-bottom: 1px solid #E0E0E0;">
          <v-row no-gutters>
            <v-col cols="6" class="my-1 mb-2">
              <v-btn color="success" small class="mr-1" @click.prevent="openDialog('add', {})">
                <v-icon left> mdi-plus </v-icon>
                Add
              </v-btn>
            </v-col>
            <v-col cols="6">
              <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" dense single-line hide-details>
              </v-text-field>
            </v-col>
          </v-row>
        </v-sheet>
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

      <confirmation-dialog v-if="confirmation" :object="user" action="disableUser" :confirmation="confirmation"
        type="dis">
        <div slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
          <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Disable User
        </div>
        <div slot="message" class="text-center text-subtitle-1">Are you sure want to disable</div>
      </confirmation-dialog>
    </div>
    <v-progress-linear v-else indeterminate class="p-0 m-0" absolute></v-progress-linear>
  </div>
</template>

<script>
import { EventBus } from "@/main";
import { mapGetters, mapActions } from "vuex";
import UserDialog from "../components/dialogs/UserDialog.vue";
import ConfirmationDialog from "../components/dialogs/ConfirmationDialog.vue";

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
        { text: "Image", value: "image", width: "12%", sortable: false, filterable: false },
        { text: "Email", value: "email", width: "30%" },
        { text: "Role", value: "role", width: "15%", align: "center" },
        { text: "Active", value: "active", width: "15%", align: "center" },
        { text: "Operation", value: "operations", width: "15%", align: "center", sortable: false, filterable: false },
      ],

      loading: false,
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
    this.loading = true;

    this.getUsers();

    EventBus.$on("closeDialog", () => {
      this.dialog = false;
    });

    EventBus.$on("closeConfirmation", () => {
      this.confirmation = false;
    });

    setTimeout(() => {
      this.loading = false;
    }, 2000);
  },
};
</script>
