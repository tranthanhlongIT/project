<template>
    <v-row justify="center" class="m-0 p-0">
        <v-dialog v-model="show" persistent :width="width">
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
                                <v-col cols="7" style="border-right: 1px solid #E0E0E0;">
                                    <v-row class="ml-1">
                                        <v-col cols="6" class="pl-0 pt-0">
                                            <v-select v-model="floor" item-text="name" item-value="id" :items="floors"
                                                label="Floor" :error-messages="floorErrors" @blur="$v.floor.$touch()"
                                                :menu-props="{ bottom: true, offsetY: true }" return-object
                                                dense></v-select>
                                        </v-col>
                                        <v-col cols="6" class="pl-0 pt-0">
                                            <v-text-field v-model="number" :error-messages="numberErrors"
                                                @blur="$v.number.$touch()" label="Room number" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pl-0 pt-0">
                                            <v-text-field v-model="name" :error-messages="nameErrors"
                                                @blur="$v.name.$touch()" label="Room name" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pl-0 mt-0 pt-0">
                                            <v-textarea v-model="description" label="Description (optional)"
                                                hide-details></v-textarea>
                                        </v-col>
                                        <v-col cols="4" class="pl-0">
                                            <v-select v-model="type" item-text="name" item-value="id" :items="types"
                                                label="Type" :error-messages="typeErrors" @blur="$v.type.$touch()"
                                                :menu-props="{ bottom: true, offsetY: true }" return-object
                                                dense></v-select>
                                        </v-col>
                                        <v-col cols="4" class="pl-0">
                                            <v-select v-model="size" :items="sizes" item-text="name" item-value="id"
                                                label="Size" :error-messages="sizeErrors" @blur="$v.size.$touch()"
                                                small-chips :menu-props="{ auto: true, bottom: true, offsetY: true }"
                                                return-object dense>
                                                <template #selection="{ item }">
                                                    <v-chip color="teal" text-color="white" x-small>
                                                        {{ item.name }}
                                                        <v-icon x-small class="ml-1">{{ item.icon }}</v-icon>
                                                    </v-chip>
                                                </template>
                                            </v-select>
                                        </v-col>
                                        <v-col cols="4" class="pl-0">
                                            <v-text-field v-model="price" prefix="$" :error-messages="priceErrors"
                                                @blur="$v.price.$touch()" label="Price" type="number" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pl-0 pt-0">
                                            <v-select v-model="service" item-text="name" item-value="id" :items="services"
                                                :error-messages="serviceErrors" @blur="$v.service.$touch()"
                                                :menu-props="{ auto: true, bottom: true, offsetY: true }" label="Services"
                                                multiple return-object dense>
                                                <template #selection="{ item, index, attrs }">
                                                    <v-chip v-if="index < 5" color="teal" text-color="white" x-small>
                                                        {{ item.name }}
                                                        <v-icon x-small class="ml-1">{{ item.icon }}</v-icon>
                                                    </v-chip>
                                                    <span v-if="index >= 5" class="grey--text text-caption">
                                                        +{{ service.length - 5 }} others
                                                    </span>
                                                </template>
                                            </v-select>
                                        </v-col>
                                    </v-row>
                                </v-col>
                                <v-col cols="5" class="pt-0">
                                    <v-row no-gutters>
                                        <div class="text-subtitle-2 pl-0">Upload Image</div>
                                        <v-divider color="blue"></v-divider>
                                    </v-row>
                                    <v-row no-gutters>
                                        <v-col cols="12">
                                            <vue-custom-scrollbar class="scroll-area" :settings="settings">
                                                <file-pond name="images" :files="files" @init="onFileInit"
                                                    @updatefiles="onFileChange" v-bind:required="true" ref="pond"
                                                    class-name="my-pond" allow-multiple
                                                    accepted-file-types="image/jpeg, image/png" credits=""
                                                    :server="server" />
                                            </vue-custom-scrollbar>
                                        </v-col>
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
import vueFilePond from "vue-filepond";
import FilePondPluginFileValidateType from "filepond-plugin-file-validate-type";
import FilePondPluginImagePreview from "filepond-plugin-image-preview";
import "filepond/dist/filepond.min.css";
import "filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css";

import vueCustomScrollbar from 'vue-custom-scrollbar'
import "vue-custom-scrollbar/dist/vueScrollbar.css"

const FilePond = vueFilePond(
    FilePondPluginFileValidateType,
    FilePondPluginImagePreview,
);

import { validationMixin } from "vuelidate";
import { required, maxLength, } from "vuelidate/lib/validators";
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
        files: { required },
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
        vueCustomScrollbar
    },

    data() {
        return {
            room: {},
            sizes: [],
            types: [],
            floors: [],
            services: [],
            images: [],

            floor: {},
            type: {},
            number: null,
            name: null,
            description: null,
            size: {},
            price: null,
            service: [],
            files: [],

            show: false,
            settings: {
                suppressScrollY: false,
                suppressScrollX: true,
                wheelPropagation: false,
                wheelSpeed: 0.2
            },
            server: {
                url: "http://127.0.0.1:8000/api",
                timeout: 7000,
                process: null,
                load: '/storage/app/images',
                revert: null,
                remove: null,
            }
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
            if (!this.$v.files.$dirty) return errors;
            !this.$v.files.required && errors.push("Image is required");
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
                case 'lg': return "70%";
                case 'xl': return "60%";
                default: return "100%";
            }
        }
    },

    methods: {
        ...mapActions(["addRoom", "updateRoom"]),

        setRoom() {
            this.room.type_id = this.type.id;
            this.room.type = this.type.name;
            this.room.floor_id = this.floor.id;
            this.room.floor = this.floor.name;
            this.room.size_id = this.size.id;
            this.room.size = this.size.name;
            this.room.number = this.number;
            this.room.name = this.name;
            this.room.description = this.description;
            this.room.price = this.price;
            this.room.services = this.service;
            this.room.images = this.files.filter(file => file.name);
        },

        setField() {
            const { type_id, type, floor_id, floor, size_id, size, number, name, description, price, services, images } = this.roomSelected;
            this.room = Object.assign({}, this.roomSelected);
            this.type = { id: type_id, name: type };
            this.floor = { id: floor_id, name: floor };
            this.size = { id: size_id, name: size };
            this.number = number;
            this.name = name;
            this.description = description;
            this.price = price;
            this.service = services;
            this.images = images;
        },

        resetField() {
            this.room = {};
            this.type = {};
            this.floor = {};
            this.size = {};
            this.number = null;
            this.name = null;
            this.description = null;
            this.price = null;
            this.service = [];
            this.images = [];
            this.files = [];
            this.$v.$reset();
        },

        async prepareData() {
            let url = this.env.apiURL + "rooms/prepare-data";
            await axios.get(url).then((response) => {
                this.types = response.data.types;
                this.floors = response.data.floors;
                this.sizes = response.data.sizes;
                this.services = response.data.services;
            });
        },

        onHandle() {
            if (this.validation()) return;

            this.setRoom();
            if (this.action == "add") this.addRoom({ room: this.room, files: this.files });
            if (this.action == "upd") this.updateRoom({ room: this.room, files: this.files });
        },

        closeDialog() {
            EventBus.$emit("dialog");
        },

        validation() {
            if (this.action == "add" && this.$v.$invalid) {
                this.$v.$touch();
                return true;
            }
            return false;
        },

        onFileInit() {
            if (this.images) {
                this.images.forEach((image) => {
                    this.files.push(
                        {
                            source: '/' + image.name,
                            options: {
                                type: 'local',
                            },
                        }
                    );
                })
            } else this.files = [];
        },

        onFileChange(files) {
            var temp_files = [];
            files.forEach((file) => temp_files.push(file.file))
            this.files = temp_files;
        }
    },

    created() {
        this.show = this.dialog;
        this.prepareData();
        if (this.action != "add") this.setField();
    },
}
</script>

<style>
.scroll-area {
    width: inherit;
    max-height: 380px;
}
</style>
