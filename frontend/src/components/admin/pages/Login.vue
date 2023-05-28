<template>
    <div class="ftco-section"
        style="height:100vh; background-image: url('/admin/img/login-image.png'); background-position: center; background-repeat: no-repeat; background-size: cover; ">
        <div class="container">
            <div class="row justify-content-center mt-5">
                <div class="col-md-6 text-center mb-3">
                    <h2 class="heading-section">
                        <v-icon x-large color="green" left>mdi-vuejs</v-icon>
                        Vue Hotel
                    </h2>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <div class="login-wrap p-0">
                        <form @submit.prevent="onLogin" class="signin-form">
                            <div class="form-group">
                                <input type="text" v-model="email" class="form-control" placeholder="Email" required>
                            </div>
                            <div class="form-group">
                                <input id="password-field" v-model="password" type="password" class="form-control"
                                    placeholder="Password" required>
                            </div>
                            <div class="form-group">
                                <v-btn type="submit" large class="form-control btn btn-primary submit px-3">Login</v-btn>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import Auth from "@/plugins/auth";
import router from "@/router";

export default {
    data() {
        return {
            email: "long@gmail.com",
            password: "password"
        }
    },

    methods: {
        async onLogin() {
            try {
                const formData = new FormData();
                formData.append("email", this.email);
                formData.append("password", this.password);

                const url = this.env.apiURL + "admin/login";

                const response = await axios.post(url, formData);

                if (response.data.status) {
                    Auth.login(response.data.token, response.data.current_user);
                    router.push("/admin/dashboard");
                    this.$toast.success("Login successful");
                } else this.$toast.error(response.data.message);

            } catch (e) {
                this.$toast.error("Login failed");
            };
        },
    }
}
</script>

<style scoped>
::-webkit-scrollbar {
    width: 0px;
}

@import "~/public/admin/css/style.css";
</style>