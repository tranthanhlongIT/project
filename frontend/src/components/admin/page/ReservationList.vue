<template>
    <div class="m-3">
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
                            <v-date-picker v-model="date" @input="datepicker = false"></v-date-picker>
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
                            Floor
                        </v-subheader>
                        <v-list-item-group multiple v-model="selected">
                            <template v-for="floor in floors">
                                <v-list-item :value="floor" :ripple="false">
                                    <template v-slot:default="{ active }">
                                        <v-list-item-action class="mr-1">
                                            <v-checkbox :ripple="false" :input-value="active"
                                                :true-value="floor.type = 'floor'"></v-checkbox>
                                        </v-list-item-action>
                                        <v-list-item-content>
                                            <v-list-item-title v-text="floor.name"></v-list-item-title>
                                        </v-list-item-content>
                                    </template>
                                </v-list-item>
                            </template>
                        </v-list-item-group>
                        <v-subheader class="text-h6 indigo--text font-weight-medium">
                            Size
                        </v-subheader>
                        <v-list-item-group multiple v-model="selected">
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
                        <v-list-item-group multiple v-model="selected" class="pl-2">
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
                        <template v-if="selected.length == 0">
                            <div class="text-h6 indigo--text font-weight-medium mt-5">Rooms</div>
                            <v-row dense class="px-3">
                                <template v-for="room in reservation_rooms">
                                    <v-col cols="12" md="6" lg="4" xl="4" xxl="3">
                                        <v-card tile :color="statusColor(room)">
                                            <v-img :src="roomImage(room)" class="white--text align-end"
                                                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)" height="100px">
                                                <v-card-title>{{ room.number }}</v-card-title>
                                            </v-img>
                                            <v-card-actions>
                                                <div class="text-subtitle-2">{{ room.type.name }}</div>
                                                <v-spacer></v-spacer>
                                                <div class="text-subtitle-2">{{ roomStatus(room) }}</div>
                                            </v-card-actions>
                                        </v-card>
                                    </v-col>
                                </template>
                            </v-row>
                        </template>
                        <template v-if="selected.length > 0">
                            <template v-for="filter in selected">
                                <div class="text-h6 indigo--text font-weight-medium mt-5">{{ filter.name }}</div>
                                <v-row dense class="px-3">
                                    <template v-for="room in floor_filter">
                                        <template v-if="filter.name == room.floor.name">
                                            <v-col cols="12" md="6" lg="4" xl="4" xxl="3">
                                                <v-card tile :color="statusColor(room)">
                                                    <v-img :src="roomImage(room)" class="white--text align-end"
                                                        gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)" height="100px">
                                                        <v-card-title>{{ room.number }}</v-card-title>
                                                    </v-img>
                                                    <v-card-actions>
                                                        <div class="text-subtitle-2">{{ room.type.name }}</div>
                                                        <v-spacer></v-spacer>
                                                        <div class="text-subtitle-2">{{ roomStatus(room) }}</div>
                                                    </v-card-actions>
                                                </v-card>
                                            </v-col>
                                        </template>
                                    </template>
                                </v-row>
                            </template>
                        </template>
                    </v-container>
                </v-col>
            </v-row>
        </v-card>
    </div>
</template>

<script>
import axios from 'axios';
import { mapActions, mapGetters } from 'vuex';
export default {
    components: {
    },

    computed: {
        ...mapGetters({
            reservation_rooms: "getReservationRooms"
        }),
    },

    data() {
        return {
            date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
            datepicker: false,
            settings: [],
            floors: [],
            sizes: [],
            services: [],
            search: null,
            selected: [],

            floor_filter: [],
            size_filter: [],
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

        toggleSelect(item) {
            if (this.selected.includes(item))
                this.selected.splice(this.selected.indexOf(item), 1);
            else this.selected.push(item);
        },

        roomStatus(room) {
            if (room.reservations.length > 0) {
                if (room.reservations[0].active == 1)
                    if (room.reservations[0].status == "Pending")
                        return "Pending";
                    else if (room.reservations[0].status == "Reserved")
                        return "Reserved";
            }
            return "Available";
        },

        statusColor(room) {
            if (room.reservations.length > 0) {
                if (room.reservations[0].active == 1)
                    if (room.reservations[0].status == "Pending")
                        return "lime accent-1";
                    else if (room.reservations[0].status == "Reserved")
                        return "light-green accent-1";
            }
            return null;
        },

        roomImage(room) {
            if (room.images.length > 0)
                return this.env.imageURL + room.images[0].name;
            return "/admin/img/room-default.png";
        },
    },

    created() {
        this.prepareData();
        this.getReservationRooms({ date: this.date });
    },

    watch: {
        selected: {
            handler(filters) {
                this.floor_filter = [];
                filters.forEach((filter) => {
                    let temp = [];
                    temp = this.reservation_rooms.filter((room) => room.floor.name === filter.name);
                    this.floor_filter = this.floor_filter.concat(temp);
                })
            },
            deep: true,
        }
    }
}
</script>

<style scoped></style>