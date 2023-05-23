<template>
    <div class="m-3 no-select">
        <h5 class="indigo--text">Dashboard</h5>
        <v-row no-gutters>
            <v-col cols="8">
                <v-row no-gutters>
                    <v-col cols="6" class="pr-2 mb-3">
                        <v-card color="#222e3c" dark height="300">
                            <v-card-title>Rooms</v-card-title>
                            <v-card-text>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title class="d-flex">
                                            <div>Total Rooms: </div>
                                            <div>{{ totalRooms }}</div>
                                        </v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Reserved Rooms: {{ reservedRooms }}</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Vacant Rooms: {{ vacantRooms }}</v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-card-text>
                        </v-card>
                    </v-col>
                    <v-col cols="6" class="pr-2 mb-3">
                        <v-card color="#222e3c" dark height="300">
                            <v-card-title>Total Reservation in Day</v-card-title>
                            <v-card-text>
                                <pie-chart />
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row no-gutters>
                    <v-col cols="12" class="pr-2">
                        <v-card>
                            <v-card-title>Revenue in Month</v-card-title>
                            <v-card-text>
                                <bar-chart />
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
            </v-col>
            <v-col cols="4">
                <v-row no-gutters>
                    <v-col cols="12">
                        <v-card height="792">
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
import BarChart from "../components/charts/BarChart.vue"
import PieChart from "../components/charts/PieChart.vue"
import axios from "axios"

export default {
    components: {
        "bar-chart": BarChart,
        "pie-chart": PieChart
    },

    data() {
        return {
            totalRooms: null,
            reservedRooms: null,
            vacantRooms: null
        }
    },

    methods: {
        async prepareData() {
            let url = this.env.apiURL + "dashboard/room-data";
            await axios.get(url).then((response) => {
                this.totalRooms = response.data.totalRooms;
                this.reservedRooms = response.data.reservedRooms;
                this.vacantRooms = response.data.vacantRooms;
            })
        },
    },

    created() {
        this.prepareData();
    }
}
</script>

<style>
.no-select {
    -webkit-touch-callout: none;
    /* iOS Safari */
    -webkit-user-select: none;
    /* Safari */
    -khtml-user-select: none;
    /* Konqueror HTML */
    -moz-user-select: none;
    /* Old versions of Firefox */
    -ms-user-select: none;
    /* Internet Explorer/Edge */
    user-select: none;
    /* Non-prefixed version, currently supported by Chrome, Edge, Opera and Firefox */
}
</style>
