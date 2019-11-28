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
        SIGNUP
      </v-btn>
    </template>
    <!-- モーダル部分 -->
    <v-card class="elevation-12">
      <validation-observer v-slot="{ invalid }">
        <v-toolbar
          color="primary"
          dark
          flat
        >
          <v-toolbar-title>SignUp form</v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-form>
            <ValidationProvider name="name" rules="required|max:8" v-slot="{ errors }">
              <v-text-field
                label="ユーザーネーム"
                name="name"
                prepend-icon=""
                :error-messages="errors[0]"
                type="text"
                v-model="name"
              ></v-text-field>
            </ValidationProvider>
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
            <ValidationProvider name="Password(確認用)" rules="required|min:4" v-slot="{ errors }">
              <v-text-field
                id="password_confirmation"
                label="Password(確認用)"
                name="password_confimation"
                prepend-icon=""
                :error-messages="errors[0]"
                type="password"
                v-model="password_confirmation"
              ></v-text-field>
            </ValidationProvider>  
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" :disabled="invalid" @click.prevent="register">SIGNUP</v-btn>
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
        password_confirmation: '',
        name: '',
        dialog: false
      };
    },
    methods: {
      register() {
        // this.$validator.validateAll().then((result) => {
          this.$axios
            .post(
              'http://localhost:8000/api/auth/',
              {
                email: this.email,
                password: this.password,
                password_confirmation: this.password_confirmation,
                name: this.name
              }
            ).then(response => {
              console.log(response);
              this.$store.commit('auth/updateTokens', {
                accessToken: response.headers['access-token'],
                expiry: response.headers.expiry,
                uid: response.headers.uid,
              });
              this.$store.commit('auth/updateUser', {
                userName: response.data.data
              });
              this.$store.commit('auth/updateIsLoggedIn', true);
              this.$router.push('/');
              this.dialog = false; 
            })
            .catch(error => {
              console.log(error);
            });
      }
    },
    computed: {
      isLoggedIn(){
        return this.$store.state.auth.isLoggedIn;
      }
    },
  }
</script>