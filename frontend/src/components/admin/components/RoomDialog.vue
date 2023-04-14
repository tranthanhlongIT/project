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
                            <v-row>
                                <v-col cols="6">
                                    <file-pond name="test" ref="pond" label-idle="Drop files here..."
                                        v-bind:allow-multiple="true" accepted-file-types="image/jpeg, image/png"
                                        server="/api" v-bind:files="files" />
                                </v-col>
                                <v-col cols="6">
                                    <v-row class="ml-1">
                                        <v-col cols="6" class="pl-0">
                                            <v-select v-model="floor" item-text="name" item-value="id" :items="floors"
                                                label="Floor" :error-messages="floorErrors" @blur="$v.floor.$touch()"
                                                :menu-props="{ bottom: true, offsetY: true }" dense></v-select>
                                        </v-col>
                                        <v-col cols="6" class="pl-0">
                                            <v-text-field v-model="number" :error-messages="numberErrors"
                                                @blur="$v.number.$touch()" label="Room number" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pl-0">
                                            <v-text-field v-model="name" :error-messages="nameErrors"
                                                @blur="$v.name.$touch()" label="Room name" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pl-0 mt-0 pt-0">
                                            <v-textarea v-model="description" filled label="Description (optional)"
                                                hide-details></v-textarea>
                                        </v-col>
                                        <v-col cols="4" class="pl-0">
                                            <v-select v-model="type" item-text="name" item-value="id" :items="types"
                                                label="Type" :error-messages="typeErrors" @blur="$v.type.$touch()"
                                                :menu-props="{ bottom: true, offsetY: true }" dense></v-select>
                                        </v-col>
                                        <v-col cols="4" class="pl-0">
                                            <v-select v-model="size" :items="sizes" item-text="name" item-value="id"
                                                label="Size" :error-messages="sizeErrors" @blur="$v.size.$touch()"
                                                small-chips :menu-props="{ bottom: true, offsetY: true }" dense>
                                                <template #selection="{ item }">
                                                    <v-chip color="teal" text-color="white" x-small>
                                                        {{ item.name }}
                                                        <v-icon x-small>{{ item.icon }}</v-icon>
                                                    </v-chip>
                                                </template>
                                            </v-select>
                                        </v-col>
                                        <v-col cols="4" class="pl-0">
                                            <v-text-field v-model="price" prefix="$" :error-messages="priceErrors"
                                                @blur="$v.price.$touch()" label="Price" type="number" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="6" class="pl-0">
                                            <v-select v-model="service" item-text="name" item-value="id" :items="services"
                                                :error-messages="serviceErrors" @blur="$v.service.$touch()"
                                                :menu-props="{ bottom: true, offsetY: true }" label="Services" multiple
                                                dense hide-details>
                                                <template #selection="{ item }">
                                                    <v-chip color="teal" text-color="white" x-small>
                                                        {{ item.name }}
                                                        <v-icon x-small>{{ item.icon }}</v-icon>
                                                    </v-chip>
                                                </template>
                                            </v-select>
                                        </v-col>
                                        <!-- <v-col cols="6" class="pl-0">
                                            <v-file-input v-model="file" small-chips multiple label="Upload Image"
                                                :error-messages="fileErrors" dense>
                                                <template #selection="{ index, text }">
                                                    <v-chip v-if="index < 2" x-small>
                                                        {{ text }}
                                                    </v-chip>
                                                    <span v-if="index == 2" class="grey--text text-caption">
                                                        +{{ file.length - 2 }} others
                                                    </span>
                                                </template>
                                            </v-file-input>
                                        </v-col> -->
                                    </v-row>
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
                        <v-btn type="button" class="mr-5 mb-3" elevation="2" small color="warning" @click="closeDialog">
                            Back
                        </v-btn>
                    </v-card-actions>
                </form>
            </v-card>
        </v-dialog>
    </v-row>
</template>

<script>
// Import Vue FilePond
import vueFilePond from "vue-filepond";

// Import FilePond styles
import "filepond/dist/filepond.min.css";

// Import FilePond plugins
// Please note that you need to install these plugins separately

// Import image preview plugin styles
import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css";

// Import image preview and file type validation plugins
import FilePondPluginFileValidateType from "filepond-plugin-file-validate-type";
import FilePondPluginImagePreview from "filepond-plugin-image-preview";

// Create component
const FilePond = vueFilePond(
    FilePondPluginFileValidateType,
    FilePondPluginImagePreview
);

import { validationMixin } from "vuelidate";
import {
    required,
    maxLength,
} from "vuelidate/lib/validators";
import axios from "axios";
import { EventBus } from "@/main";
import { mapActions } from "vuex";

export default {
    mixins: [validationMixin],

    validations: {
        type: { required },
        floor: { required },
        size: { required },
        service: { required },
        price: { required },
        file: { required },
        name: { required, maxLength: maxLength(30) },
        number: {
            required,
            valid: function (value) {
                const restrictZero = /^[1-9][0-9]*$/.test(value);
                return restrictZero;
            },
            validNumber: function (value) {
                const allNumber = /^\d+$/.test(value);
                return allNumber;
            },
        },
    },

    components: {
        FilePond,
    },

    data() {
        return {
            room: {},
            sizes: [],
            types: [],
            floors: [],
            services: [],
            images: [],

            floor: 1,
            type: 1,
            number: "101",
            name: "test",
            description: "test",
            size: 1,
            price: "20000",
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
        typeErrors() {
            const errors = [];
            if (!this.$v.type.$dirty) return errors;
            !this.$v.type.required && errors.push("Type is required");
            return errors;
        },

        floorErrors() {
            const errors = [];
            if (!this.$v.floor.$dirty) return errors;
            !this.$v.floor.required && errors.push("Floor is required");
            return errors;
        },

        sizeErrors() {
            const errors = [];
            if (!this.$v.size.$dirty) return errors;
            !this.$v.size.required && errors.push("Size is required");
            return errors;
        },

        priceErrors() {
            const errors = [];
            if (!this.$v.price.$dirty) return errors;
            !this.$v.price.required && errors.push("Price is required");
            return errors;
        },

        serviceErrors() {
            const errors = [];
            if (!this.$v.service.$dirty) return errors;
            !this.$v.service.required && errors.push("Service is required");
            return errors;
        },

        fileErrors() {
            const errors = [];
            if (!this.$v.file.$dirty) return errors;
            !this.$v.file.required && errors.push("File is required");
            return errors;
        },

        nameErrors() {
            const errors = [];
            if (!this.$v.name.$dirty) return errors;
            !this.$v.name.maxLength &&
                errors.push("Room name must be at most 30 characters long");
            !this.$v.name.required && errors.push("Room name is required.");
            return errors;
        },

        numberErrors() {
            const errors = [];
            if (!this.$v.number.$dirty) return errors;
            !this.$v.number.required && errors.push("Room number is required.");
            !this.$v.number.validNumber && errors.push("Room number must be digit only");
            !this.$v.number.valid && errors.push("Room number must not begin with 0");
            return errors;
        },

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
        ...mapActions(["addRoom"]),

        setRoom() {
            this.room.type_id = this.type;
            this.room.floor_id = this.floor;
            this.room.size_id = this.size;
            this.room.number = this.number;
            this.room.name = this.name;
            this.room.description = this.description;
            this.room.price = this.price;
            this.room.service = this.service;
        },

        setField() {
            this.room = Object.assign(this.roomSelected);
            this.type = this.room.email;
            this.floor = this.room.floor_id;
            this.size = this.room.size_id;
            this.number = this.room.number;
            this.name = this.room.name;
            this.description = this.room.description;
            this.price = this.room.price;
            this.service = this.room.service;
        },

        resetField() {
            this.room = {};
            this.type = null;
            this.floor = null;
            this.size = null;
            this.number = null;
            this.name = null;
            this.description = null;
            this.price = null;
            this.service = null;
            this.image = null;
            this.file = null;
            this.$v.$reset();
        },

        async prepareData() {
            let url = this.env.apiURL + "rooms/preparedata";
            await axios.get(url).then((response) => {
                this.types = response.data.types;
                this.floors = response.data.floors;
                this.sizes = response.data.sizes;
                this.services = response.data.services;
            });
        },

        onHandle() {
            if (!this.validation()) return;

            if (this.action == "add") {
                this.setRoom();
                this.addRoom({ room: this.room, file: this.file });
            }
        },

        closeDialog() {
            EventBus.$emit("dialog");
        },

        validation() {
            if (this.action == "add") {
                this.$v.$touch();
                if (this.$v.$invalid) return false;
            }

            return true;
        }
    },

    created() {
        this.show = this.dialog;

        this.prepareData();
    },

}
</script>
