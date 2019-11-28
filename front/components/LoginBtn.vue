<template>
  <!-- ボタン部分 -->
  <v-dialog v-model="dialog" max-width="800px">
    <template v-slot:activator="{ on }">
      <v-btn 
        class="white--text"
        text large
        v-on="on"
        v-show="!isLoggedIn"
      >
        LOGIN
      </v-btn>
    </template>
    <!-- モーダル部分 -->
    <v-card class="elevation-12">
      <validation-observer v-slot="{ handleSubmit }">
        <v-toolbar
          color="primary"
          dark
          flat
        >
          <v-toolbar-title>LogIn form</v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-form>
            <ValidationProvider name="email" rules="required|email" v-slot="{ errors }">
              <v-text-field
                label="Email"
                name="email"
                prepend-icon=""
                :error-messages="errors[0]"
                type="text"
                v-model="email"
              ></v-text-field>
            </ValidationProvider>
            <ValidationProvider name="password" rules="required|min:4" v-slot="{ errors }">
              <v-text-field
                id="password"
                label="Password"
                name="password"
                prepend-icon=""
                :error-messages="errors[0]"
                type="password"
                v-model="password"
              ></v-text-field>
            </ValidationProvider>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click.prevent="handleSubmit(login)">Log_in</v-btn>
        </v-card-actions>
      </validation-observer>
    </v-card>
  </v-dialog>
</template>

<script>
  export default {
    data() {
      return {
        email: '',
        password: '',
        dialog: false,
      }
    },
    methods: {
      login() {
        this.$store.dispatch('auth/login', {
          email: this.email,
          password: this.password
        });
        this.dialog = false;
      }
    },
    computed: {
      isLoggedIn(){
        return this.$store.state.auth.isLoggedIn;
      }
    },
  }
</script>