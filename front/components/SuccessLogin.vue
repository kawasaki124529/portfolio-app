<template>
  <v-alert type="success" transition="slide-y-transition" v-if="successLogin">
    こんにちは{{ user.user.name }}さん！
  </v-alert>
</template>

<script>
export default {
  computed: {
    successLogin(){
      return this.$store.state.auth.successLogin;
    },
    user(){
      return this.$store.state.auth.User
    }
  }
}
</script>