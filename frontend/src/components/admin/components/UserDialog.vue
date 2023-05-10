<template>
  <v-row justify="center" class="m-0 p-0">
    <v-dialog v-model="show" persistent :width="width">
      <v-card width="100vw">
        <form>
          <v-card-title class="m-0 p-0">
            <slot name="header" class="text-subtitle-1">Default header</slot>
            <v-spacer></v-spacer>
            <v-btn icon @click.prevent="closeDialog" :ripple="false" plain>
              <v-icon>mdi-close</v-icon>
            </v-btn>
          </v-card-title>
          <v-divider color="grey" class="m-0 p-0"></v-divider>
          <v-card-text class="m-0 p-0">
            <v-container fluid>
              <v-row no-gutters>
                <div class="text-subtitle-2 pl-0">Account Info</div>
                <v-divider color="blue"></v-divider>
              </v-row>
              <v-row no-gutters>
                <v-col cols="12" md="4" xxl="3">
                  <v-col cols="12" class="py-0">
                    <v-img v-if="file != null" :src="fileURL" class="d-flex d-justify-content-center" height="145"
                      contain></v-img>
                    <v-img v-else :src="image != null ? (env.imageURL + user.image) : '/admin/img/user-default.jpg'"
                      class="d-flex d-justify-content-center" height="145" contain></v-img>
                  </v-col>
                  <v-col cols="12" class="d-flex justify-content-center">
                    <upload-button :disabled="action == 'det' ? true : false" />
                  </v-col>
                </v-col>
                <v-col cols="12" md="8" xxl="9">
                  <v-row class="ml-1">
                    <v-col cols="12" md="6" class="pl-0 pt-0">
                      <v-select v-model="role" item-text="name" item-value="id" :items="roles" return-object
                        :menu-props="{ bottom: true, offsetY: true }" :disabled="action == 'det' ? true : false"
                        :error-messages="roleErrors" @blur="$v.role.$touch()" label="Role" dense></v-select>
                    </v-col>
                    <v-col cols="12" md="6" class="pl-0 pt-0">
                      <v-select v-model="active" item-text="name" item-value="value" :items="actives"
                        :menu-props="{ bottom: true, offsetY: true }" :disabled="action == 'det' ? true : false"
                        label="Active" dense></v-select>
                    </v-col>
                    <v-col cols="12" class="pl-0 pt-0">
                      <v-text-field v-model="email" :error-messages="emailErrors"
                        :disabled="(action == 'upd' || action == 'det') ? true : false" @blur="$v.email.$touch()"
                        label="Email" dense></v-text-field>
                    </v-col>
                    <v-col cols="12" class="pl-0 pt-0">
                      <v-text-field v-model="password" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                        :type="showPassword ? 'text' : 'password'"
                        hint="At least 8 characters, contains 1 numeric, 1 uppercase, 1 lowercase, 1 special character"
                        :error-messages="passwordErrors" :disabled="(action == 'upd' || action == 'det') ? true : false"
                        @click:append="showPassword = !showPassword" label="Password" dense></v-text-field>
                    </v-col>
                  </v-row>
                </v-col>
              </v-row>
              <v-row no-gutters>
                <div class="text-subtitle-2 pl-0">User Info</div>
                <v-divider color="blue"></v-divider>
              </v-row>
              <v-row no-gutters>
                <v-col cols="12">
                  <v-row class="ml-1">
                    <v-col cols="12" md="6" class="pl-0">
                      <v-text-field v-model="fname" :error-messages="fnameErrors"
                        :disabled="action == 'det' ? true : false" @blur="$v.fname.$touch()" label="First name"
                        dense></v-text-field>
                    </v-col>
                    <v-col cols="12" md="6" class="pl-0">
                      <v-text-field v-model="lname" :error-messages="lnameErrors"
                        :disabled="action == 'det' ? true : false" @blur="$v.lname.$touch()" label="Last name"
                        dense></v-text-field>
                    </v-col>
                    <v-col cols="12" class="pl-0 pt-0">
                      <v-text-field v-model="address" :disabled="action == 'det' ? true : false" label="Address"
                        dense></v-text-field>
                    </v-col>
                    <v-col cols="12" md="6" class="pl-0 pt-0">
                      <v-select v-model="gender" item-text="name" item-value="value" :items="genders"
                        :menu-props="{ bottom: true, offsetY: true }" :disabled="action == 'det' ? true : false"
                        :error-messages="genderErrors" @blur="$v.gender.$touch()" label="Gender" dense></v-select>
                    </v-col>
                    <v-col cols="12" md="6" class="pl-0 pt-0">
                      <v-text-field v-model="phone" :disabled="action == 'det' ? true : false"
                        :error-messages="phoneErrors" @blur="$v.phone.$touch()" label="Phone" dense></v-text-field>
                    </v-col>
                  </v-row>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-divider color="grey" class="m-0 p-0"></v-divider>
          <v-card-actions class="pb-0">
            <v-spacer></v-spacer>
            <v-btn type="submit" class="mb-2" elevation="2" small color="primary"
              v-if="action == 'add' || action == 'upd'" @click.prevent="onHandle">
              Save
            </v-btn>
            <v-btn type="button" class="mr-5 mb-3" elevation="2" small color="warning" @click.prevent="closeDialog">
              Back
            </v-btn>
          </v-card-actions>
        </form>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { validationMixin } from "vuelidate";
import { required, maxLength, minLength, email } from "vuelidate/lib/validators";
import axios from "axios";
import { mapActions } from "vuex";
import UploadButton from "./UploadButton.vue";
import { EventBus } from "@/main";

export default {
  name: "user-dialog",

  mixins: [validationMixin],

  validations: {
    role: { required },
    email: { required, email },
    password: {
      required,
      minLength: minLength(8),
      valid: function (value) {
        const containsUppercase = /[A-Z]/.test(value);
        const containsLowercase = /[a-z]/.test(value);
        const containsNumber = /[0-9]/.test(value);
        const containsSpecial = /[#?!@$%^&*-]/.test(value);
        return (containsUppercase && containsLowercase && containsNumber && containsSpecial);
      },
    },
    fname: { required, maxLength: maxLength(30) },
    lname: { required, maxLength: maxLength(30) },
    gender: { required },
    phone: {
      required,
      minLength: minLength(10),
      maxLength: maxLength(10),
      valid: function (value) {
        const allNumber = /^\d+$/.test(value);
        return allNumber;
      },
    },
  },

  components: {
    "upload-button": UploadButton,
  },

  data() {
    return {
      user: {},
      roles: [],
      actives: [
        {
          name: "Enable",
          value: 1,
        },
        {
          name: "Disabled",
          value: 0,
        },
      ],
      genders: [
        {
          name: "Male",
          value: 1,
        },
        {
          name: "Female",
          value: 0
        }
      ],
      role: {},
      active: true,
      email: null,
      password: null,
      image: null,
      fname: null,
      lname: null,
      address: null,
      gender: null,
      phone: null,
      file: null,
      fileURL: null,
      show: false,
      showPassword: false,
    };
  },

  props: {
    dialog: Boolean,
    action: String,
    selectedUser: Object,
  },

  computed: {
    roleErrors() {
      const errors = [];
      if (!this.$v.role.$dirty) return errors;
      !this.$v.role.required && errors.push("Role is required");
      return errors;
    },

    emailErrors() {
      const errors = [];
      if (!this.$v.email.$dirty) return errors;
      !this.$v.email.required && errors.push("Email is required.");
      !this.$v.email.email && errors.push("Invalid email");
      return errors;
    },

    passwordErrors() {
      const errors = [];
      if (!this.$v.password.$dirty) return errors;
      (!this.$v.password.minLength ||
        !this.$v.password.required ||
        !this.$v.password.valid) &&
        errors.push("Invalid Password");
      return errors;
    },

    fnameErrors() {
      const errors = [];
      if (!this.$v.fname.$dirty) return errors;
      !this.$v.fname.maxLength &&
        errors.push("Fist name must be at most 30 characters long");
      !this.$v.fname.required && errors.push("Fist name is required.");
      return errors;
    },

    lnameErrors() {
      const errors = [];
      if (!this.$v.lname.$dirty) return errors;
      !this.$v.lname.maxLength &&
        errors.push("Last name must be at most 30 characters long");
      !this.$v.lname.required && errors.push("Last name is required.");
      return errors;
    },

    genderErrors() {
      const errors = [];
      if (!this.$v.gender.$dirty) return errors;
      !this.$v.gender.required && errors.push("Gender is required");
      return errors;
    },

    phoneErrors() {
      const errors = [];
      if (!this.$v.phone.$dirty) return errors;
      !this.$v.phone.valid && errors.push("Phone must be digit only");
      !this.$v.phone.maxLength && errors.push("Phone must be 10 digits");
      !this.$v.phone.minLength && errors.push("Phone must be 10 digits");
      !this.$v.phone.required && errors.push("Phone is required.");
      return errors;
    },

    width() {
      switch (this.$vuetify.breakpoint.name) {
        case 'md': return "70%";
        case 'lg': return "50%";
        case 'xl': return "40%";
        default: return "100%";
      }
    }
  },

  methods: {
    ...mapActions([
      "getUsers",
      "addUser",
      "updateUser",
      "disableUser",
    ]),

    async prepareData() {
      let url = this.env.apiURL + "users/prepare-data";
      await axios.get(url).then((response) => {
        this.roles = response.data.roles;
      });
    },

    onHandle() {
      if (this.validation()) return;

      this.setUser();
      if (this.action == "add") this.addUser({ user: this.user, file: this.file });
      if (this.action == "upd") this.updateUser({ user: this.user, file: this.file });
    },

    closeDialog() {
      EventBus.$emit("dialog");
    },

    setUser() {
      this.user.email = this.email;
      this.user.password = this.password;
      this.user.role = this.role;
      this.user.active = this.active;
      this.user.image = this.image;
      this.user.fname = this.fname;
      this.user.lname = this.lname;
      this.user.address = this.address;
      this.user.gender = this.gender;
      this.user.phone = this.phone;
    },

    setField() {
      const { email, password, role, active, image, fname, lname, address, gender, phone } = this.selectedUser;
      this.user = Object.assign({}, this.selectedUser);
      this.email = email;
      this.password = password;
      this.role = { name: role.name, id: role.id };
      this.active = this.action == "add" ? 1 : parseInt(active);
      this.image = image;
      this.fname = fname;
      this.lname = lname;
      this.address = address;
      this.gender = gender;
      this.phone = phone;
    },

    resetField() {
      this.user = null;
      this.fname = null;
      this.lname = null;
      this.email = null;
      this.password = null;
      this.role = null;
      this.active = true;
      this.address = null;
      this.gender = null;
      this.phone = null;
      this.image = null;
      this.file = null;
      this.fileURL = null;
      this.$v.$reset();
    },

    validation() {
      if (this.action == "add" && this.$v.$invalid) {
        this.$v.$touch();
        return true;
      }

      if (this.action == "upd" &&
        (this.$v.role.$invalid ||
          this.$v.fname.$invalid ||
          this.$v.lname.$invalid ||
          this.$v.gender.$invalid ||
          this.$v.phone.$invalid)
      ) {
        this.$v.role.$touch();
        this.$v.fname.$touch();
        this.$v.lname.$touch();
        this.$v.gender.$touch();
        this.$v.phone.$touch();
        return true;
      }
      return false;
    }
  },

  created() {
    this.show = this.dialog;
    this.prepareData();

    if (this.action != "add") this.setField();

    EventBus.$on("file", (file) => {
      this.file = file;
    });

    EventBus.$on("reset", () =>
      this.resetField()
    );
  },

  watch: {
    file: function () {
      this.image = this.file.name;
      this.fileURL = URL.createObjectURL(this.file);
    },
  },
};
</script>
