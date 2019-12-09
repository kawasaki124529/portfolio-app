<template>
  <v-layout justify-center>
    <v-flex xs12 sm12 md12>
      <!-- グレー背景 -->
      <v-card class="grey lighten-3 mt-4 mb-4 pa-3 " >
        <v-container
          fluid
          grid-list-md
        >
          <v-item-group>
            <v-layout row wrap>
              <v-flex
                v-for="(topic, i) in topics"
                :key="i"
                xs12 sm6 md4
              >
                <!-- トピック個別 -->
                <v-item v-slot:default="{ active, toggle }">
                <v-hover>
                  <v-card 
                    class="brown lighten-4 ma-2" 
                    slot-scope="{ hover }" 
                    :class="`elevation-${hover ? 12 : 2}`"
                    @click="toggle"
                  >
                    <v-card-text>
                      <v-img
                        :aspect-ratio="16/9"
                        :src="topic.image.url"
                        width="100%"
                      >
                        <template v-slot:placeholder>
                          <v-layout
                            fill-height
                            align-center
                            justify-center
                            ma-0
                          >
                            <v-progress-circular indeterminate color="grey lighten-5"></v-progress-circular>
                          </v-layout>
                        </template>
                      </v-img>
                      <!-- 画像下テキスト欄 -->
                      <v-card-title>
                        <div>
                          <span class="subtitle-2 font-weight-medium font-italic" >{{ topic.shop_name }}</span>
                          <div class="d-flex">
                            <v-rating
                              :value="topic.rating"
                              color="amber"
                              dense
                              half-increments
                              readonly
                              size="14"
                            ></v-rating>
                            <div class="ml-2 grey--text text--darken-2">
                              <span>{{ topic.rating }}</span>
                              <span class="caption">(おすすめ度)</span>
                            </div>
                          </div>
                        </div>
                        <v-spacer></v-spacer>
                        <v-icon small class="mr-0" color="red">far fa-heart</v-icon>
                        <span class="ma-1 grey--text text--darken-1">{{ topic.likes.length }}</span>
                        <v-icon small class="mr-0" color="grey">far fa-comment</v-icon>
                        <span class="ma-1 grey--text text--darken-1">{{ topic.comments.length }}</span>
                      </v-card-title>
                    </v-card-text>
                    <!-- モーダル部分 -->
                    <v-dialog v-model="active" max-width="800px">
                      <v-card class="brown lighten-4">
                        <v-card-title>
                          <span class="brown--text text--darken-1">{{ topic.user.name }}</span>
                          <span class="body-1 mr-2">さんの投稿</span>
                          <span class="caption brown--text text--darken-1">({{topic.date}}に訪問)</span>
                          <v-spacer></v-spacer>
                          <v-btn icon @click="toggle">
                            <v-icon>fas fa-times</v-icon>
                          </v-btn>
                          <v-img
                            :aspect-ratio="16/9"
                            :src="topic.image.url"
                            width="100%"
                          >
                          </v-img>
                        </v-card-title>
                          <v-card-text>
                            <div class="d-inline-flex">
                              <span class="title brown--text text--darken-1 mr-2">{{ topic.shop_name}}</span>
                              <span class="subheading brown--text text--darken-1 pt-2 mr-2">・{{ topic.meals }}</span>
                              <span class="subheading brown--text text--darken-2 pt-2">予算：{{ topic.price }}</span>
                              <v-rating
                              class="ml-1 mt-1"
                              :value="topic.rating"
                              color="amber"
                              dense
                              half-increments
                              readonly
                              size="14"
                              ></v-rating>
                              <span class="mt-2 mx-1">{{ topic.rating }}</span>
                              <span class="caption mt-2">(おすすめ度)</span>
                            </div>
                            <v-divider></v-divider>
                            <div>
                              <br>
                              <span>{{ topic.review }}</span>
                            </div>
                          </v-card-text>
                        <v-card-actions>
                          <v-spacer/>
                          <!-- いいねコンポーネント -->
                          <LikeBtn :topic="topic"></LikeBtn>
                          <!-- コメントコンポーネント -->
                          <v-btn outlined color="grey darken-1" @click="comments = !comments">
                            <v-icon>far fa-comment-dots</v-icon>
                          </v-btn>
                        </v-card-actions>
                        <v-slide-y-transition>
                          <v-card-actions v-show="comments">
                            <CommentArea :topic="topic"></CommentArea>
                          </v-card-actions>
                        </v-slide-y-transition>
                      </v-card>
                    </v-dialog>
                  </v-card>
                </v-hover>
                </v-item>
              </v-flex>            
            </v-layout>
          </v-item-group>
        </v-container>
      </v-card>
      <!-- トピック投稿コンポーネント -->
      <NewTopicBtn v-show="isLoggedIn"></NewTopicBtn>
    </v-flex>
  </v-layout>

</template>

<script>
import NewTopicBtn from "../components/NewTopicBtn.vue"
import LikeBtn from "../components/LikeBtn.vue"
import CommentArea from "../components/CommentArea.vue"

export default {
  data () {
    return {
      comments: false
    }
  },
  // ページ読み込み時にTopicコントローラーにgetリクエスト
  async asyncData({ app }) {
    const res = await app.$axios.$get('http://localhost:8000/api/topics');
    console.log(res);
    return { topics: res }; 
  },
  components: {
    NewTopicBtn,
    LikeBtn,
    CommentArea
  },
  computed: {
    isLoggedIn(){
      return this.$store.state.auth.isLoggedIn;
    }
  },
}
</script>