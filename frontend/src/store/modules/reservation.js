import { EventBus } from "@/main";
import axios from "axios";

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
        deleteReservation: (state, id) => { }
    },

    actions: {
        async getReservations({ commit }) {
            const url = this._vm.env.apiURL + "reservations";
            await axios.get(url).then((response) => {
                commit("setReservations", response.data);
            });
        },

        async addReservation({ commit }, { reservation }) {
            const formData = addFormData(reservation);
            const url = this._vm.env.apiURL + "reservations";

            try {
                await axios.post(url, formData);
                commit("addReservation");
                EventBus.$emit("updateList");
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
                this._vm.$toast.success("Update successful");
            } catch (error) {
                this._vm.$toast.error(error.response.data.message);
            }
        },

        async deleteReservation({ commit }, { id }) {
            const url = this._vm.env.apiURL + "reservations/" + id;
            try {
                await axios.delete(url);
                EventBus.$emit("confirmation");
                commit("deleteReservation", id);
                this._vm.$toast.success("Delete successful");
            } catch (e) {
                this._vm.$toast.error("Delete failed");
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
    formData.append("title", reservation.title);
    formData.append("fname", reservation.fname);
    formData.append("lname", reservation.lname);
    formData.append("phone", reservation.phone);
    formData.append("email", reservation.email ?? "");
    formData.append("address", reservation.address ?? "");
    formData.append("description", reservation.description ?? "")
    formData.append("_method", "PATCH");
    return formData;
}