import axios from "axios";
import Auth from "@/plugins/auth";
import { EventBus } from "@/main";

export const guestStore = {
    state: {
        guests: [],
        guest: {},
    },

    getters: {
        getGuests: (state) => state.guests,
        getGuest: (state) => state.guest,
    },

    mutations: {
        setGuests: (state, guests) => (state.guests = guests),
        setGuest: (state, guest) => (state.guest = guest),
        addGuest: (state, guest) => state.guests.push(guest),
        updateGuest: (state, guest) => {
            const index = state.guests.findIndex((guests) => guests.id == guest.id);
            state.guests.splice(index, 1, guest);
        },
        deleteGuest: (state, id) => {
            const index = state.guests.findIndex((guests) => guests.id == id);
            state.guests.splice(index, 1);
        }
    },

    actions: {
        async getGuests({ commit }) {
            try {
                const url = this._vm.env.apiURL + "guests";

                await axios.get(url).then((response) => {
                    commit("setGuests", response.data.data);
                });

            } catch (error) {

                if (error.response.status == 401) {
                    Auth.logout();
                    router.push("/admin/login");
                }

                this._vm.$toast.error(error.response.data.message);
            }
        },

        async setGuests({ commit }, { guest }) {
            let guests = [];

            guest.name = guest.fname + " " + guest.lname;

            guests.push(guest);
            commit("setGuests", guests);
        },

        async addGuest({ commit }, { guest }) {
            const formData = addFormData(guest);
            const url = this._vm.env.apiURL + "guests";

            try {
                const response = await axios.post(url, formData);

                guest.id = response.data.id;

                commit("addGuest", guest);
                EventBus.$emit("resetField");
                this._vm.$toast.success("Add successful");

            } catch (error) {
                this._vm.$toast.error(error.response.data.message);
            }
        },

        async updateGuest({ commit }, { guest }) {
            const formData = updateFormData(guest);
            const url = this._vm.env.apiURL + "guests/" + guest.id;

            try {
                await axios.post(url, formData);

                commit("updateGuest", guest);
                this._vm.$toast.success("Update successful");

            } catch (error) {
                this._vm.$toast.error(error.response.data.message);
            }
        },

        async deleteGuest({ commit }, { id }) {
            const url = this._vm.env.apiURL + "guests/" + id;

            try {
                await axios.delete(url);

                EventBus.$emit("confirmation");
                commit("deleteGuest", id);
                this._vm.$toast.success("Delete successful");

            } catch (e) {
                this._vm.$toast.error("Delete failed");
            }
        },
    },
};


function addFormData(guest) {
    const formData = new FormData();
    formData.append("title", guest.title);
    formData.append("fname", guest.fname);
    formData.append("lname", guest.lname);
    formData.append("phone", guest.phone);
    formData.append("email", guest.email ?? "");
    formData.append("address", guest.address ?? "");
    formData.append("description", guest.description ?? "")

    return formData;
}

function updateFormData(guest) {
    const formData = new FormData();
    formData.append("title", guest.title);
    formData.append("fname", guest.fname);
    formData.append("lname", guest.lname);
    formData.append("phone", guest.phone);
    formData.append("email", guest.email ?? "");
    formData.append("address", guest.address ?? "");
    formData.append("description", guest.description ?? "")
    formData.append("_method", "PATCH");

    return formData;
}