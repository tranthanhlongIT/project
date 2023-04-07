<template>
  <router-view />
</template>

<script>
export default {
  name: "HomeIndex",

  metaInfo: {
    script: [
      { src: "https://cdn.jsdelivr.net/vue.js", async: true, defer: true },
      {
        src: "/home/js/vendor/modernizr-3.5.0.min.js",
        async: true,
        defer: true,
      },
      {
        src: "/home/js/vendor/jquery-1.12.4.min.js",
        async: true,
        defer: true,
      },
      { src: "/home/js/popper.min.js", async: true, defer: true },
      { src: "/home/js/bootstrap.min.js", async: true, defer: true },
      { src: "/home/js/owl.carousel.min.js", async: true, defer: true },
      { src: "/home/js/isotope.pkgd.min.js", async: true, defer: true },
      { src: "/home/js/ajax-form.js", async: true, defer: true },
      { src: "/home/js/waypoints.min.js", async: true, defer: true },
      {
        src: "/home/js/jquery.counterup.min.js",
        async: true,
        defer: true,
      },
      {
        src: "/home/js/imagesloaded.pkgd.min.js",
        async: true,
        defer: true,
      },
      { src: "/home/js/scrollIt.js", async: true, defer: true },
      {
        src: "/home/js/jquery.scrollUp.min.js",
        async: true,
        defer: true,
      },
      { src: "/home/js/wow.min.js", async: true, defer: true },
      { src: "/home/js/nice-select.min.js", async: true, defer: true },
      {
        src: "/home/js/jquery.slicknav.min.js",
        async: true,
        defer: true,
      },
      {
        src: "/home/js/jquery.magnific-popup.min.js",
        async: true,
        defer: true,
      },
      { src: "/home/js/plugins.js", async: true, defer: true },
      { src: "/home/js/gijgo.min.js", async: true, defer: true },

      { src: "/home/js/contact.js", async: true, defer: true },
      {
        src: "/home/js/jquery.ajaxchimp.min.js",
        async: true,
        defer: true,
      },
      { src: "/home/js/jquery.form.js", async: true, defer: true },
      {
        src: "/home/js/jquery.validate.min.js",
        async: true,
        defer: true,
      },
      { src: "/home/js/mail-script.js", async: true, defer: true },

      { src: "/home/js/main.js", async: true, defer: true },
    ],
  },
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

@import "@/../public/home/css/bootstrap.min.css";
@import "@/../public/home/css/owl.carousel.min.css";
@import "@/../public/home/css/magnific-popup.css";
@import "@/../public/home/css/font-awesome.min.css";
@import "@/../public/home/css/themify-icons.css";
@import "@/../public/home/css/nice-select.css";
@import "@/../public/home/css/flaticon.css";
@import "@/../public/home/css/gijgo.css";
@import "@/../public/home/css/animate.css";
@import "@/../public/home/css/slicknav.css";
@import "@/../public/home/css/style.css";
</style>
