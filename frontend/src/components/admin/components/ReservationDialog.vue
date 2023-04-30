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
                        <v-container>
                            <v-row>
                                <v-col cols="12" lg="7" xl="6" style="border-right: 1px solid #E0E0E0;">

                                </v-col>
                                <v-col cols="12" lg="5" xl="6" class="pt-0">

                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>
                    <v-divider color="grey" class="m-0 p-0"></v-divider>
                    <v-card-actions class="pb-0">
                        <v-spacer></v-spacer>
                        <v-btn type="submit" class="mb-2" elevation="2" small color="primary" @click.prevent="onHandle">
                            Save
                        </v-btn>
                        <v-btn type="button" class="mr-5 mb-3" elevation="2" small color="warning"
                            @click.prevent="closeDialog">
                            Back
                        </v-btn>
                    </v-card-actions>
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