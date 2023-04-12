<template>
  <v-row justify="center" class="m-0 p-0">
    <v-dialog v-model="show" persistent :max-width="400">
      <v-card>
        <form>
          <v-card-title class="p-0">
            <slot name="header" class="text-h5">Default header</slot>
          </v-card-title>
          <v-divider class="m-0 p-0"></v-divider>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="12">
                  <slot name="message" class="text-center text-subtitle-1">Message</slot>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-divider class="m-0 p-0"></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn type="submit" class="my-2 mr-1" elevation="2" small v-blur color="error" @click.prevent="onHandle">
              Confirm
            </v-btn>
            <v-btn type="button" class="my-2 mr-2" elevation="2" small v-blur color="warning"
              @click.prevent="closeConfirmation">
              Back
            </v-btn>
          </v-card-actions>
        </form>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { EventBus } from '@/main';
import { mapActions } from 'vuex';

export default {
  name: "confirmation-dialog",

  props: {
    object: Object,
    confirmation: Boolean,
    type: String
  },

  data() {
    return {
      show: false,
    }
  },

  methods: {
    ...mapActions(["disableUser"]),

    onHandle() {
      if (this.type == 'dis') {
        this.object.active = false;
        this.disableUser({ user: this.object });
      }
    },

    closeConfirmation() {
      EventBus.$emit("confirmation");
    }
  },

  created() {
    this.show = this.confirmation;
  }
};
</script>