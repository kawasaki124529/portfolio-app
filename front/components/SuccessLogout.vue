<template>
  <v-alert v-show="successLogout" type="info" transition="slide-y-transition">
    またのお越しをお待ちしております！
  </v-alert>
</template>

<script>
export default {
  computed: {
    successLogout() {
      return this.$store.state.auth.successLogout
    }
  }
}
</script>
