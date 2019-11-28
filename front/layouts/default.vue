<template>
  <v-app >
    <!-- ヘッダーbar -->
    <v-app-bar
      fixed
      app
      style="background-color:rgba(5,5,5,0.7);"
    >      
      <!-- ヘッダータイトル -->
      <v-toolbar-title 
        class="white--text" 
        nuxt to="/" 
        v-text="title" 
        style="font-family:Sawarabi Gothic"
      />
      <v-btn
        class="white--text"
        text large
        nuxt
        to="/current_area"
      >
        <v-icon>fas fa-search-location fa-xs</v-icon>
        現在地周辺のお店を探す
      </v-btn>
      <v-btn 
        class="white--text"
        text large
        nuxt
        to="/topics"
      >
        TOPIC
      </v-btn>
      <v-spacer/>
      <LoginBtn v-show="!isLoggedIn"></LoginBtn>
      <SignupBtn/>
      <v-btn 
        class="white--text"
        text large
        @click="logout"
        v-show="isLoggedIn"
      >
        LOGOUT
      </v-btn>
      <v-btn
        class="white--text"
        color="blue-grey"
        v-if="isLoggedIn"
        @click.stop="rightDrawer = !rightDrawer"
      >
      {{ user.user.name }}
        <v-icon right >mdi-menu</v-icon>
      </v-btn>
    </v-app-bar>
    <!-- pagesの挿入 -->
    <v-content>
      <!-- auth処理時のアラートバー -->
      <SuccessLogin/>
      <FailedLogin/>
      <SuccessLogout/>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <!-- 右のナビゲーション内部 -->
    <v-navigation-drawer
      v-model="rightDrawer"
      right
      temporary
      fixed
    >
      <v-list>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          :to="item.to"
          router
          exact
        >
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <!-- フッター -->
    <v-footer
      :fixed="fixed"
      app
    >
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
  data () {
    return {
      fixed: false,
      items: [
        {
          icon: 'mdi-apps',
          title: 'Home',
          to: '/'
        },
        {
          icon: 'mdi-chart-bubble',
          title: 'Inspire',
          to: '/inspire'
        }
      ],
      rightDrawer: false,
      title: '俺達のハンバーガー！',
    }
  },
  methods: {
    logout(){
      this.$store.dispatch('auth/logout');
    }
  },
  computed: {
    isLoggedIn(){
      return this.$store.state.auth.isLoggedIn;
    },
    user(){
      return this.$store.state.auth.User
    }
  },
  components:{
    LoginBtn,
    SignupBtn,
    SuccessLogin,
    FailedLogin,
    SuccessLogout
  }
}
</script>
