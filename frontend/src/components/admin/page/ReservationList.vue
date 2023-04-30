<template>
    <div class="m-3">
        <h5 class="indigo--text">User List</h5>
        <v-card>
            <v-sheet class="px-4 py-2" style="border-bottom: 1px solid #E0E0E0;">
                <v-row no-gutters>
                    <v-col cols="6">
                        <v-menu v-model="datepicker" :close-on-content-click="false" :nudge-right="40"
                            transition="scale-transition" offset-y min-width="auto">
                            <template v-slot:activator="{ on, attrs }">
                                <v-text-field v-model="date" solo flat prepend-icon="mdi-calendar" readonly v-bind="attrs"
                                    v-on="on" dense hide-details class="p-0"></v-text-field>
                            </template>
                            <v-date-picker v-model="date" @input="datepicker = false" :min="minDate"></v-date-picker>
                        </v-menu>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field v-model="search" dense label="Search" single-line hide-details
                            append-icon="mdi-magnify"></v-text-field>
                    </v-col>
                </v-row>
            </v-sheet>
            <v-row no-gutters>
                <v-col cols="3" class="pt-2" style="height:inherit; border-right: 1px solid #E0E0E0;">
                    <v-list flat subheader>
                        <v-subheader class="text-h6 indigo--text font-weight-medium">
                            Size
                        </v-subheader>
                        <v-list-item-group multiple v-model="selectedSize">
                            <template v-for="size in sizes">
                                <v-list-item :value="size" :ripple="false">
                                    <template v-slot:default="{ active }">
                                        <v-list-item-action class="mr-1">
                                            <v-checkbox :ripple="false" :input-value="active"
                                                :true-value="size.type = 'size'"></v-checkbox>
                                        </v-list-item-action>
                                        <v-list-item-content>
                                            <v-list-item-title v-text="size.name"></v-list-item-title>
                                        </v-list-item-content>
                                    </template>
                                </v-list-item>
                            </template>
                        </v-list-item-group>
                        <v-subheader class="text-h6 indigo--text font-weight-medium">
                            Services
                        </v-subheader>
                        <v-list-item-group multiple class="pl-2">
                            <template v-for="item in services">
                                <v-chip small class="m-1" outlined color="primary">
                                    {{ item.name }}
                                    <v-icon small right>
                                        {{ item.icon }}
                                    </v-icon>
                                </v-chip>
                            </template>
                        </v-list-item-group>
                    </v-list>
                </v-col>
                <v-col cols="9">
                    <v-container fluid class="pt-0">
                        <template v-for="floor in filteredRooms">
                            <div class="text-h6 indigo--text font-weight-medium mt-5">{{ floor.name }}</div>
                            <v-row dense class="px-3">
                                <template v-if="floor.rooms.length > 0">
                                    <template v-for="room in floor.rooms">
                                        <v-col cols="12" md="6" lg="4" xl="3">
                                            <v-hover v-slot="{ hover }">
                                                <v-card @click.prevent="openDialog(roomStatus(room), room)"
                                                    class="hover-card" :elevation="hover ? 12 : 2"
                                                    :class="{ 'on-hover': hover }" tile :color="statusColor(room)">
                                                    <v-img :src="roomImage(room)" class="white--text align-end"
                                                        gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)" height="100px">
                                                        <v-card-title>{{ room.number }}</v-card-title>
                                                    </v-img>
                                                    <v-card-actions>
                                                        <div class="text-subtitle-2">{{ room.size.name }}</div>
                                                        <v-spacer></v-spacer>
                                                        <div class="text-subtitle-2">{{ roomStatus(room) }}</div>
                                                    </v-card-actions>
                                                </v-card>
                                            </v-hover>
                                        </v-col>
                                    </template>
                                </template>
                                <template v-else>
                                    <div class="ml-0 pl-0 text-h6 grey--text text--lighten-1 font-weight-light">
                                        No room found
                                    </div>
                                </template>
                            </v-row>
                        </template>
                    </v-container>
                </v-col>
            </v-row>
        </v-card>
        <reservation-dialog v-if="dialog" :dialog="dialog" :status="status" :selectedRoom="room">
            <div v-if="status == 'Available'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Make Reservation
            </div>
            <div v-else slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Change Reservation
            </div>
        </reservation-dialog>
    </div>
</template>

<script>
import ReservationDialog from '../components/ReservationDialog.vue';
import axios from 'axios';
import { mapActions, mapGetters } from 'vuex';
export default {
    components: {
        "reservation-dialog": ReservationDialog
    },

    data() {
        return {
            minDate: new Date().toISOString().substr(0, 10),
            date: new Date().toISOString().substr(0, 10),
            datepicker: false,
            settings: [],
            floors: [],
            sizes: [],
            services: [],
            search: null,
            selectedSize: [],
            dialog: false,
            room: null,
            status: null,
        }
    },

    computed: {
        ...mapGetters({
            reservationRooms: "getReservationRooms"
        }),

        filteredRooms() {
            let rooms = this.reservationRooms;
            if (this.selectedSize.length > 0) {
                rooms = this.filterRoomsBySize(rooms, this.selectedSize);
            }
            if (this.search) {
                rooms = this.filterRoomsBySearchQuery(rooms, this.search);
            }
            return rooms;
        }
    },

    methods: {
        ...mapActions(["getReservationRooms"]),

        async prepareData() {
            let url = this.env.apiURL + "reservations/prepare-data";
            await axios.get(url).then((response) => {
                this.floors = response.data.floors;
                this.sizes = response.data.sizes;
                this.services = response.data.services;
            });
        },

        filterRoomsBySize(rooms, selectedSize) {
            return rooms.map(floor => {
                const roomOnEachFloor = selectedSize.flatMap(value => floor.rooms.filter(room => room.size.name.includes(value.name)));
                this.sortedArray(roomOnEachFloor);
                return { ...floor, rooms: roomOnEachFloor };
            });
        },

        filterRoomsBySearchQuery(rooms, search) {
            return rooms.map(floor => {
                const roomOnEachFloor = floor.rooms.filter(room => room.number.includes(search));
                return { ...floor, rooms: roomOnEachFloor };
            });
        },

        roomStatus(room) {
            if (room.reservations.length > 0 && room.reservations[0].active == 1) {
                if (room.reservations[0].status == "Pending") return "Pending";
                else if (room.reservations[0].status == "Reserved") return "Reserved";
            }
            return "Available";
        },

        statusColor(room) {
            if (room.reservations.length > 0 && room.reservations[0].active == 1) {
                if (room.reservations[0].status == "Pending") return "lime accent-1";
                else if (room.reservations[0].status == "Reserved") return "#94c494";
            }
            return null;
        },

        roomImage(room) {
            if (room.images.length > 0)
                return this.env.imageURL + room.images[0].name;
            return "/admin/img/room-default.png";
        },

        sortedArray(array) {
            function compare(a, b) {
                if (a.size.id < b.size.id) return -1;
                if (a.size.id > b.size.id) return 1;
                return 0;
            }
            return array.sort(compare);
        },

        openDialog(status, room) {
            this.status = status;
            this.room = Object.assign(room);
            this.dialog = true;
        }
    },

    created() {
        this.prepareData();
        this.getReservationRooms({ date: this.date });
    },

    watch: {
        date: {
            handler(value) {
                this.selectedSize = [];
                this.filteredRooms = [];
                this.getReservationRooms({ date: value });
            },
            deep: true,
        }
    }
}
</script>

<style scoped>
.hover-card {
    transition: opacity 0.5s ease-in-out;
}

.hover-card:not(.on-hover) {
    opacity: 0.7;
}
</style>