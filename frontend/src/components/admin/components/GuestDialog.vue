<template>
    <v-row justify="center" class="m-0 p-0">
        <v-dialog v-model="show" persistent :width="width">
            <v-card width="100vw">
                <form>
                    <v-card-title class="m-0 p-0">
                        <slot name="header" class="text-subtitle-1">Default header</slot>
                        <v-spacer></v-spacer>
                        <v-btn icon @click.prevent="closeDialog" :ripple="false" plain>
                            <v-icon>mdi-close</v-icon>
                        </v-btn>
                    </v-card-title>
                    <v-divider color="grey" class="m-0 p-0"></v-divider>
                    <v-card-text class="m-0 p-0">
                        <v-container fluid>
                            <v-row no-gutters>
                                <v-col cols="12">
                                    <v-row class="ml-1">
                                        <v-col cols="12" md="2" class="pl-0">
                                            <v-text-field v-model="title" :disabled="action == 'det' ? true : false"
                                                label="Title" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" md="5" class="pl-0">
                                            <v-text-field v-model="fname" :error-messages="fnameErrors"
                                                :disabled="action == 'det' ? true : false" @blur="$v.fname.$touch()"
                                                label="First name" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" md="5" class="pl-0">
                                            <v-text-field v-model="lname" :error-messages="lnameErrors"
                                                :disabled="action == 'det' ? true : false" @blur="$v.lname.$touch()"
                                                label="Last name" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" md="6" class="pl-0 pt-0">
                                            <v-text-field v-model="email" :error-messages="emailErrors"
                                                :disabled="action == 'det' ? true : false" @blur="$v.email.$touch()"
                                                label="Email" dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" md="6" class="pl-0 pt-0">
                                            <v-text-field v-model="phone" :disabled="action == 'det' ? true : false"
                                                :error-messages="phoneErrors" @blur="$v.phone.$touch()" label="Phone"
                                                dense></v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pl-0 pt-0">
                                            <v-text-field v-model="address" :disabled="action == 'det' ? true : false"
                                                label="Address" dense hide-details></v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pl-0 mt-0 pt-0">
                                            <v-textarea v-model="description" :disabled="action == 'det' ? true : false"
                                                label="Description (optional)" hide-details></v-textarea>
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
                            v-if="action == 'add' || action == 'upd'" @click.prevent="onHandle">
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
import { validationMixin } from "vuelidate";
import { required, maxLength, minLength, email } from "vuelidate/lib/validators";
import { mapActions } from "vuex";
import { EventBus } from "@/main";

export default {
    name: "guest-dialog",

    mixins: [validationMixin],

    validations: {
        fname: { required, maxLength: maxLength(30) },
        lname: { required, maxLength: maxLength(30) },
        email: { email },
        phone: {
            required,
            minLength: minLength(10),
            maxLength: maxLength(10),
            valid: function (value) {
                const allNumber = /^\d+$/.test(value);
                return allNumber;
            },
        },
    },

    data() {
        return {
            guest: {},
            title: null,
            fname: null,
            lname: null,
            phone: null,
            email: null,
            address: null,
            description: null,
            show: false,
        };
    },

    props: {
        dialog: Boolean,
        action: String,
        selectedGuest: Object,
    },

    computed: {
        fnameErrors() {
            const errors = [];
            if (!this.$v.fname.$dirty) return errors;
            !this.$v.fname.maxLength &&
                errors.push("Fist name must be at most 30 characters long");
            !this.$v.fname.required && errors.push("Fist name is required.");
            return errors;
        },

        lnameErrors() {
            const errors = [];
            if (!this.$v.lname.$dirty) return errors;
            !this.$v.lname.maxLength &&
                errors.push("Last name must be at most 30 characters long");
            !this.$v.lname.required && errors.push("Last name is required.");
            return errors;
        },

        emailErrors() {
            const errors = [];
            if (!this.$v.email.$dirty) return errors;
            !this.$v.email.email && errors.push("Invalid email");
            return errors;
        },

        phoneErrors() {
            const errors = [];
            if (!this.$v.phone.$dirty) return errors;
            !this.$v.phone.valid && errors.push("Phone must be digit only");
            !this.$v.phone.maxLength && errors.push("Phone must be 10 digits");
            !this.$v.phone.minLength && errors.push("Phone must be 10 digits");
            !this.$v.phone.required && errors.push("Phone is required.");
            return errors;
        },

        width() {
            switch (this.$vuetify.breakpoint.name) {
                case 'md': return "70%";
                case 'lg': return "50%";
                case 'xl': return "40%";
                default: return "100%";
            }
        }
    },

    methods: {
        ...mapActions(["getGuests", "addGuest", "updateGuest", "disableGuest"]),

        onHandle() {
            if (this.validation()) return;
            this.setGuest();
            if (this.action == "add") this.addGuest({ guest: this.guest });
            if (this.action == "upd") this.updateGuest({ guest: this.guest });
        },

        setGuest() {
            this.guest.title = this.title;
            this.guest.name = this.fname + " " + this.lname;
            this.guest.fname = this.fname;
            this.guest.lname = this.lname;
            this.guest.phone = this.phone;
            this.guest.email = this.email;
            this.guest.address = this.address;
            this.guest.description = this.description;
        },

        setField() {
            const { title, fname, lname, phone, email, address, description } = this.selectedGuest;
            this.guest = Object.assign({}, this.selectedGuest);
            this.title = title;
            this.fname = fname;
            this.lname = lname;
            this.phone = phone;
            this.email = email;
            this.address = address;
            this.description = description;
        },

        resetField() {
            this.guest = null;
            this.title = null;
            this.fname = null;
            this.lname = null;
            this.phone = null;
            this.email = null;
            this.address = null;
            this.description = null;
            this.$v.$reset();
        },

        validation() {
            if (this.action == "add" && this.$v.$invalid) {
                this.$v.$touch();
                return true;
            }
        },

        closeDialog() {
            EventBus.$emit("dialog");
        },
    },

    created() {
        this.show = this.dialog;

        if (this.action != "add") this.setField();

        EventBus.$on("reset", () =>
            this.resetField()
        );
    },
};
</script>
