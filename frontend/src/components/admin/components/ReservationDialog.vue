<template>
    <v-row justify="center" class="m-0 p-0">
        <v-dialog v-model="show" persistent width="80vw">
            <v-card width="100vw" height="100%">
                <form>
                    <v-card-title class="m-0 p-0">
                        <slot name="header" class="text-subtitle-1">Default header</slot>
                        <v-spacer></v-spacer>
                        <v-btn icon @click.prevent="closeDialog" :ripple="false" plain>
                            <v-icon>mdi-close</v-icon>
                        </v-btn>
                    </v-card-title>
                    <v-divider color="grey" class="m-0 p-0"></v-divider>

                    <v-tabs v-model="tab" style="border-bottom: 1px solid #E0E0E0;">
                        <v-tab v-for="tab in tabs" :key="tab" :ripple="false">
                            {{ tab }}
                        </v-tab>
                    </v-tabs>

                    <v-tabs-items v-model="tab">
                        <v-tab-item>
                            <v-card-text class="m-0 p-0">
                                <v-container fluid style="min-width: inherit; max-width: inherit">
                                    <v-row>
                                        <v-col cols="12" lg="7" class="pt-0" style="border-right: 1px solid #E0E0E0;">
                                            <v-row no-gutters>
                                                <div class="text-h6 pl-0">Reservation info</div>
                                                <v-divider color="blue"></v-divider>
                                            </v-row>
                                            <v-row no-gutters>
                                                <v-col cols="12">
                                                    <v-row class="ml-1">
                                                        <v-col cols="12" class="pl-0 pt-0">
                                                            <table id="reservation-info">
                                                                <colgroup>
                                                                    <col style="width: 100px;">
                                                                    <col style="width: 150px;">
                                                                    <col style="width: 100px;">
                                                                    <col style="width: 150px;">
                                                                </colgroup>
                                                                <tr>
                                                                    <th>
                                                                        <div
                                                                            class="text-subtitle-2 font-weight-bold text-nowrap">
                                                                            Room status:
                                                                        </div>
                                                                    </th>
                                                                    <td colspan="3">
                                                                        <v-chip v-if="currentStatus == 'Available'"
                                                                            color="info" outlined
                                                                            class="mx-1 d-flex justify-content-center"
                                                                            style="width:100px" @click="onChangeChip">
                                                                            {{ currentStatus }}
                                                                        </v-chip>
                                                                        <v-chip v-else-if="currentStatus == 'Pending'"
                                                                            color="orange" outlined
                                                                            class="mx-1 d-flex justify-content-center"
                                                                            style="width:100px" @click="onChangeChip">
                                                                            {{ currentStatus }}
                                                                        </v-chip>
                                                                        <v-chip v-else-if="currentStatus == 'Reserved'"
                                                                            color="green" outlined
                                                                            class="mx-1 d-flex justify-content-center"
                                                                            style="width:100px" @click="onChangeChip">
                                                                            {{ currentStatus }}
                                                                        </v-chip>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>
                                                                        <div
                                                                            class="text-subtitle-2 font-weight-bold text-nowrap">
                                                                            Occupied date:
                                                                        </div>
                                                                    </th>
                                                                    <td colspan="3">
                                                                        <vc-date-picker v-model="range" mode="date"
                                                                            :model-config="{ type: 'string', mask: 'MM/DD/YYYY', }"
                                                                            :columns="$screens({ default: 1, xl: 2 })"
                                                                            is-range is-required :min-date="minDate"
                                                                            :disabled-dates="disabledDates">
                                                                            <template v-slot="{ togglePopover }">
                                                                                <div class="d-flex d-row pointer-area">
                                                                                    <v-text-field id="startDate"
                                                                                        :value="range.start"
                                                                                        @click="togglePopover" solo flat
                                                                                        single-line
                                                                                        prepend-inner-icon="mdi-calendar"
                                                                                        readonly hide-details
                                                                                        class="text-subtitle-2" />
                                                                                    <span class="mx-1 d-flex align-center">
                                                                                        <v-icon>mdi-arrow-right</v-icon>
                                                                                    </span>
                                                                                    <v-text-field :value="range.end"
                                                                                        prepend-inner-icon="mdi-calendar"
                                                                                        @click="onToggle" solo flat
                                                                                        single-line hide-details readonly
                                                                                        class="text-subtitle-2" />
                                                                                </div>
                                                                            </template>
                                                                        </vc-date-picker>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th scope="col">
                                                                        <div
                                                                            class="text-subtitle-2 font-weight-bold text-nowrap">
                                                                            Check in:
                                                                        </div>
                                                                    </th>
                                                                    <td>
                                                                        <template v-if="roomCheckIn(room)">
                                                                            <vc-date-picker v-model="checkIn" is-required
                                                                                mode="dateTime"
                                                                                :model-config="{ type: 'string', mask: 'MM/DD/YYYY HH:mm', }">
                                                                                <template v-slot="{ togglePopover }">
                                                                                    <v-text-field :value="checkIn"
                                                                                        @click="togglePopover" solo flat
                                                                                        prepend-inner-icon="mdi-calendar"
                                                                                        single-line readonly hide-details
                                                                                        class="text-subtitle-2"
                                                                                        style="width:190px" />
                                                                                </template>
                                                                            </vc-date-picker>
                                                                        </template>
                                                                        <template v-else>
                                                                            <v-menu bottom right offset-y dense
                                                                                transition="scale-transition"
                                                                                :nudge-bottom="5">
                                                                                <template v-slot:activator="{ on }">
                                                                                    <v-chip text-color="black" class="mx-1"
                                                                                        v-on="on">
                                                                                        Not checked-in
                                                                                    </v-chip>
                                                                                </template>
                                                                                <vc-date-picker v-model="checkIn"
                                                                                    mode="dateTime" is-required
                                                                                    :model-config="{ type: 'string', mask: 'MM/DD/YYYY HH:mm', }">
                                                                                </vc-date-picker>
                                                                            </v-menu>
                                                                        </template>
                                                                    </td>
                                                                    <th scope="col">
                                                                        <div
                                                                            class="text-subtitle-2 font-weight-bold text-nowrap">
                                                                            Check out:
                                                                        </div>
                                                                    </th>
                                                                    <td>
                                                                        <template v-if="roomCheckOut(room)">
                                                                            <vc-date-picker v-model="checkOut"
                                                                                mode="dateTime" is-required
                                                                                :model-config="{ type: 'string', mask: 'MM/DD/YYYY HH:mm', }">
                                                                                <template v-slot="{ togglePopover }">
                                                                                    <v-text-field :value="checkOut"
                                                                                        @click="togglePopover" solo flat
                                                                                        prepend-inner-icon="mdi-calendar"
                                                                                        single-line readonly hide-details
                                                                                        class="text-subtitle-2 p-0 m-0"
                                                                                        style="width:190px" />
                                                                                </template>
                                                                            </vc-date-picker>
                                                                        </template>
                                                                        <template v-else>
                                                                            <v-menu bottom right offset-y dense
                                                                                transition="scale-transition"
                                                                                :nudge-bottom="5">
                                                                                <template v-slot:activator="{ on }">
                                                                                    <v-chip text-color="black" class="mx-1"
                                                                                        v-on="on">
                                                                                        Not checked-out
                                                                                    </v-chip>
                                                                                </template>
                                                                                <vc-date-picker v-if="checkIn != null"
                                                                                    is-required v-model="checkOut"
                                                                                    mode="dateTime"
                                                                                    :model-config="{ type: 'string', mask: 'MM/DD/YYYY HH:mm', }">
                                                                                </vc-date-picker>
                                                                            </v-menu>
                                                                        </template>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </v-col>
                                                        <v-col cols="12" class="pl-0">
                                                            <v-row no-gutters>
                                                                <v-card elevation="0" outlined tile>
                                                                    <v-sheet class="pa-4"
                                                                        style="border-bottom: 1px solid #E0E0E0;">
                                                                        <v-row no-gutters>
                                                                            <v-col cols="6">
                                                                                <div
                                                                                    class="text-subtitle-1 font-weight-bold">
                                                                                    Guest
                                                                                </div>
                                                                            </v-col>
                                                                            <v-col cols="6">
                                                                                <v-text-field v-model="search"
                                                                                    append-icon="mdi-magnify" label="Search"
                                                                                    dense single-line hide-details>
                                                                                </v-text-field>
                                                                            </v-col>
                                                                        </v-row>
                                                                    </v-sheet>
                                                                    <v-data-table :headers="headers" :items="guests"
                                                                        :search="search" :footer-props="{ itemsPerPageOptions: [5], }
                                                                            " @click:row="onRowClick" single-select>
                                                                    </v-data-table>
                                                                </v-card>
                                                            </v-row>
                                                        </v-col>
                                                    </v-row>
                                                </v-col>
                                            </v-row>
                                        </v-col>
                                        <v-col cols="12" lg="5" class="pt-0">
                                            <v-row no-gutters>
                                                <div class="text-h6 pl-0">Room</div>
                                                <v-divider color="blue"></v-divider>
                                            </v-row>
                                            <v-row no-gutters>
                                                <v-col cols="12" class="mb-2">
                                                    <v-img :src="image" class="d-flex d-justify-content-center" height="300"
                                                        max-height="400"></v-img>
                                                </v-col>
                                                <v-col cols="12" md="3"
                                                    class="text-subtitle-1 font-weight-bold my-2">Number</v-col>
                                                <v-col cols="12" md="3"
                                                    class="text-subtitle-1 font-weight-bold my-2">Name</v-col>
                                                <v-col cols="12" md="3"
                                                    class="text-subtitle-1 font-weight-bold my-2">Type</v-col>
                                                <v-col cols="12" md="3"
                                                    class="text-subtitle-1 font-weight-bold my-2">Floor</v-col>
                                                <v-col cols="12" md="3" class="text-subtitle-1">{{ room.number }}</v-col>
                                                <v-col cols="12" md="3" class="text-subtitle-1">{{ room.name }}</v-col>
                                                <v-col cols="12" md="3" class="text-subtitle-1">{{ room.type.name }}</v-col>
                                                <v-col cols="12" md="3" class="text-subtitle-1">
                                                    {{ room.floor.name }}
                                                </v-col>
                                            </v-row>
                                            <v-row no-gutters class="mt-5">
                                                <div class="text-h6 pl-0">Checkout</div>
                                                <v-divider color="blue"></v-divider>
                                            </v-row>
                                            <v-row no-gutters>
                                                <v-col cols="12" md="6"
                                                    class="text-subtitle-1 font-weight-bold mb-2">Price</v-col>
                                                <v-col cols="12" md="6" class="text-subtitle-1 font-weight-bold mb-2">
                                                    {{ room.price | toCurrency }}</v-col>
                                                <v-col cols="12" md="6"
                                                    class="text-subtitle-1 font-weight-bold mb-2">Stay</v-col>
                                                <v-col cols="12" md="6" class="text-subtitle-1 font-weight-bold mb-2">
                                                    {{ totalStay }}
                                                    <template v-if="totalStay > 1">days</template>
                                                    <template v-else>day</template>
                                                </v-col>
                                                <v-col cols="12" md="6"
                                                    class="text-subtitle-1 font-weight-bold mb-2">TOTAL</v-col>
                                                <v-col cols="12" md="6" class="text-subtitle-1 font-weight-bold mb-2">
                                                    {{ totalPrice | toCurrency }}</v-col>
                                            </v-row>
                                        </v-col>
                                    </v-row>
                                </v-container>
                            </v-card-text>
                            <v-divider color="grey" class="m-0 p-0"></v-divider>
                            <v-card-actions class="pb-0">
                                <v-spacer></v-spacer>
                                <v-btn type="submit" class="mb-2" elevation="2" small color="primary" v-if="active == 1"
                                    @click.prevent="onHandle" :disabled="selectedGuest == null">
                                    Save
                                </v-btn>
                                <v-btn type="button" class="mr-5 mb-3" elevation="2" small color="warning"
                                    @click.prevent="closeDialog">
                                    Back
                                </v-btn>
                            </v-card-actions>
                        </v-tab-item>

                        <v-tab-item>
                            <v-card-text class="m-0 p-0">
                                <v-container fluid style="min-width: inherit; max-width: inherit">
                                    <v-row>
                                        <v-col cols="6">
                                            <v-img :src="image" height="622"></v-img>
                                        </v-col>
                                        <v-col cols="12" md="6">
                                            <v-row no-gutters>
                                                <div class="text-h6 pl-0 m-0">Guest info</div>
                                                <v-divider color="blue"></v-divider>
                                            </v-row>
                                            <v-row class="ml-1">
                                                <v-col cols="12" md="2" class="pl-0">
                                                    <v-text-field v-model="title" :disabled="active == 0 ? true : false"
                                                        label="Title" dense></v-text-field>
                                                </v-col>
                                                <v-col cols="12" md="5" class="pl-0">
                                                    <v-text-field v-model="fname" :error-messages="fnameErrors"
                                                        :disabled="active == 0 ? true : false" @blur="$v.fname.$touch()"
                                                        label="First name" dense></v-text-field>
                                                </v-col>
                                                <v-col cols="12" md="5" class="pl-0">
                                                    <v-text-field v-model="lname" :error-messages="lnameErrors"
                                                        :disabled="active == 0 ? true : false" @blur="$v.lname.$touch()"
                                                        label="Last name" dense></v-text-field>
                                                </v-col>
                                                <v-col cols="12" md="6" class="pl-0 pt-0">
                                                    <v-text-field v-model="email" :error-messages="emailErrors"
                                                        :disabled="active == 0 ? true : false" @blur="$v.email.$touch()"
                                                        label="Email" dense></v-text-field>
                                                </v-col>
                                                <v-col cols="12" md="6" class="pl-0 pt-0">
                                                    <v-text-field v-model="phone" :disabled="active == 0 ? true : false"
                                                        :error-messages="phoneErrors" @blur="$v.phone.$touch()"
                                                        label="Phone" dense></v-text-field>
                                                </v-col>
                                                <v-col cols="12" class="pl-0 pt-0">
                                                    <v-text-field v-model="address" :disabled="active == 0 ? true : false"
                                                        label="Address" dense hide-details></v-text-field>
                                                </v-col>
                                                <v-col cols="12" class="pl-0 mt-0 pt-0">
                                                    <v-textarea v-model="description" :disabled="active == 0 ? true : false"
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
                                <v-btn type="submit" class="mb-2" elevation="2" small color="primary" v-if="active == 1"
                                    @click.prevent="onHandleGuestForm">
                                    Save
                                </v-btn>
                                <v-btn type="button" class="mr-5 mb-3" elevation="2" small color="warning"
                                    @click.prevent="onChangeTab">
                                    Previous
                                </v-btn>
                            </v-card-actions>
                        </v-tab-item>

                    </v-tabs-items>
                </form>
            </v-card>
        </v-dialog>
    </v-row>
</template>

<script>
import { EventBus } from "@/main";
import { validationMixin } from "vuelidate";
import { required, maxLength, minLength, email } from "vuelidate/lib/validators";
import { mapActions, mapGetters } from "vuex";
import axios from "axios";
import moment from "moment";

export default {
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
            show: false,
            tab: null,
            tabs: ['Room reservation', 'Add guest'],
            reservation: {},
            room: {},
            guest: {},
            selectedGuest: null,
            currentStatus: null,
            title: null,
            fname: null,
            lname: null,
            phone: null,
            email: null,
            address: null,
            description: null,
            show: false,
            search: null,
            headers: [
                { text: "ID", value: "id", width: "8%" },
                { text: "Title", value: "title", width: "12%", sortable: false, filterable: false },
                { text: "Name", value: "name" },
                { text: "Phone", value: "phone", width: "30%", sortable: false, },
            ],

            datepickerForCheckIn: null,
            datepickerForCheckOut: null,
            checkIn: null,
            checkOut: null,
            minDate: new Date(),
            disabledDates: [],
            range: {
                start: moment(new Date()).format('MM/DD/YYYY'),
                end: moment(new Date()).format('MM/DD/YYYY'),
            },
            totalStay: 1,
        }
    },

    props: {
        dialog: Boolean,
        active: Number,
        status: String,
        image: String,
        selectedRoom: Object,
    },

    computed: {
        ...mapGetters({
            guests: "getGuests"
        }),

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

        totalPrice() {
            return this.room.price * this.totalStay;
        },

        width() {
            switch (this.$vuetify.breakpoint.name) {
                case 'lg': return "80%";
                case 'xl': return "60%";
                default: return "100%";
            }
        }
    },

    methods: {
        ...mapActions(["addReservation", "updateReservation", "getGuests", "addGuest"]),

        async prepareData(id) {
            let url = this.env.apiURL + "reservations/prepare-data-for-reservation/" + id;
            await axios.get(url).then((response) => {
                response.data.forEach(data => {
                    let date = new Date(data.occupied_date);
                    this.disabledDates.push(date);
                })
            });
        },

        onHandle() {
            this.setReservation();
            if (this.status == "Available") this.performAddReservation();
            if (this.status == "Pending" || this.status == "Reserved") this.updateReservation({ reservation: this.user });
        },

        performAddReservation() {
            this.addReservation({ reservation: this.reservation });
            this.currentStatus = this.reservation.status;
            this.prepareData(this.room.id);
        },

        onHandleGuestForm() {
            if (this.guestValidation()) return;
            this.setGuest();
            this.addGuest({ guest: this.guest })
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

        setReservation() {
            this.reservation.room_id = this.room.id;
            this.reservation.guest_id = this.selectedGuest.id;
            this.reservation.room_price = this.room.price;
            this.reservation.total_stay = this.totalStay;
            this.reservation.total_price = this.totalPrice;
            this.reservation.check_in = this.checkIn != null ? new Date(this.checkIn).toLocaleDateString() : null;
            this.reservation.check_out = this.checkOut != null ? new Date(this.checkOut).toLocaleDateString() : null;
            this.reservation.start_date = new Date(this.range.start).toLocaleDateString();
            this.reservation.end_date = new Date(this.range.end).toLocaleDateString();
            this.reservation.status = this.currentStatus == "Available" ? "Pending" : this.currentStatus;
            this.reservation.active = (this.checkOut == null && this.status != "Canceled") ? 1 : 0;
        },

        setField() {
            this.checkIn = moment(new Date(this.selectedRoom.reservations[0].check_in)).format("MM/DD/YYYY HH:mm");
            this.checkOut = moment(new Date(this.selectedRoom.reservations[0].check_out)).format("MM/DD/YYYY HH:mm")
            this.range.start = moment(new Date(this.selectedRoom.reservations[0].start_date)).format("MM/DD/YYYY")
            this.range.end = moment(new Date(this.selectedRoom.reservations[0].end_date)).format("MM/DD/YYYY")
            this.totalStay = this.selectedRoom.reservations[0].total_stay;
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

        guestValidation() {
            if (this.$v.$invalid) {
                this.$v.$touch();
                return true;
            }
            return false;
        },

        roomCheckIn(room) {
            if (room.reservations.length > 0 && room.reservations[0].check_in != null || this.checkIn != null)
                return true;
            return false;
        },

        roomCheckOut(room) {
            if (room.reservations.length > 0 && room.reservations[0].check_out != null || this.checkOut != null)
                return true;
            return false;
        },

        onChangeTab() {
            this.tab = 0;
        },

        onRowClick(item, row) {
            row.select(true)
            this.selectedGuest = item;
        },

        onChangeChip() {
            if (this.currentStatus == "Available") {
                this.currentStatus = "Pending";
                return;
            } else if (this.currentStatus == "Pending") {
                this.currentStatus = "Reserved";
                return;
            } else if (this.currentStatus == "Reserved") {
                this.currentStatus = "Available";
                return;
            }
        },

        onToggle() {
            document.getElementById('startDate').click()
        },

        formatDate(date) {
            if (!date) return null

            const [year, month, day] = date.split('-')
            return `${month}/${day}/${year}`
        },

        closeDialog() {
            EventBus.$emit("dialog");
        },
    },

    created() {
        this.show = this.dialog;
        this.room = this.selectedRoom;
        this.currentStatus = this.status;

        this.prepareData(this.room.id);

        if (this.currentStatus != "Available") this.setField();

        EventBus.$on("reset", () =>
            this.resetField()
        );
    },

    watch: {
        range: {
            handler(value) {
                if (value.end != null) {
                    let start = new Date(value.start);
                    let end = new Date(value.end);
                    let differenceInTime = end.getTime() - start.getTime();
                    this.totalStay = (differenceInTime / (1000 * 3600 * 24)) + 1;
                }
            },
            deep: true,
        },
    }
}
</script>

<style scoped>
* {
    user-select: none;
}

#reservation-info {
    font-family: Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
    table-layout: fixed;
}

#reservation-info td,
#reservation-info th {
    border: 1px solid #ddd;
}

#reservation-info th {
    padding: 5px;
    width: 150px;
    height: 50px;
}

#reservation-info th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #EEEEEE;
}

/deep/ tr.v-data-table__selected {
    background: #c0bcf4 !important;
}
</style>