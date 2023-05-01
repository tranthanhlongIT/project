<template>
    <v-row justify="center" class="m-0 p-0">
        <v-dialog v-model="show" persistent fullscreen>
            <v-card width="100vw" height="100%">
                <form>
                    <v-card-title class=" m-0 p-0">
                        <slot name="header" class="text-subtitle-1">Default header</slot>
                        <v-spacer></v-spacer>
                        <v-btn icon @click.prevent="closeDialog" :ripple="false" plain>
                            <v-icon>mdi-close</v-icon>
                        </v-btn>
                    </v-card-title>
                    <v-divider color="grey" class="m-0 p-0"></v-divider>
                    <v-card-text class="m-0 p-0">
                        <v-tabs v-model="tab">
                            <v-tab>
                                Reservations
                            </v-tab>
                            <v-tab>
                                Add Guest
                            </v-tab>
                        </v-tabs>
                    </v-card-text>
                </form>
            </v-card>
        </v-dialog>
    </v-row>
</template>

<script>
export default {
    data() {
        return {
            show: false,
            tab: null,

        }
    },

    props: {
        dialog: Boolean,
        status: String,
        selectedRoom: Object,
    },

    computed: {

    },

    method: {

    },

    created() {
        this.show = this.dialog;
    }
}
</script>