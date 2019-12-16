<template>
  <!-- ボタン部分 -->
  <v-dialog v-model="dialog" max-width="800px">
    <template v-slot:activator="{ on }">
      <v-btn v-show="!isLoggedIn" class="white--text" text large v-on="on">
        LOGIN
      </v-btn>
    </template>
    <!-- モーダル部分 -->
    <v-card class="elevation-12">
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
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
      dialog: false
    }
  },
  computed: {
    isLoggedIn() {
      return this.$store.state.auth.isLoggedIn
    }
  },
  methods: {
    login() {
      this.$store.dispatch("auth/login", {
        email: this.email,
        password: this.password
      })
      this.dialog = false
    },
    // テストユーザー用ログイン
    easyLogin() {
      this.$store.dispatch("auth/login", {
        email: "test@test.com",
        password: "testtest"
      })
      this.dialog = false
    }
  }
}
</script>
