<template>
  <!-- ログイン失敗時のアラート -->
  <v-alert v-show="failedLogin" type="error" transition="slide-y-transition">
    ログインに失敗しました。
  </v-alert>
</template>/

<script>
export default {
  computed: {
    failedLogin() {
      return this.$store.state.auth.failedLogin
    }
  }
}
</script>
