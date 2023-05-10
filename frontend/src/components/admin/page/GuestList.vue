<template>
    <div class="m-3">
        <h5 class="indigo--text">Guest List</h5>
        <v-card>
            <v-sheet class="pa-4" style="border-bottom: 1px solid #E0E0E0;">
                <v-row no-gutters>
                    <v-col cols="6">
                        <v-btn color="success" small class="my-0" @click.prevent="openDialog('add', {})">
                            <v-icon left> mdi-plus </v-icon>
                            Add
                        </v-btn>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" dense single-line
                            hide-details>
                        </v-text-field>
                    </v-col>
                </v-row>
            </v-sheet>
            <v-data-table :headers="headers" :items="guests" :search="search">
                <template v-slot:[`item.operations`]="{ item }">
                    <v-icon small class="mr-2" @click.prevent="openDialog('det', item)">
                        mdi-eye
                    </v-icon>
                    <v-icon small class="mr-2" @click.prevent="openDialog('upd', item)">
                        mdi-pencil
                    </v-icon>
                    <v-icon small @click.prevent="openConfirmation(item)">
                        mdi-delete
                    </v-icon>
                </template>
            </v-data-table>
        </v-card>
        <guest-dialog v-if="dialog" :dialog="dialog" :action="action" :selectedGuest="guest">
            <div v-if="action == 'add'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Add Guest
            </div>
            <div v-if="action == 'upd'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Edit Guest
            </div>
            <div v-if="action == 'det'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Show Guest
            </div>
        </guest-dialog>

        <confirmation-dialog v-if="confirmation" :object="guest" action="deleteGuest" :confirmation="confirmation"
            type="del">
            <div slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Delete Guest
            </div>
            <div slot="message" class="text-center text-subtitle-1">Are you sure want to delete guest</div>
        </confirmation-dialog>
    </div>
</template>

<script>
import { EventBus } from "@/main";
import { mapGetters, mapActions } from "vuex";
import GuestDialog from "../components/GuestDialog.vue";
import ConfirmationDialog from "../components/ConfirmationDialog.vue";

export default {
    name: "guest-list",
    components: {
        "guest-dialog": GuestDialog,
        "confirmation-dialog": ConfirmationDialog
    },

    data() {
        return {
            guest: {},
            search: null,
            action: null,
            dialog: false,
            confirmation: false,
            headers: [
                { text: "ID", value: "id", width: "8%" },
                { text: "Title", value: "title", width: "12%", sortable: false, filterable: false },
                { text: "Name", value: "name" },
                { text: "Phone", value: "phone", width: "15%", sortable: false, },
                { text: "Email", value: "email", width: "15%", sortable: false, },
                { text: "Operation", value: "operations", width: "15%", align: "center", sortable: false, filterable: false },
            ],
        };
    },

    computed: {
        ...mapGetters({
            guests: "getGuests",
        }),
    },

    methods: {
        ...mapActions(["getGuests"]),

        openDialog(action, guest) {
            this.action = action;
            this.guest = Object.assign(guest);
            this.dialog = true;
        },

        openConfirmation(guest) {
            this.confirmation = true;
            this.guest = Object.assign(guest);
        }
    },

    created() {
        this.getGuests();

        EventBus.$on("dialog", () => {
            this.dialog = false
        });

        EventBus.$on("confirmation", () => {
            this.confirmation = false
        });
    },
};
</script>
