<template>
  <v-layout justify-center>
    <v-flex xs12 sm12 md12>
      <v-card class="mt-4 mb-4 pa-3">
        <v-container
          fluid
          grid-list-md
        >
          <v-layout row wrap>
            <v-flex
              v-for="topic in topics"
              :key="topic.id"
              xs12 sm6 md4
            >
              <v-card class="grey lighten-3 ma-2">
                <v-card-text>
                  <v-img
                    :src="topic.image.url"
                    width="100%"
                  >
                    <v-container
                      fill-height
                      fluid
                      pa-2
                    >
                      <!-- <v-layout fill-height>
                        <v-flex xs12 align-end flexbox>
                          <span class="headline white--text" v-text="topic.shop_name"></span>
                        </v-flex>
                      </v-layout> -->
                    </v-container>
                  </v-img>
                  <!-- 画像下テキスト欄 -->
                  <v-card-actions
                    <span>{{ topic.user.name }}</span>
                    <v-spacer></v-spacer>
                    <v-btn icon>
                      <v-icon>f</v-icon>
                    </v-btn>
                  </v-card-actions>
                </v-card-text>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card>
      <NewTopicBtn v-show="isLoggedIn"></NewTopicBtn>
    </v-flex>
  </v-layout>

</template>

<script>
import NewTopicBtn from "../components/NewTopicBtn.vue"

export default {
  async asyncData({ app }) {
    const res = await app.$axios.$get('http://localhost:8000/api/topics');
    console.log(res);
    return { topics: res }; 
  },
  components: {
    NewTopicBtn
  },
  computed: {
    isLoggedIn(){
      return this.$store.state.auth.isLoggedIn;
    }
  },
}
</script>