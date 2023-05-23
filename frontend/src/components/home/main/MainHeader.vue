<template>
    <header>
        <div class="header-area">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid p-0">
                    <div class="row align-items-center no-gutters">
                        <div class="col-xl-5 col-lg-6">
                            <div class="main-menu d-none d-lg-block">
                                <nav>
                                    <ul id="navigation">
                                        <li><router-link to="/">Home</router-link></li>
                                        <li><router-link to="/">Rooms</router-link></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo-img">
                                <v-icon x-large color="green">mdi-vuejs</v-icon>
                            </div>
                        </div>
                        <div class="col-xl-5 col-lg-4 d-none d-lg-block">
                            <div class="book_room">
                                <div class="socail_links">
                                    <ul>
                                        <li>
                                            <a href="#">
                                                <router-link to="/"><i class="fa fa-facebook-square"></i></router-link>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <router-link to="/"><i class="fa fa-twitter"></i></router-link>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <router-link to="/"><i class="fa fa-instagram"></i></router-link>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <router-link to="/"><span class="text-white">Book a room</span></router-link>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="mobile_menu d-block d-lg-none"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
</template>
<script>
export default {
    name: "MainHeader"
}
</script>

<style lang="">
    
</style>