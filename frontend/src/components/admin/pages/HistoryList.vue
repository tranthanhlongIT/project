<template>
    <div class="m-3">
        <h5 class="indigo--text">Reservation History</h5>
        <v-card>
            <v-sheet class="px-4 py-2" style="border-bottom: 1px solid #E0E0E0;">
                <v-row no-gutters>
                    <v-col cols="6" class="my-1 mb-2">
                        <v-btn color="info" small class="mr-1">
                            <v-icon left> mdi-file-excel </v-icon>
                            Export
                        </v-btn>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" dense single-line
                            hide-details>
                        </v-text-field>
                    </v-col>
                </v-row>
            </v-sheet>
            <v-data-table :headers="headers" :items="reservations" :search="search">
                <template v-slot:[`item.room_price`]="{ item }">
                    {{ item.room_price | toCurrency }}
                </template>
                <template v-slot:[`item.total_stay`]="{ item }">
                    <template v-if="item.total_stay > 1">
                        {{ item.total_stay }} days
                    </template>
                    <template v-else>
                        {{ item.total_stay }} day
                    </template>
                </template>
                <template v-slot:[`item.total_price`]="{ item }">
                    {{ item.total_price | toCurrency }}
                </template>
            </v-data-table>
        </v-card>
    </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
    data() {
        return {
            search: null,
            headers: [
                { text: "ID", value: "id", width: "8%" },
                { text: "Guest", value: "name", width: "12%" },
                { text: "Phone", value: "phone", width: "10%", sortable: false },
                { text: "Room", value: "number", width: "10%" },
                { text: "Price", value: "room_price", width: "10%", sortable: false, filterable: false },
                { text: "Check in", value: "check_in", width: "15%", filterable: false },
                { text: "Check out", value: "check_out", width: "15%", filterable: false },
                { text: "Total stay", value: "total_stay", width: "10%", sortable: false, filterable: false },
                { text: "Total price", value: "total_price", width: "10%", sortable: false, filterable: false },
            ],
        }
    },

    computed: {
        ...mapGetters({
            reservations: "getReservations",
        }),
    },

    methods: {
        ...mapActions(["getReservations"]),
    },

    created() {
        this.getReservations()
    },
}
</script>
