<template>
    <div class="m-3">
        <h5 class="indigo--text">Dashboard</h5>
        <v-row>
            <v-col cols="8">
                <v-row>
                    <v-col cols="6">
                        <v-card color="#222e3c" dark>
                            <v-card-title>Rooms</v-card-title>
                            <v-card-text>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Reserved Rooms:</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Vacant Rooms:</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-card-text>
                        </v-card>
                    </v-col>
                    <v-col cols="6">
                        <v-card color="#222e3c" dark>
                            <v-card-title>Rooms</v-card-title>
                            <v-card-text>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Reserved Rooms:</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Vacant Rooms:</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <v-card>
                            <v-card-title>Rooms</v-card-title>
                            <v-card-text>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Available Rooms</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Single-line item</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
            </v-col>
            <v-col cols="4">
                <v-row>
                    <v-col cols="12">
                        <v-card>
                            <v-card-title>Revenue</v-card-title>
                            <v-card-text>
                                <p>Total revenue: $10,000</p>
                                <p>Total revenue: $10,000</p>
                                <p>Total revenue: $10,000</p>
                                <p>Total revenue: $10,000</p>
                                <p>Total revenue: $10,000</p>
                                <p>Total revenue: $10,000</p>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
            </v-col>
        </v-row>
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

            data: {}
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
