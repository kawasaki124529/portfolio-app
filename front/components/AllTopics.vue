<template>
  <v-container fluid grid-list-md>
    <v-item-group>
      <v-layout row wrap>
        <v-flex v-for="(topic, i) in topics" :key="i" xs12 sm6 md4>
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
                      <v-layout fill-height align-center justify-center ma-0>
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
                      <span class="subtitle-2 font-weight-medium font-italic">
                        {{ topic.shop_name }}</span>
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
                  <TopicModal :topic="topic" />
                </v-dialog>
              </v-card>
            </v-hover>
          </v-item>
        </v-flex>
      </v-layout>
    </v-item-group>
  </v-container>
</template>

<script>
import TopicModal from "./TopicModal.vue"

export default {
  components: {
    TopicModal
  },
  props: ["topics"],
  computed: {
    isLoggedIn() {
      return this.$store.state.auth.isLoggedIn
    }
  }
}
</script>