<template>
    <v-row justify="center" class="m-0 p-0">
        <v-dialog v-model="show" persistent :max-width="400">
            <v-card>
                <form>
                    <v-card-title class="p-0">
                        <div class="ma-1 ml-2 text-subtitle-1 indigo--text">
                            <v-icon dense color="indigo" class="mr-1 mb-1">mdi-information</v-icon>Checkout
                        </div>
                    </v-card-title>
                    <v-divider class="m-0 p-0"></v-divider>
                    <v-card-text style="border-bottom: 1px solid #E0E0E0;">
                        <v-container fluid>
                            <v-row>
                                <v-col cols="12">
                                    <div class="text-center text-subtitle-1">Are you sure want to checkout
                                    </div>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>
                    <v-divider class="m-0 p-0"></v-divider>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn type="submit" class="my-1 mr-1" elevation="2" small color="primary"
                            @click.prevent="onHandle">
                            Confirm
                        </v-btn>
                        <v-btn type="button" class="my-1 mr-2" elevation="2" small color="warning"
                            @click.prevent="closeCheckOut">
                            Back
                        </v-btn>
                    </v-card-actions>
                </form>
            </v-card>
        </v-dialog>
    </v-row>
</template>

<script>
import { EventBus } from '@/main';
import { mapActions } from 'vuex';
import moment from 'moment';

export default {
    name: "checkout-dialog",

    props: {
        object: Object,
        checkIn: String,
        checkOutConfirmation: Boolean,
    },

    data() {
        return {
            show: false,
            currentCheckOut: null,
        }
    },

    methods: {
        ...mapActions(["checkOutReservation"]),

        onHandle() {
            if (!this.validateForm()) return;

            this.currentCheckOut = moment(this.currentCheckOut).format("YYYY-MM-DD HH:mm")
            this.checkOutReservation({ id: this.object.id, checkOut: this.currentCheckOut })
        },

        closeCheckOut() {
            EventBus.$emit("closeCheckOut");
        },

        validateForm() {
            if (this.currentCheckIn == null) {
                this.$toast.error("Not checked-in yet");
                return false
            }

            if (this.currentCheckOut.getTime() > this.currentCheckIn.getTime()) {
                this.$toast.error("Check-in date is higher than check-out date");
                return false
            }

            return true;
        }
    },

    created() {
        this.show = this.checkOutConfirmation;
        this.currentCheckIn = this.checkIn ? new Date(this.CheckIn) : null;
        this.currentCheckOut = this.object.check_out ? new Date(this.object.check_out) : new Date();
    }
};
</script>