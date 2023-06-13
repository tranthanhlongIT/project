<template>
    <div>
        <template v-if="canView">

            <div v-if="!loading" class="m-3">
                <h5 class="indigo--text">Reservation History</h5>
                <v-card>
                    <v-sheet class="px-4 py-2" style="border-bottom: 1px solid #E0E0E0;">
                        <v-row no-gutters>
                            <v-col cols="6" class="my-1 mb-2">
                                <export-excel :data="json_data" :fields="json_fields" :worksheet="worksheet"
                                    :name="filename">
                                    <v-btn color="info" small class="mr-1">
                                        <v-icon left> mdi-file-excel </v-icon>
                                        Export
                                    </v-btn>
                                </export-excel>
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
            <v-progress-linear v-else indeterminate class="p-0 m-0" absolute></v-progress-linear>
        </template>
        <template v-else>
            <div class="mt-5">
                <no-permission />
            </div>
        </template>
    </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import moment from "moment";

import NoPermissionCard from "../components/layouts/NoPermissionCard.vue"

export default {
    components: {
        "no-permission": NoPermissionCard
    },

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
            json_fields: {
                'ID': 'id',
                'Name': 'name',
                'Phone number': 'phone',
                'Room number': 'number',
                'Room price': 'room_price',
                'Check in': 'check_in',
                'Check out': 'check_out',
                'Total stay': 'total_stay',
                'Total price': 'total_price',
            },
            json_data: [],
            worksheet: "ReservationRoomHistoryList",
            filename: "ReservationRoomHistoryList",

            loading: false,
        };
    },

    computed: {
        ...mapGetters({
            reservations: "getReservations",
        }),

        canView() {
            if (this.auth.user.role.name == "admin") {
                return true;
            }

            return false;
        }
    },

    methods: {
        ...mapActions(["getReservations"]),

        getDataToExportExcel() {
            const currentDate = moment(new Date()).format('MMDDYYYY');

            this.json_data = this.reservations;
            this.worksheet = this.worksheet + "_" + currentDate;
            this.filename = this.filename + "_" + currentDate + ".xls";

            this.json_data = this.json_data.map((item) => {
                return {
                    ...item,
                    phone: "'" + item.phone,
                    room_price: "$" + item.room_price,
                    total_price: "$" + item.total_price,
                    total_stay: item.total_stay > 1 ? item.total_stay + " days" : item.total_stay + " day"
                };
            });
        }
    },

    created() {
        this.loading = true;

        this.getReservations();

        this.getDataToExportExcel();

        setTimeout(() => {
            this.loading = false;
        }, 2000);
    },
};
</script>
