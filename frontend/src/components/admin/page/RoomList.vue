<template>
    <div class="m-2">
        <h5 class="indigo--text">Room List</h5>
        <v-card>
            <v-row>
                <v-col cols="3">
                    <v-treeview :active.sync="active" :items="items" :load-children="fetchRooms" :open.sync="open"
                        activatable color="warning" open-all transition>
                        <template v-slot:prepend="{ item }">
                            <v-icon v-if="!item.children">
                                fa fa-bed
                            </v-icon>
                        </template>
                    </v-treeview>
                </v-col>
                <v-col class="d-flex-inline">
                    <v-scroll-y-transition mode="out-in">
                        <div v-if="!selected" class="text-h6 grey--text text--lighten-1 font-weight-light"
                            style="align-self: center;">
                            Select a Room
                        </div>
                        <v-card v-else :key="selected.id" class="pt-6" flat>
                            <v-row no-gutter>
                                <v-col cols="12" md="6" lg="5" xl="4">
                                </v-col>
                                <v-col cols="12" md="6" lg="7" xl="8" no-gutters>
                                    <v-row>
                                        <v-col class="text-right" tag="strong" cols="3">
                                            Company:
                                        </v-col>
                                        <v-col cols="9">{{ selected.id }}</v-col>
                                    </v-row>
                                </v-col>
                            </v-row>
                        </v-card>
                    </v-scroll-y-transition>
                </v-col>
            </v-row>
        </v-card>
    </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

const pause = ms => new Promise(resolve => setTimeout(resolve, ms))

export default {
    data: () => ({
        active: [],
        avatar: null,
        open: [],
    }),

    computed: {
        ...mapGetters({
            rooms: "getRooms"
        }),

        items() {
            return [
                {
                    name: 'Room',
                    children: this.rooms,
                },
            ]
        },

        selected() {
            if (!this.active.length) return undefined

            const id = this.active[0]

            return this.getRoom({ id: id });

            // return this.rooms.find(room => room.id === id)
        },
    },

    watch: {
        selected: 'randomAvatar',
    },

    methods: {
        ...mapActions(["getRooms", "getRoom"]),

        async fetchRooms(item) {
            await this.getRooms();

            await pause(1500)

            return item.children.push(this.rooms);
        },
    },
}
</script>