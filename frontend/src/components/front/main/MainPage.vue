<template>
    <div>
        <MainHeader />
        <MainSlider />
        <SpecialtyArea />
        <OfferArea />
        <VideoArea />
        <AboutArea />
        <FeatureArea />
        <InstagramArea />
        <MainFooter />
    </div>
</template>

<script>
import MainHeader from './MainHeader.vue'
import MainSlider from './MainSlider.vue';
import SpecialtyArea from './SpecialtyArea.vue'
import OfferArea from './OfferArea.vue';
import AboutArea from './AboutArea.vue';
import VideoArea from './VideoArea.vue';
import FeatureArea from './FeatureArea.vue';
import InstagramArea from './InstagramArea.vue';
import MainFooter from './MainFooter.vue';

export default {
    name: "MainPage",

    components: {
        MainHeader,
        MainSlider,
        SpecialtyArea,
        OfferArea,
        AboutArea,
        VideoArea,
        FeatureArea,
        InstagramArea,
        MainFooter
    }
}
</script>
