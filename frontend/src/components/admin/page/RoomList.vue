<template>
    <div class="m-3">
        <h5 class="indigo--text">Room List</h5>
        <v-card>
            <v-sheet class="pa-4" style="border-bottom: 1px solid #E0E0E0;">
                <v-row no-gutters>
                    <v-col cols="6">
                        <v-btn color="success" small class="mr-1 my-0" @click.prevent="openDialog('add', {})">
                            <v-icon left> mdi-plus </v-icon>
                            Add
                        </v-btn>
                        <v-btn color="warning" small class="mr-1 my-0" @click.prevent="openDialog('upd', room)">
                            <v-icon left> mdi-pencil-box </v-icon>
                            Edit
                        </v-btn>
                        <v-btn color="error" small class="mr-1 my-0" @click.prevent="openDialog('del', {})">
                            <v-icon left> mdi-delete </v-icon>
                            Delete
                        </v-btn>
                        <v-btn color="info" small class="my-0">
                            <v-icon left> mdi-file-excel </v-icon>
                            Export
                        </v-btn>
                    </v-col>
                    <v-col cols="6">
                        <v-text-field v-model="search" @input="handleSearch" dense label="Search" single-line hide-details
                            append-icon="mdi-magnify"></v-text-field>
                    </v-col>
                </v-row>
            </v-sheet>
            <v-row no-gutters>
                <v-col cols="3" class="pt-2" style="height:inherit; border-right: 1px solid #E0E0E0;">
                    <v-treeview ref="tree" :active.sync="active" :items="items" :load-children="fetchRooms" :search="search"
                        :open.sync="open" color="warning" activatable open-all open-on-click transition dense>
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
                <v-col cols="9">
                    <v-fade-transition mode="out-in">
                        <div v-if="!selected"
                            class="w-100 h-100 d-flex justify-content-center align-items-center text-h6 grey--text text--lighten-1 font-weight-light">
                            Select a Room
                        </div>
                        <v-card v-else :key="selected.id" class="pt-6" flat>
                            <v-row no-gutters class="pl-3 pb-3">
                                <v-col md="6">
                                    <v-carousel height="100%" hide-delimiters>
                                        <v-carousel-item v-for=" (image, i) in images" :key="i" :src="image.src"
                                            reverse-transition="fade-transition"></v-carousel-item>
                                    </v-carousel>
                                </v-col>
                                <v-col md="6">
                                    <v-row>
                                        <v-col class="text-right" tag="strong" cols="4">
                                            Number:
                                        </v-col>
                                        <v-col cols="8">{{ selected.number }}</v-col>
                                    </v-row>
                                    <v-row>
                                        <v-col class="text-right" tag="strong" cols="4">
                                            Name:
                                        </v-col>
                                        <v-col cols="8" lg="7" xl="6">{{ selected.name }}</v-col>
                                    </v-row>
                                    <v-row>
                                        <v-col class="text-right" tag="strong" cols="4">
                                            Type:
                                        </v-col>
                                        <v-col cols="8" lg="7" xl="6">{{ selected.type.name }}</v-col>
                                    </v-row>
                                    <v-row>
                                        <v-col class="text-right" tag="strong" cols="4">
                                            Size:
                                        </v-col>
                                        <v-col cols="8" lg="7" xl="6">{{ selected.size.name }}</v-col>
                                    </v-row>
                                    <v-row>
                                        <v-col class="text-right" tag="strong" cols="4">
                                            Price:
                                        </v-col>
                                        <v-col cols="8" lg="7" xl="6">{{ selected.price }}</v-col>
                                    </v-row>
                                </v-col>
                                <v-row class="mt-2">
                                    <v-col class="pl-1" tag="strong" md="3" lg="3" xl="2">
                                        Description:
                                    </v-col>
                                    <v-col cols="8" lg="9" xl="10" style="text-align: justify;">
                                        {{ selected.description }}
                                    </v-col>
                                </v-row>
                                <v-row class="mt-2">
                                    <v-col class="pl-1" tag="strong" md="3" lg="3" xl="2">
                                        Services:
                                    </v-col>
                                    <v-col cols="8" lg="9" xl="10" style="text-align: justify;">
                                        {{ selected.price }}
                                    </v-col>
                                </v-row>
                            </v-row>
                        </v-card>
                    </v-fade-transition>
                </v-col>
            </v-row>
        </v-card>
        <room-dialog v-if="dialog" :dialog="dialog" :action="action" :roomSelected="newRoom">
            <div v-if="action === 'add'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Add Room
            </div>
            <div v-if="action === 'upd'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Edit Room
            </div>
            <div v-if="action === 'det'" slot="header" class="ma-1 ml-2 text-subtitle-1 indigo--text">
                <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Show Room
            </div>
        </room-dialog>
    </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import RoomDialog from '../components/RoomDialog.vue'
import { EventBus } from '@/main'

const pause = ms => new Promise(resolve => setTimeout(resolve, ms))

export default {
    components: {
        "room-dialog": RoomDialog
    },

    data() {
        return {
            newRoom: {},
            action: "",
            dialog: false,
            active: [],
            avatar: null,
            open: [0],
            overlay: false,
            search: null,
            allOpened: false,
            lastOpen: [],
            images: [
                {
                    src: 'https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg',
                },
                {
                    src: 'https://cdn.vuetifyjs.com/images/carousel/sky.jpg',
                },
                {
                    src: 'https://cdn.vuetifyjs.com/images/carousel/bird.jpg',
                },
                {
                    src: 'https://cdn.vuetifyjs.com/images/carousel/planet.jpg',
                },
            ],
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
    },

    asyncComputed: {
        async selected() {
            if (!this.active.length) return undefined

            const number = this.active[0];
            console.log(this.active);
            await this.getRoom({ number: number });
            await pause(1000)

            return this.room;
        },
    },

    methods: {
        ...mapActions(["getRooms", "getRoom"]),

        async fetchRooms(item) {
            await this.getRooms();
            await pause(1000)
            return item.children.push(this.rooms);
        },

        openDialog(action, room) {
            this.action = action;
            this.newRoom = Object.assign(room);
            this.dialog = true;
        },


        addChild(item, room) {
            if (!item.children) {
                this.$set(item, "children", []);
            }
            const id = room.number;
            const name = room.number;
            item.children.push({ id, name });
        },

        findItem(id, items = null) {
            if (!items) items = this.items;
            return items.reduce((acc, item) => {
                if (acc) return acc;
                if (item.id === id) return item;
                if (item.children) return this.findItem(id, item.children);
                return acc;
            }, null);
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
        EventBus.$on("dialog", () => {
            this.dialog = false
        });

        EventBus.$on("addChild", (room) => {
            this.addChild(this.findItem(room.floor_id), room);
        })
    }
}
</script>