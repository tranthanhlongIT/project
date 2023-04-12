<template>
  <div>
    <v-btn x-small plain rounded elevation="0" :disabled="disabled" :ripple="false" color="primary"
      @click.prevent="onButtonClick">Upload image
      <v-icon>mdi-upload</v-icon></v-btn>
    <input ref="uploader" class="d-none" type="file" accept="image/*" @change="onFileChange" />
  </div>
</template>

<script>
import { EventBus } from "@/main";

export default {
  name: "upload-button",

  props: {
    disabled: Boolean
  },

  methods: {
    onButtonClick() {
      this.isSelecting = true;
      window.addEventListener(
        "focus",
        () => {
          this.isSelecting = false;
        },
        { once: true }
      );

      this.$refs.uploader.click();
    },

    onFileChange(e) {
      this.selectedFile = e.target.files[0];
      EventBus.$emit("file", this.selectedFile);
    },
  },
};
</script>
