<template>
  <router-view />
</template>

<script>
export default {
  name: "HomeIndex",
};
</script>

<style>
/* width */
::-webkit-scrollbar {
  width: 0px;
}

@media (min-width: 1140px) {
  .container {
    max-width: 1140px !important;
  }
}

@import "~/public/home/css/bootstrap.min.css";
@import "~/public/home/css/owl.carousel.min.css";
@import "~/public/home/css/magnific-popup.css";
@import "~/public/home/css/font-awesome.min.css";
@import "~/public/home/css/themify-icons.css";
@import "~/public/home/css/nice-select.css";
@import "~/public/home/css/flaticon.css";
@import "~/public/home/css/gijgo.css";
@import "~/public/home/css/animate.css";
@import "~/public/home/css/slicknav.css";
@import "~/public/home/css/style.css";
</style>
