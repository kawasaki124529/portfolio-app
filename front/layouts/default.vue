<template>
  <v-app>
    <!-- ヘッダーbar -->
    <v-app-bar fixed app style="background-color:rgba(5,5,5,0.7);">
      <!-- ヘッダータイトル -->
      <v-btn
        class="white--text font-weight-thin font-italic display-1"
        text
        large
        nuxt
        to="/"
      >
        俺達のハンバーガー！
      </v-btn>
      <v-btn class="white--text" text large nuxt to="/current_area">
        <v-icon>fas fa-search-location fa-xs</v-icon>
        現在地周辺のお店を探す
      </v-btn>
      <v-btn class="white--text" text large nuxt to="/topics">
        <v-icon>fas fa-camera-retro fa-xs</v-icon>
        みんなの写真
      </v-btn>
      <v-spacer />
      <LoginBtn v-show="!isLoggedIn" />
      <SignupBtn />
      <v-btn v-show="isLoggedIn" class="white--text" text large @click="logout">
        LOGOUT
      </v-btn>
      <v-btn
        v-if="isLoggedIn"
        class="white--text"
        color="blue-grey"
        @click.stop="rightDrawer = !rightDrawer"
      >
        {{ user.user.name }}
        <v-icon right>
          mdi-menu
        </v-icon>
      </v-btn>
    </v-app-bar>
    <v-content>
      <!-- auth処理時のアラートバー -->
      <SuccessLogin />
      <FailedLogin />
      <SuccessLogout />
      <v-container fill-height>
        <!-- 各ページの挿入 -->
        <nuxt />
      </v-container>
    </v-content>
    <!-- 右のナビゲーション内部 -->
    <v-navigation-drawer v-model="rightDrawer" right temporary fixed>
      <v-list>
        <!-- 右リスト内 ホームボタン -->
        <v-list-item nuxt to="/" exact>
          <v-list-item-action>
            <v-icon>mdi-apps</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ホーム</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- 右リスト内お気に入りボタン（ログイン時のみ表示） -->
        <v-list-item
          v-if="isLoggedIn"
          nuxt
          :to="{ name: 'favorites', params: { user_id: user.user.id } }"
          exact
        >
          <v-list-item-action>
            <v-icon>fas fa-heart</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>お気に入り</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- 右リスト内 自分の投稿ボタン（ログイン時のみ表示） -->
        <v-list-item
          v-if="isLoggedIn"
          nuxt
          :to="{ name: 'my_topics', params: { user_id: user.user.id } }"
          exact
        >
          <v-list-item-action>
            <v-icon>fas fa-camera</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>自分の投稿</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- 右リスト内 current_areaボタン -->
        <v-list-item nuxt to="/current_area" exact>
          <v-list-item-action>
            <v-icon>fas fa-search-location</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>現在地周辺のお店を探す</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- 右リスト内 みんなの写真ボタン -->
        <v-list-item nuxt to="/topics" exact >
          <v-list-item-action>
            <v-icon>fas fa-camera-retro</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>みんなの写真</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- 右リスト内 ログインボタン -->
        <v-list-item nuxt to="/login" exact v-if="!isLoggedIn">
          <v-list-item-action>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>LOGIN</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- 右リスト内 サインアップボタン -->
        <v-list-item nuxt to="/sign_up" exact v-if="!isLoggedIn">
          <v-list-item-action>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>SIGNUP</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

      </v-list>
    </v-navigation-drawer>
    <!-- フッター -->
    <v-footer :fixed="fixed" app>
      <span>&copy; 2019</span>
    </v-footer>
  </v-app>
</template>

<script>
import LoginBtn from "../components/LoginBtn.vue"
import SignupBtn from "../components/SignupBtn.vue"
import SuccessLogin from "../components/SuccessLogin.vue"
import FailedLogin from "../components/FailedLogin.vue"
import SuccessLogout from "../components/SuccessLogout.vue"

export default {
  components: {
    LoginBtn,
    SignupBtn,
    SuccessLogin,
    FailedLogin,
    SuccessLogout
  },
  data() {
    return {
      fixed: false,
      rightDrawer: false,
      title: "俺達のハンバーガー！"
    }
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
    logout() {
      this.$store.dispatch("auth/logout")
    }
  }
}
</script>
