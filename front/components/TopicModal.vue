<template>
<!-- 各トピックモーダルの内部 -->
  <v-card class="brown lighten-4">
    <v-card-title>
      <span class="brown--text text--darken-1">{{
        topic.user.name
      }}</span>
      <span class="body-1 mr-2">さんの投稿</span>
      <span class="caption brown--text text--darken-1"
        >({{ topic.date }}に訪問)</span
      >
      <v-spacer />
      <v-img
        :aspect-ratio="16 / 9"
        :src="topic.image.url"
        width="100%"
      />
    </v-card-title>
    <v-card-text>
      <div class="d-inline-flex">
        <span class="title brown--text text--darken-1 mr-2">{{
          topic.shop_name
        }}</span>
        <span
          class="subheading brown--text text--darken-1 pt-2 mr-2"
        >・{{ topic.meals }}</span>
        <span class="subheading brown--text text--darken-2 pt-2">予算：{{ topic.price }}</span>
        <v-rating
          class="ml-1 mt-1"
          :value="topic.rating"
          color="amber"
          dense
          half-increments
          readonly
          size="14"
        />
        <span class="mt-2 mx-1">{{ topic.rating }}</span>
        <span class="caption mt-2">(おすすめ度)</span>
      </div>
      <v-divider />
      <div>
        <br></br>
        <span>{{ topic.review }}</span>
      </div>
    </v-card-text>
    <v-card-actions>
      <v-spacer />
      <!-- いいねコンポーネント -->
      <LikeBtn :topic="topic" />
      <!-- コメント表示ボタン -->
      <v-btn
        outlined
        color="grey darken-1"
        @click="comments = !comments"
      >
        <v-icon>far fa-comment-dots</v-icon>
      </v-btn>
    </v-card-actions>  
    <!-- コメントエリアコンポーネント -->
    <v-slide-y-transition>
      <v-card-actions v-show="comments">
        <CommentArea :topic="topic" />
      </v-card-actions>
    </v-slide-y-transition>
  </v-card>
</template>


<script>
import CommentArea from "./CommentArea.vue"
import LikeBtn from "./LikeBtn.vue"

export default {
  data() {
    return {
      comments: false,
    }
  },
  props: ["topic"],
  components: {
    CommentArea,
    LikeBtn
  }
}
</script>