<template>
  <v-layout justify-center>
    <v-flex xs12 sm12 md12>
      <!-- ログインユーザーの投稿トピックがない場合のアラート -->
      <v-alert v-if="topics.length === 0" type="warning">
        {{ user.user.name }}さんの投稿トピックが見つかりません。
      </v-alert>
      <!-- グレー背景 -->
      <v-card v-if="topics.length !== 0" class="grey lighten-3 mt-4 mb-4 pa-3">
        <v-container fluid grid-list-md>
          <v-item-group>
            <v-layout row wrap>
              <v-flex v-for="(topic, i) in topics.data" :key="i" xs12 sm6 md4>
                <!-- トピック個別 -->
                <v-item v-slot:default="{ active, toggle }">
                  <v-hover>
                    <v-card
                      slot-scope="{ hover }"
                      class="brown lighten-4 ma-2"
                      :class="`elevation-${hover ? 12 : 2}`"
                      @click="toggle"
                    >
                      <v-card-text>
                        <v-img
                          :aspect-ratio="16 / 9"
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
                              <v-progress-circular
                                indeterminate
                                color="grey lighten-5"
                              />
                            </v-layout>
                          </template>
                        </v-img>
                        <!-- 画像下テキスト欄 -->
                        <v-card-title>
                          <div>
                            <span
                              class="subtitle-2 font-weight-medium font-italic"
                              >{{ topic.shop_name }}</span
                            >
                            <div class="d-flex">
                              <v-rating
                                :value="topic.rating"
                                color="amber"
                                dense
                                half-increments
                                readonly
                                size="14"
                              />
                              <div class="ml-2 grey--text text--darken-2">
                                <span>{{ topic.rating }}</span>
                                <span class="caption">(おすすめ度)</span>
                              </div>
                            </div>
                          </div>
                          <v-spacer />
                          <v-icon small class="mr-0" color="red">
                            far fa-heart
                          </v-icon>
                          <span class="ma-1 grey--text text--darken-1">{{
                            topic.likes.length
                          }}</span>
                          <v-icon small class="mr-0" color="grey">
                            far fa-comment
                          </v-icon>
                          <span class="ma-1 grey--text text--darken-1">{{
                            topic.comments.length
                          }}</span>
                        </v-card-title>
                      </v-card-text>
                      <!-- モーダル部分 -->
                      <v-dialog v-model="active" max-width="800px">
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
                            <v-btn icon @click="toggle">
                              <v-icon>fas fa-times</v-icon>
                            </v-btn>
                            <v-img
                              :aspect-ratio="16 / 9"
                              :src="topic.image.url"
                              width="100%"
                            />
                          </v-card-title>
                          <v-card-text>
                            <div class="d-inline-flex">
                              <span
                                class="title brown--text text--darken-1 mr-2"
                              >{{ topic.shop_name }}</span>
                              <span
                                class="subheading brown--text text--darken-1 pt-2 mr-2"
                              >・{{ topic.meals }}</span>
                              <span
                                class="subheading brown--text text--darken-2 pt-2"
                              >予算：{{ topic.price }}</span>
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
                              <br>
                              <span>{{ topic.review }}</span>
                            </div>
                          </v-card-text>
                          <v-card-actions>
                            <v-spacer />
                            <!-- トピック削除コンポーネント -->
                            <v-btn outlined color="grey darken-1" @click="deleteTopic(topic.id)">
                              <v-icon>far fa-trash-alt</v-icon>
                            </v-btn>
                          </v-card-actions>
                          <v-slide-y-transition>
                            <!-- コメントコンポーネント -->
                            <v-card-actions>
                              <CommentArea :topic="topic" />
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
    </v-flex>
  </v-layout>
</template>

<script>
import CommentArea from "../components/CommentArea.vue"

export default {
  data() {
    return {
      active: false
    }
  },
  components: {
    CommentArea,
  },
  // railsのTopic/likesアクションにアクセスし、お気に入りトピックを取得
  async asyncData({ app, store }) {
    const res = await app.$axios.get(
      process.env.apiBaseUrl + "/api/topics/mytopic",
      {
        params: { user_id: store.state.auth.User.user.id }
      }
    )
    console.log(res)
    return { topics: res }
  },
  computed: {
    isLoggedIn() {
      return this.$store.state.auth.isLoggedIn
    },
    user() {
      return this.$store.state.auth.User
    }
  },
  methods: {
    // rails側のdestroyアクションにリクエストするメソッド
    deleteTopic(id) {
      this.$axios
        .delete(process.env.apiBaseUrl + "/api/topics", {
          params: {
            topic_id: id
          }
        })
        .then(res => {
          console.log(res)
          if (res.status === 200) {
         // $set を使って topics の要素を更新。
            this.$set(this.topics, "data", res.data)
          }
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>
