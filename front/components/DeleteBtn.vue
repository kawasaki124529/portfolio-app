<template>
  <v-card-actions v-if="isLoggedIn">
    <v-btn outlined color="grey darken-1" @click="deleteTopic()">
      <v-icon>far fa-trash-alt</v-icon>
    </v-btn>
  </v-card-actions>
</template>

<script>
export default {
  props: ["topic"],
  computed: {
    isLoggedIn() {
      return this.$store.state.auth.isLoggedIn
    },
    user() {
      return this.$store.state.auth.User
    }
    // ログインユーザが,いいねしているかの判定処理
  },
  methods: {
    // rails側のdestroyアクションにリクエストするメソッド
    deleteTopic() {
      this.$axios
        .delete(process.env.apiBaseUrl + "/api/topics", {
          params: {
            topic_id: this.topic.id
          }
        })
        .then(res => {
          console.log(res)
          this.$router.go({ path: "/my_topics", force: true })
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>
