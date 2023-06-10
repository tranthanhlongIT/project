<template>
    <div>
        <div v-if="!loading" class="m-3">
            <h5 class="indigo--text">Guest List</h5>
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
                <div slot="message" class="text-center text-subtitle-1">Are you sure want to delete</div>
            </confirmation-dialog>
        </div>
        <v-progress-linear v-else indeterminate class="p-0 m-0" absolute></v-progress-linear>
    </div>
</template>

<script>
import { EventBus } from "@/main"
import { mapGetters, mapActions } from "vuex"
import GuestDialog from "../components/dialogs/GuestDialog.vue"
import ConfirmationDialog from "../components/dialogs/ConfirmationDialog.vue"

export default {
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

            loading: false,
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
        this.loading = true;

        this.getGuests();

        console.log(this.guests);

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
