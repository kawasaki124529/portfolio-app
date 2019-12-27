<template>
  <v-layout row justify-center>
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <!-- ボタン部分 -->
        <v-btn
          color="brown darken-3"
          outlined
          v-on="on"
        >
          感想を投稿
        </v-btn>
      </template>
      <!-- モーダル部分 -->
      <v-card>
        <validation-observer v-slot="{ handleSubmit }">
          <v-card-title>
            <span class="headline">感想を投稿する</span>
          </v-card-title>
          <v-card-text>
            <v-container grid-list-md>
              <v-layout wrap>
                <!-- 店舗名欄 -->
                <v-flex xs12>
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="店舗名"
                    rules="required"
                  >
                    <v-text-field
                      v-model="shopName"
                      label="店舗名*"
                      :error-messages="errors[0]"
                      required
                    />
                  </ValidationProvider>
                </v-flex>
                <!-- カレンダー欄 -->
                <v-layout row wrap>
                  <v-flex xs12>
                    <v-menu
                      ref="menu"
                      v-model="menu"
                      :close-on-content-click="false"
                      :nudge-right="40"
                      :return-value.sync="date"
                      transition="scale-transition"
                      offset-y
                      min-width="290px"
                    >
                      <template v-slot:activator="{ on }">
                        <ValidationProvider
                          v-slot="{ errors }"
                          name="訪問日"
                          rules="required"
                        >
                          <v-text-field
                            v-model="date"
                            label="訪問日*"
                            prepend-icon="far fa-calendar-alt"
                            readonly
                            required
                            :error-messages="errors[0]"
                            v-on="on"
                          />
                        </ValidationProvider>
                      </template>
                      <v-date-picker v-model="date" no-title scrollable>
                        <v-spacer />
                        <v-btn text color="primary" @click="menu = false">
                          Cancel
                        </v-btn>
                        <v-btn
                          text
                          color="primary"
                          @click="$refs.menu.save(date)"
                        >
                          OK
                        </v-btn>
                      </v-date-picker>
                    </v-menu>
                  </v-flex>
                  <v-spacer />
                </v-layout>
                <!-- メニュー欄 -->
                <v-flex xs12>
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="注文したメニュー"
                    rules="required"
                  >
                    <v-text-field
                      v-model="meals"
                      label="注文したメニュー*"
                      hint="複数可、書き込み方自由"
                      :error-messages="errors[0]"
                      required
                    />
                  </ValidationProvider>
                </v-flex>
                <!-- 予算欄 -->
                <v-flex xs12>
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="一人当たり予算"
                    rules="required"
                  >
                    <v-select
                      v-model="price"
                      :items="[
                        '￥0-1000',
                        '￥1000-1500',
                        '￥1500-3000',
                        '￥3000+'
                      ]"
                      label="一人当たり予算*"
                      :error-messages="errors[0]"
                      required
                    />
                  </ValidationProvider>
                </v-flex>
                <!-- 感想欄 -->
                <v-flex xs12>
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="感想"
                    rules="required"
                  >
                    <v-textarea
                      v-model="review"
                      label="感想*"
                      persistent-hint
                      :error-messages="errors[0]"
                      required
                    />
                  </ValidationProvider>
                </v-flex>
                <!-- レーティング欄 -->
                <v-flex xs12>
                  <v-card-actions class="pa-3">
                    オススメ度*
                    <v-spacer />
                    <span class="black--text text--lighten-2 caption mr-2">
                      ({{ rating }})
                    </span>
                    <ValidationProvider
                      v-slot="{ errors }"
                      name="レーティング"
                      rules="required"
                    >
                      <v-rating
                        v-model="rating"
                        background-color="gray"
                        color="yellow accent-4"
                        dense
                        hover
                        size="22"
                        :error-messages="errors[0]"
                      />
                    </ValidationProvider>
                  </v-card-actions>
                  <hr>
                </v-flex>
                <!-- 画像選択欄 -->
                <v-flex xs12>
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="画像"
                    rules="required"
                  >
                    <v-text-field
                      v-model="imageName"
                      label="画像アップロード*"
                      prepend-icon="far fa-file"
                      :error-messages="errors[0]"
                      @click="pickFile"
                    />
                    <input
                      ref="image"
                      type="file"
                      style="display: none"
                      accept="image/*"
                      @change="onFilePicked"
                    />
                  </ValidationProvider>
                </v-flex>
              </v-layout>
            </v-container>
            <!-- 記載事項 -->
            <small>*全項目必須</small>
          </v-card-text>
          <v-card-actions>
            <v-spacer />
            <v-btn color="blue darken-1" text @click="dialog = false">
              閉じる
            </v-btn>
            <v-scale-transition>
              <v-btn
                v-show="!loading"
                color="blue darken-1"
                text
                @click.prevent="handleSubmit(upload)"
              >
                投稿
              </v-btn>
            </v-scale-transition>
            <!-- 送信時のグルグルloading -->
            <v-progress-circular
              v-show="loading"
              :indeterminate="loading"
              color="green"
            />
          </v-card-actions>
        </validation-observer>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
  data() {
    return {
      shopName: "",
      date: new Date().toISOString().substr(0, 10),
      menu: false,
      modal: false,
      menu2: false,
      meals: "",
      price: "",
      review: "",
      rating: 3.0,
      imageName: "",
      imageUrl: "",
      imageFile: "",
      dialog: false,
      TopicsData: "",
      loading: false
    }
  },
  computed: {
    user_id() {
      return this.$store.state.auth.User.user.id
    }
  },
  methods: {
    // 選択された画像ファイルの処理
    pickFile() {
      this.$refs.image.click()
    },
    onFilePicked(e) {
      const files = e.target.files
      if (files[0] !== undefined) {
        this.imageName = files[0].name
        if (this.imageName.lastIndexOf(".") <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(files[0])
        fr.addEventListener("load", () => {
          this.imageUrl = fr.result
          this.imageFile = files[0] // APIサーバーへ送るファイル
        })
      } else {
        this.imageName = ""
        this.imageFile = ""
        this.imageUrl = ""
      }
    },
    // railsのcreateアクションへアップロード処理
    upload() {
      this.loading = true
      let formData = new FormData()
      formData.append("user_id", this.user_id)
      formData.append("shop_name", this.shopName)
      formData.append("date", this.date)
      formData.append("meals", this.meals)
      formData.append("price", this.price)
      formData.append("review", this.review)
      formData.append("rating", this.rating)
      formData.append("image", this.imageFile)
      this.$axios
        .post(process.env.apiBaseUrl + "/api/topics", formData, {
          headers: {
            "Content-Type": "multipart/form-data"
          }
        })
        .then(res => {
          console.log(res)
          // アップロード成功時の処理
          if (res.status === 200) {
            this.$router.go({
              path: this.$router.currentRoute.path,
              force: true
            })
            this.dialog = false
          }
          // エラー時の処理
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>
