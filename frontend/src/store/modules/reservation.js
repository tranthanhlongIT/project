import axios from "axios";
import Auth from "@/plugins/auth";
import { EventBus } from "@/main";

export const reservationStore = {
    state: {
        reservations: [],
        reservation: {},
    },

    getters: {
        getReservations: (state) => state.reservations,
        getReservation: (state) => state.reservation,
    },

    mutations: {
        setReservations: (state, reservations) => (state.reservations = reservations),
        setReservation: (state, reservation) => (state.reservation = reservation),
        addReservation: (state, reservation) => { },
        updateReservation: (state, reservation) => { },
        disableReservation: (state, reservation) => { },
        checkOutReservation: (state, reservation) => { }
    },

    actions: {
        async getReservations({ commit }) {
            try {
                const url = this._vm.env.apiURL + "reservations";

                await axios.get(url).then((response) => {
                    commit("setReservations", response.data.data);
                });

            } catch (error) {

                if (error.response.status == 401) {
                    Auth.logout();
                    router.go("/admin/login");
                }

                this._vm.$toast.error(error.response.data.message);
            }
        },

        async addReservation({ commit }, { reservation }) {
            const formData = addFormData(reservation);
            const url = this._vm.env.apiURL + "reservations";

            try {
                const response = await axios.post(url, formData);

                commit("addReservation");
                EventBus.$emit("updateList");
                EventBus.$emit("addId", response.data.id);
                EventBus.$emit("changeStatus", reservation.status);
                this._vm.$toast.success("Book successful");

            } catch (error) {
                this._vm.$toast.error(error.response.data.message);
            }
        },

        async updateReservation({ commit }, { reservation }) {
            const formData = updateFormData(reservation);
            const url = this._vm.env.apiURL + "reservations/" + reservation.id;

            try {
                await axios.post(url, formData);

                commit("updateReservation", reservation);

                if (reservation.check_out != null) {
                    EventBus.$emit("updateList");
                    EventBus.$emit("closeDialog");
                    this._vm.$toast.success("Check-out successful");

                } else this._vm.$toast.success("Update successful");

            } catch (error) {
                this._vm.$toast.error(error.response.data.message);
            }
        },

        async disableReservation({ commit }, { object }) {
            const url = this._vm.env.apiURL + "reservations/disable/" + object.id;

            try {
                await axios.patch(url);

                commit("disableReservation");
                EventBus.$emit("updateList");
                EventBus.$emit("closeConfirmation");
                EventBus.$emit("closeDialog");
                this._vm.$toast.success("Cancel successful");

            } catch (e) {
                this._vm.$toast.error("Cancel failed");
            }
        },
    },
};


function addFormData(reservation) {
    const formData = new FormData();
    formData.append("room_id", reservation.room_id)
    formData.append("guest_id", reservation.guest_id);
    formData.append("room_price", reservation.room_price);
    formData.append("total_stay", reservation.total_stay);
    formData.append("total_price", reservation.total_price);
    formData.append("check_in", reservation.check_in ?? "");
    formData.append("start_date", reservation.start_date);
    formData.append("end_date", reservation.end_date);
    formData.append("status", reservation.status);
    formData.append("active", reservation.active);

    return formData;
}

function updateFormData(reservation) {
    const formData = new FormData();
    formData.append("room_id", reservation.room_id);
    formData.append("total_stay", reservation.total_stay);
    formData.append("total_price", reservation.total_price);
    formData.append("check_in", reservation.check_in ?? "");
    formData.append("check_out", reservation.check_out ?? "");
    formData.append("start_date", reservation.start_date);
    formData.append("end_date", reservation.end_date);
    formData.append("status", reservation.status);
    formData.append("active", reservation.active);
    formData.append("_method", "PATCH");

    return formData;
}