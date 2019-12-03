<template>
  <v-card-actions v-if="isLoggedIn">
    <v-btn  outlined color="grey darken-1" v-show="!isLiked" @click="registerLike()">
      <v-icon>far fa-heart</v-icon>
      <span class="ma-1">{{ topic.likes.length }}</span>
    </v-btn>
    <v-btn outlined color="grey darken-1" v-show="isLiked"  @click="deleteLike()">
      <v-icon color="red">fas fa-heart</v-icon>
      <span class="ma-1 red--text">{{ topic.likes.length }}</span>
    </v-btn>
  </v-card-actions>
</template>

<script>
export default {
  props: ["topic"],
  computed: {
    isLoggedIn(){
      return this.$store.state.auth.isLoggedIn;
    },
    user(){
      return this.$store.state.auth.User
    },
    // ログインユーザが,いいねしているかの判定処理
    isLiked(){
      if (this.topic.likes.length === 0) { return false }
      else {return Boolean(this.findLikeId())}
    }
  },
  methods: {
    // rails側のcreateアクションにリクエストするメソッド
    registerLike(){
      this.$axios
        .post(
          'http://localhost:8000/api/likes/',
          {
            user_id: this.user.user.id,
            topic_id: this.topic.id,
          }
        ).then(res => {
          console.log(res);
          // $set を使って this.topic の要素を更新。
          this.$set(this.topic,'likes', res.data.likes)
        })
        .catch(error => {
          console.log(error);
        })
    },
    // rails側のdestroyアクションにリクエストするメソッド
    deleteLike(){
      this.$axios
        .delete(
          'http://localhost:8000/api/likes/',{
            params: {
              user_id: this.user.user.id,
              topic_id: this.topic.id,
            }
          }
        ).then(res => {
          console.log(res);
          // $set を使って this.topic の要素を更新。
          this.$set(this.topic,'likes', res.data.likes)
        })
        .catch(error => {
          console.log(error);
        })
    },
    // ログインユーザのIDがトピックのいいねに含まれているか確認
    findLikeId() {
      const like = this.topic.likes.find((like) => {
        return (like.user_id === this.user.user.id)
      })
      if (like) { return like.user_id }
    }
  },
}
</script>