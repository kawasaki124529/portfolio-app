<template>
  <v-alert type="info" transition="slide-y-transition" v-show="successLogout">
    またのお越しをお待ちしております！
  </v-alert>
</template>

<script>
export default {
  computed: {
    successLogout(){
      return this.$store.state.auth.successLogout;
    },
  }
}
</script>