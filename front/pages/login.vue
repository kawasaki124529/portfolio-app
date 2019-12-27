<template>
  <v-layout justify-center>
    <v-flex xs12>
      <v-container fluid>
        <v-card>
          <validation-observer v-slot="{ handleSubmit }">
            <v-toolbar color="primary" dark flat>
              <v-toolbar-title>LogIn form</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form>
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
              </v-form>
            </v-card-text>
            <v-card-actions>
              <v-btn color="yellow" @click="easyLogin">
                テストログイン
              </v-btn>
              <v-spacer />
              <v-btn color="primary" @click.prevent="handleSubmit(login)">
                Log_in
              </v-btn>
            </v-card-actions>
          </validation-observer>
          <!-- ローディング中の表示 -->
          <v-progress-linear
            :active="loading"
            :indeterminate="loading"
            absolute
            bottom
            color="deep-purple accent-4"
          />
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
      loading: false
    }
  },
  computed: {
    isLoggedIn() {
      return this.$store.state.auth.isLoggedIn
    }
  },
  methods: {
    login() {
      this.loading = true
      this.$store.dispatch("auth/login", {
        email: this.email,
        password: this.password
      })
    },
    // テストユーザー用ログイン
    easyLogin() {
      this.loading = true
      this.$store.dispatch("auth/login", {
        email: "test@test.com",
        password: "testtest"
      })
    }
  }
}
</script>
