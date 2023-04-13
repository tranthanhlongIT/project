<template>
    <v-row justify="center" class="m-0 p-0">
        <v-dialog v-model="show" persistent :width="width">
            <v-card width="100vw">
                <form>
                    <v-card-title class="m-0 p-0">
                        <slot name="header" class="text-subtitle-1">Default header</slot>
                        <v-spacer></v-spacer>
                        <v-btn icon @click="closeDialog" :ripple="false" plain>
                            <v-icon>mdi-close</v-icon>
                        </v-btn>
                    </v-card-title>
                    <v-divider color="grey" class="m-0 p-0"></v-divider>
                    <v-card-text class="m-0 p-0">
                        <v-container>
                            <v-row class="ml-1">
                                <v-col cols="6" class="pl-0">
                                    <v-select v-model="floor" item-text="name" item-value="id" :items="floors" label="Floor"
                                        :menu-props="{ bottom: true, offsetY: true }" dense></v-select>
                                </v-col>
                                <v-col cols="6" class="pl-0">
                                    <v-select v-model="type" item-text="name" item-value="id" :items="types" label="Type"
                                        :menu-props="{ bottom: true, offsetY: true }" dense></v-select>
                                </v-col>
                                <v-col cols="4" class="pl-0">
                                    <v-text-field v-model="number" label="Room number" dense></v-text-field>
                                </v-col>
                                <v-col cols="8" class="pl-0">
                                    <v-text-field v-model="name" label="Room name" dense></v-text-field>
                                </v-col>
                                <v-col cols="12" class="pl-0 mt-0 pt-0">
                                    <v-textarea filled label="Description" hide-details></v-textarea>
                                </v-col>
                                <v-col cols="6" class="pl-0">
                                    <!-- <v-select v-model="size" item-text="name" item-value="id" :items="sizes" label="Size"
                                        :menu-props="{ bottom: true, offsetY: true }" dense></v-select> -->
                                    <v-select v-model="size" :items="sizes" label="Size" item-text="name" item-value="id"
                                        small-chips :menu-props="{ bottom: true, offsetY: true }" dense>
                                        <template #selection="{ item }">
                                            <v-chip color="teal" text-color="white" small>
                                                {{ item.name }}
                                                <v-icon>mdi-human-capacity-increase</v-icon>
                                            </v-chip>
                                        </template>
                                    </v-select>
                                </v-col>
                                <v-col cols="6" class="pl-0">
                                    <v-text-field v-model="number" @blur="$v.number.$touch()" label="First name"
                                        dense></v-text-field>
                                </v-col>
                                <v-col cols="12" class="pl-0">
                                    <v-select v-model="service" item-text="name" item-value="id" :items="services"
                                        :menu-props="{ bottom: true, offsetY: true }" label="Services" multiple dense
                                        hide-details></v-select>
                                </v-col>
                                <v-col cols="12" class="pl-0">
                                    <v-file-input small-chips multiple label="Upload Image"></v-file-input>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>
                    <v-divider color="grey" class="m-0 p-0"></v-divider>
                    <v-card-actions class="pb-0">
                        <v-spacer></v-spacer>
                        <v-btn type="submit" class="mb-2" elevation="2" small color="primary"
                            v-if="action == 'add' || action == 'upd'" :hidden="action == 'det' ? true : false"
                            @click.prevent="onHandle">
                            Save
                        </v-btn>
                        <v-btn type="button" class="mr-5 mb-3" elevation="2" small color="warning"
                            @click.stop="closeDialog">
                            Back
                        </v-btn>
                    </v-card-actions>
                </form>
            </v-card>
        </v-dialog>
    </v-row>
</template>

<script>
import { validationMixin } from "vuelidate";
import {
    required,
    maxLength,
    minLength,
    email,
} from "vuelidate/lib/validators";
import axios from "axios";

export default {
    mixins: [validationMixin],

    validations: {
        type: { required },
        floor: { required },

        number: {
            required,
            valid: function (value) {
                const allNumber = /^\d+$/.test(value);
                return allNumber;
            },
        },
        name: { required, maxLength: maxLength(30) },

    },

    data() {
        return {
            room: {},
            sizes: [],
            types: [],
            floors: [],
            services: [],
            images: [],

            floor: false,
            type: null,
            number: null,
            name: null,
            description: null,
            size: null,
            price: null,
            service: null,

            show: false,
            file: null,
        }
    },

    props: {
        dialog: Boolean,
        action: String,
        roomSelected: Object,
    },

    computed: {


        width() {
            switch (this.$vuetify.breakpoint.name) {
                case 'md': return "60%";
                case 'lg': return "50%";
                case 'xl': return "40%";
                default: return "100%";
            }
        }
    },

    methods: {
        async prepareData() {
            let url = this.env.apiURL + "rooms/preparedata";
            await axios.get(url).then((response) => {
                this.types = response.data.types;
                this.floors = response.data.floors;
                this.sizes = response.data.sizes;
                this.services = response.data.services;
            });
        },
    },

    created() {
        this.show = this.dialog;

        this.prepareData();
    }
}
</script>
