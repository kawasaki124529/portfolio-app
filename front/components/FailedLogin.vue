<template>
  <v-alert type="error" transition="slide-y-transition" v-show="failedLogin">
    ログインに失敗しました。
  </v-alert>
</template>

<script>
export default {
  computed: {
    failedLogin(){
      return this.$store.state.auth.failedLogin;
    },
  }
}
</script>