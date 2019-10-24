<template>
  <v-app id="inspire">
    <v-content>
      <v-container
        class="fill-height"
        fluid
      >
        <v-row
          align="center"
          justify="center"
        >
          <v-col
            cols="12"
            md="10"
          >
            <v-card class="elevation-12">
              <v-toolbar
                color="primary"
                dark
                flat
              >
                <v-toolbar-title>SignUp form</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field
                    label="Email"
                    name="email"
                    prepend-icon=""
                    type="text"
                    v-model="email"
                  ></v-text-field>
                  <v-text-field
                    id="password"
                    label="Password"
                    name="password"
                    prepend-icon=""
                    type="password"
                    v-model="password"
                  ></v-text-field>
                  <v-text-field
                    id="password_confirmation"
                    label="Password(確認用)"
                    name="password_confimation"
                    prepend-icon=""
                    type="password"
                    v-model="password_confirmation"
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" @click="register">SIGNUP</v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
  export default {
    data() {
      return {
        email: '',
        password: '',
        password_confirmation: '',
      };
    },
    methods: {
      register() {
        this.$axios
          .post(
            '/auth',
            {
              email: this.email,
              password: this.password,
              password_confirmation: this.password_confirmation
            }
          ).then(response => {
            console.log(response)
          });
        this.email = "";
        this.password = "";
        this.password_confirmation = "";
      }
    }
  }
</script>