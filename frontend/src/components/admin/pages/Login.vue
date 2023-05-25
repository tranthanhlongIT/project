<template>
    <div class="ftco-section"
        style="height:100vh; background-image: url('/admin/img/login-image.png'); background-position: center; background-repeat: no-repeat; background-size: cover; ">
        <div class="container">
            <div class="row justify-content-center mt-5">
                <div class="col-md-6 text-center mb-5">
                    <h2 class="heading-section">
                        <v-icon x-large color="green" left>mdi-vuejs</v-icon>
                        Vue Hotel
                    </h2>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
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
export default {
    data() {
        return {
            email: null,
            password: null
        }
    },

    methods: {
        onLogin() {
            let user = {
                email: this.email,
                password: this.password,
            }
        }
    }
}
</script>

<style>
::-webkit-scrollbar {
    width: 0px;
}

@import "~/public/admin/css/style.css";
</style>