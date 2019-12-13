<template>
  <v-container>
    <!-- コメント投稿欄 -->
    <ValidationObserver v-slot="{ invalid }">
      <ValidationProvider name="感想" rules="required" v-slot="{ errors }">
        <v-text-field
          label="コメントを追加..."
          v-model="content"
          required
          v-show="isLoggedIn"
        >
          <template v-slot:append-outer>
            <v-btn 
              text 
              :disabled="invalid"
              color="info"
              @click="commentUpload"
            >投稿する</v-btn>
          </template>
        </v-text-field>
      </ValidationProvider>  
    </ValidationObserver>
    <v-subheader>Comments</v-subheader>
    <!-- コメント表示欄 -->
    <template>
      <ul>
        <li v-for="(comment, index) in comments" :key="index" style="list-style:none;">
          <span class="grey--text text--darken-3 mx-4">{{ comment.content }}</span>
          <span class="brown--text text--darken-1 ml-5">{{ comment.user.name }}</span>
          <v-divider></v-divider>
        </li>
      </ul>
    </template>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      content: ""
    }
  },
  props: ["topic"],
  computed: {
    user(){
      return this.$store.state.auth.User
    },
    comments() {
      return this.topic.comments
    },
    isLoggedIn(){
      return this.$store.state.auth.isLoggedIn;
    }
  },
  methods: {
    // railsのコメントcreateアクションへアップロード
    commentUpload(){
      this.$axios
        .post(
          process.env.apiBaseUrl + '/api/comments/',
          {
            user_id: this.user.user.id,
            topic_id: this.topic.id,
            content: this.content,
          }
        // アップロード成功時  
        ).then(res =>{
          console.log(res);
          this.content = ""
          // $set を使って this.topic の要素を更新。
          this.$set(this.topic,'comments', res.data.comments)
        // アップロード失敗時  
        }).catch(error => {
          console.log(error);
        });
    }
  },
}
</script>