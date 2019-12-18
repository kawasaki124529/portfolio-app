<template>
  <v-layout justify-center>
    <v-flex xs12>
      <v-container fluid>
        <v-card class="elevation-12">
          <validation-observer v-slot="{ invalid }">
            <v-toolbar color="primary" dark flat>
              <v-toolbar-title>SignUp form</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form>
                <ValidationProvider
                  v-slot="{ errors }"
                  name="name"
                  rules="required|max:8"
                >
                  <v-text-field
                    v-model="name"
                    label="ユーザーネーム"
                    name="name"
                    prepend-icon=""
                    :error-messages="errors[0]"
                    type="text"
                  />
                </ValidationProvider>
                <ValidationProvider
                  v-slot="{ errors }"
                  name="email"
                  rules="required|email"
                >
                  <v-text-field
                    v-model="email"
                    label="Email"
                    name="email"
                    prepend-icon=""
                    :error-messages="errors[0]"
                    type="text"
                  />
                </ValidationProvider>
                <ValidationProvider
                  v-slot="{ errors }"
                  name="password"
                  rules="required|min:4"
                >
                  <v-text-field
                    id="password"
                    v-model="password"
                    label="Password"
                    name="password"
                    prepend-icon=""
                    :error-messages="errors[0]"
                    type="password"
                  />
                </ValidationProvider>
                <ValidationProvider
                  v-slot="{ errors }"
                  name="Password(確認用)"
                  rules="required|min:4|confirmed:password"
                >
                  <v-text-field
                    id="password_confirmation"
                    v-model="password_confirmation"
                    label="Password(確認用)"
                    name="password_confimation"
                    prepend-icon=""
                    :error-messages="errors[0]"
                    type="password"
                  />
                </ValidationProvider>
              </v-form>
            </v-card-text>
            <v-card-actions>
              <v-spacer />
              <v-btn color="primary" :disabled="invalid" @click.prevent="register">
                SIGNUP
              </v-btn>
            </v-card-actions>
          </validation-observer>
          <!-- ローディング表示 -->
          <v-progress-linear
            :active="loading"
            :indeterminate="loading"
            absolute
            bottom
            color="deep-purple accent-4"
          ></v-progress-linear>
        </v-card>
      </v-container>
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
      password_confirmation: "",
      name: "",
      loading: false
    }
  },
  computed: {
    isLoggedIn() {
      return this.$store.state.auth.isLoggedIn
    }
  },
  methods: {
    // railsのUser登録にアクセスしsign_up処理
    register() {
      this.loading = true;
      this.$store.dispatch("auth/sign_up", {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation,
        name: this.name
      })
    }
  }
}
</script>
