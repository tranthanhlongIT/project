<template>
  <vueper-slides fade fixed-height="100vh" :touchable="false" :bullets="false" autoplay>
    <vueper-slide v-for="(slide, i) in slides" :key="i" :image="slide.image">
      <template #content>
        <div class="vueperslide__content-wrapper">
          <div class="vueperslide__title">
            <div class="slider_text text-center">
              <h3 class="main-slider-title">Vue Hotel</h3>
              <div class="vueperslide__content">
                <p class="main-slider-content">Unlock to enjoy the view of Martine</p>
              </div>
            </div>
          </div>
        </div>
      </template>
    </vueper-slide>
  </vueper-slides>
</template>

<script>
import 'vueperslides/dist/vueperslides.css'
import { VueperSlides, VueperSlide } from 'vueperslides'

export default {
  name: "MainSlider",

  components: { VueperSlides, VueperSlide },
  data() {
    return {
      slides: [
        {
          title: 'Vue Hotel',
          content: 'Unlock to enjoy the view of Martine',
          image: "http://localhost:8080/home/img/banner/banner1.png",
        },
        {
          title: 'Life is Beautiful',
          content: 'Bring you to a promise stay',
          image: "http://localhost:8080/home/img/banner/banner2.png",
        },
      ]
    }
  },
};
</script>

<style>
.main-slider-title {
  color: #ffffff;
  font-family: 'Raleway', sans-serif;
  font-size: 100px;
  text-transform: capitalize;
  letter-spacing: 2px;
  font-weight: 400;
  margin-bottom: 4px;
}

.main-slider-content {
  font-size: 24px;
  font-weight: 400;
  color: #ffffff;
  margin-bottom: 0;
  margin-top: 0;
}
</style>