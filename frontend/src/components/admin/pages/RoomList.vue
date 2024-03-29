<template>
    <div>
        <template v-if="canView">
            <div v-if="!loading" class="m-3">
                <h5 class="indigo--text">Room List</h5>
                <v-card>
                    <v-sheet class="px-4 py-2" style="border-bottom: 1px solid #E0E0E0;">
                        <v-row no-gutters>
                            <v-col cols="6" class="my-1 mb-2">
                                <v-btn color="success" small class="mr-1" @click.prevent="openDialog('add', {})">
                                    <v-icon left> mdi-plus </v-icon>
                                    Add
                                </v-btn>
                                <v-btn color="warning" small class="mr-1" @click.prevent="openDialog('upd', room)">
                                    <v-icon left>mdi-pencil-box</v-icon>
                                    Edit
                                </v-btn>
                                <v-btn color="error" small class="mr-1" @click.prevent="openConfirmation">
                                    <v-icon left> mdi-delete </v-icon>
                                    Delete
                                </v-btn>
                            </v-col>
                            <v-col cols="6">
                                <v-text-field v-model="search" @input="handleSearch" dense label="Search" single-line
                                    hide-details append-icon="mdi-magnify"></v-text-field>
                            </v-col>
                        </v-row>
                    </v-sheet>
                    <v-row no-gutters>
                        <v-col cols="3" xl="2" class="pt-2" style="height:inherit; border-right: 1px solid #E0E0E0;">
                            <v-treeview ref="tree" return-object :active.sync="active" :items="items"
                                :load-children="fetchRooms" :search="search" :open.sync="open" color="warning" activatable
                                open-all open-on-click transition dense>
                                <template v-slot:prepend="{ item }">
                                    <v-icon small color="green" class="mb-1" v-if="item.name == 'Room'">
                                        mdi-vuejs
                                    </v-icon>
                                    <v-icon color="blue" v-else-if="!item.children">
                                        mdi-bed
                                    </v-icon>
                                    <v-icon v-else>
                                        mdi-home
                                    </v-icon>
                                </template>
                            </v-treeview>
                        </v-col>
                        <v-col cols="9" xl="10">
                            <v-fade-transition mode="out-in">
                                <div v-if="!selected"
                                    class="w-100 h-100 d-flex justify-content-center align-items-center text-h6 grey--text text--lighten-1 font-weight-light">
                                    Select a Room
                                </div>
                                <v-card class="w-100 h-100 pb-5" v-else :key="room.id" flat>
                                    <v-row class="pl-3 pb-3">
                                        <v-col cols="12" lg="7">
                                            <v-img height="300" v-for="image in room.images" :key="image.id"
                                                :src="env.imageURL + image.name" />
                                        </v-col>
                                        <v-col cols="12" lg="5">
                                            <v-row>
                                                <div class="text-h4 text--secondary">{{ room.name }}</div>
                                            </v-row>
                                            <v-row class="mt-5">
                                                <div class="text--secondary font-weight-light">Number {{ room.number }}
                                                </div>
                                            </v-row>
                                            <v-row class="mt-5" no-gutters>
                                                <v-divider color="silver"></v-divider>
                                            </v-row>
                                            <v-row class="mt-0 pt-0">
                                                <v-col cols="12 pt-0">
                                                    <div class="text-secondary">SERVICES</div>
                                                </v-col>
                                                <v-col cols="12" class="my-0 py-0">
                                                    <v-chip v-for="service in room.services" :key="service.id"
                                                        class="mr-1 mb-1" color="primary" outlined small>
                                                        {{ service.name }}
                                                        <v-icon right small>
                                                            {{ service.icon }}
                                                        </v-icon>
                                                    </v-chip>
                                                </v-col>
                                            </v-row>
                                            <v-row class="mt-5" no-gutters>
                                                <v-divider color="silver"></v-divider>
                                            </v-row>
                                            <v-row class="mt-0 pt-0">
                                                <div>
                                                    <div class="text-secondary d-inline">Type: </div>
                                                    <div class="text-secondary font-weight-light d-inline">
                                                        {{ room.type.name }}
                                                    </div>
                                                </div>
                                            </v-row>
                                            <v-row class="mt-3 pt-3">
                                                <div>
                                                    <div class="text-secondary d-inline">Price: </div>
                                                    <div class="text-secondary font-weight-light d-inline">
                                                        {{ room.price | toCurrency }}
                                                    </div>
                                                </div>
                                            </v-row>
                                            <v-row class="mt-3 pt-3">
                                                <div>
                                                    <div class="text-secondary d-inline">Size: </div>
                                                    <div class=" d-inline">
                                                        <v-chip class="mr-1 mb-1" color="primary" outlined small>
                                                            {{ room.size.name }}
                                                            <v-icon right small>
                                                                {{ room.size.icon }}
                                                            </v-icon>
                                                        </v-chip>
                                                    </div>
                                                </div>
                                            </v-row>
                                            <v-row class="mt-5" no-gutters>
                                                <v-divider color="silver"></v-divider>
                                            </v-row>
                                            <v-row class="mt-0 pt-0 pr-3">
                                                <div class="text-justify text-secondary">
                                                    {{ room.description }}
                                                </div>
                                            </v-row>
                                        </v-col>
                                    </v-row>
                                </v-card>
                            </v-fade-transition>
                        </v-col>
                    </v-row>
                </v-card>

                <room-dialog v-if="dialog" :dialog="dialog" :action="action" :selectedRoom="newRoom">
                    <div v-if="action == 'add'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Add Room
                    </div>
                    <div v-if="action == 'upd'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Edit Room
                    </div>
                    <div v-if="action == 'det'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Show Room
                    </div>
                </room-dialog>

                <confirmation-dialog v-if="confirmation" :object="room" action="deleteRoom" :confirmation="confirmation"
                    type="del">
                    <div slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                        <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Delete Room
                    </div>
                    <div slot="message" class="text-center text-subtitle-1">Are you sure want to delete</div>
                </confirmation-dialog>
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
import { mapActions, mapGetters } from 'vuex';
import { EventBus } from '@/main';

import RoomDialog from '../components/dialogs/RoomDialog.vue';
import ConfirmationDialog from '../components/dialogs/ConfirmationDialog.vue';
import NoPermissionCard from "../components/layouts/NoPermissionCard.vue"

const pause = ms => new Promise(resolve => setTimeout(resolve, ms))

export default {
    components: {
        "room-dialog": RoomDialog,
        "confirmation-dialog": ConfirmationDialog,
        "no-permission": NoPermissionCard
    },

    data() {
        return {
            newRoom: {},
            action: null,
            dialog: false,
            confirmation: false,
            active: [],
            avatar: null,
            open: [0],
            overlay: false,
            search: null,
            allOpened: false,
            treeViewKey: 0,
            lastOpen: [],
            images: [],
            oldRoomFloor: null,

            loading: false,
        }
    },

    computed: {
        ...mapGetters({
            rooms: "getRooms",
            room: "getRoom"
        }),

        items() {
            return [
                {
                    id: 0,
                    name: 'Room',
                    children: this.rooms,
                },
            ]
        },

        canView() {
            if (this.auth.user.role.name == "admin") {
                return true;
            }

            if (this.auth.user.role.name == "manager") {
                return true;
            }

            return false;
        }
    },

    asyncComputed: {
        async selected() {
            if (!this.active.length) return undefined;
            const number = this.active[0].id;
            await this.getRoom({ number: number });
            await pause(1000);
            return this.room;
        },
    },

    methods: {
        ...mapActions(["getRooms", "getRoom"]),

        async fetchRooms(item) {
            await this.getRooms();
            await pause(1000);
            return item.children.push(this.rooms);
        },

        openDialog(action, room) {
            this.action = action;
            this.newRoom = Object.assign(room);
            this.oldRoomFloor = room.flood?.id ?? null;
            if (action == "upd" && this.selected) this.dialog = true;
            else if (action != "upd") this.dialog = true;
        },

        openConfirmation() {
            if (this.selected) {
                this.confirmation = true;
            }
        },

        addChild(item, room) {
            if (!item.children) this.$set(item, "children", []);
            const id = room.number;
            const name = room.number;
            item.children.push({ id, name });
        },

        updateChild(room) {
            this.active = [];
            this.deleteChild();
            this.addChild(this.findItem(room.floor.id), room);
        },

        deleteChild() {
            for (let floor of this.items[0].children) {
                let index = floor.children.findIndex(room => room.id === this.active[0].id);
                if (index !== -1) {
                    floor.children.splice(index, 1);
                    break;
                }
            }

            this.active = [];
        },

        findItem(id, items = null) {
            if (!items) items = this.items;
            return items.reduce((acc, item) => {
                if (acc) return acc;
                if (item.id == id) return item;
                if (item.children) return this.findItem(id, item.children);
                return acc;
            }, null)
        },

        handleSearch: function (val) {
            if (val) {
                if (!this.allOpened) {
                    this.lastOpen = this.open;
                    this.allOpened = true;
                    this.$refs.tree.updateAll(true);
                }
            } else {
                this.$refs.tree.updateAll(false);
                this.allOpened = false;
                this.open = this.lastOpen;
            }
        },
    },

    created() {
        this.loading = true;

        EventBus.$on("closeDialog", () => {
            this.dialog = false;
        })

        EventBus.$on("addChild", (room) => {
            this.addChild(this.findItem(room.floor.id), room);
        })

        EventBus.$on("updateChild", (room) => {
            if (this.oldRoomNumber != room.number)
                this.updateChild(room);
        })

        EventBus.$on("deleteChild", () => {
            this.deleteChild();
        })

        EventBus.$on("closeConfirmation", () => {
            this.confirmation = false;
        });

        setTimeout(() => {
            this.loading = false;
        }, 1000);
    },
}
</script>