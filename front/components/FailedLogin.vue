<template>
  <!-- ログイン失敗時のアラート -->
  <v-alert type="error" transition="slide-y-transition" v-show="failedLogin">
    ログイン/サインアップに失敗しました。
  </v-alert>
</template>/

<script>
export default {
  computed: {
    failedLogin(){
      return this.$store.state.auth.failedLogin;
    },
  }
}
</script>