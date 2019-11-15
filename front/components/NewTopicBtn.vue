<template>
  <v-layout row justify-center>
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <v-btn
          color="cyan accent-2"
          dark
          absolute
          bottom
          right
          fab
          v-on="on"
        >
          <v-icon>fas fa-plus</v-icon>
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">感想を投稿する</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <v-text-field label="店舗名*" v-model="name" required></v-text-field>
              </v-flex>
              <!-- カレンダー欄 -->
                <v-layout row wrap>
                  <v-flex xs12 >
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
                        <v-text-field
                          v-model="date"
                          label="訪問日*"
                          prepend-icon="far fa-calendar-alt"
                          readonly
                          v-on="on"
                          required
                        ></v-text-field>
                      </template>
                      <v-date-picker v-model="date" no-title scrollable>
                        <v-spacer></v-spacer>
                        <v-btn text color="primary" @click="menu = false">Cancel</v-btn>
                        <v-btn text color="primary" @click="$refs.menu.save(date)">OK</v-btn>
                      </v-date-picker>
                    </v-menu>
                  </v-flex>
                  <v-spacer></v-spacer>
                </v-layout>
              <!-- メニュー欄 -->
              <v-flex xs12 >
                <v-text-field label="注文したメニュー*" 
                              hint="複数可、書き込み方自由" 
                              required
                              v-model="meals"
                ></v-text-field>
              </v-flex>
              <!-- 予算欄 -->
              <v-flex xs12>
                <v-select
                  :items="['￥0-1000', '￥1000-1500', '￥1500-3000', '￥3000+']"
                  label="一人当たり予算*"
                  v-model="price"
                  required
                ></v-select>
              </v-flex>
              <!-- 感想欄 -->
              <v-flex xs12>
                <v-textarea
                  label="感想*"
                  v-model="review"
                  persistent-hint
                  required
                ></v-textarea>
              </v-flex>
              <!-- レーティング欄 -->
              <v-flex xs12>
                <v-card-actions class="pa-3">
                  オススメ度*
                  <v-spacer></v-spacer>
                  <span class="black--text text--lighten-2 caption mr-2">
                    ({{ rating }})
                  </span>
                  <v-rating
                    v-model="rating"
                    background-color="gray"
                    color="yellow accent-4"
                    dense
                    hover
                    size="22"
                  ></v-rating>
                </v-card-actions>
                <hr>
              </v-flex>
              <!-- 画像選択欄 -->
              <v-flex xs12 >
                <v-text-field
                  label="画像アップロード*"
                  @click="pickFile"
                  v-model="imageName"
                  prepend-icon="far fa-file"
                ></v-text-field>
                <input
                  type="file"
                  style="display: none"
                  ref="image"
                  accept="image/*"
                  @change="onFilePicked"
                />
              </v-flex>
            </v-layout>
          </v-container>
          <!-- 記載事項 -->
          <small>*必須</small>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">閉じる</v-btn>
          <v-btn color="blue darken-1" text @click="upload">投稿</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
  data () {
    return {
      name: "",
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
    }
  },
  methods: {
    pickFile() {
      this.$refs.image.click();
    },
    onFilePicked(e) {
      const files = e.target.files;
      if (files[0] !== undefined) {
        this.imageName = files[0].name;
        if (this.imageName.lastIndexOf(".") <= 0) {
          return;
        }
        const fr = new FileReader();
        fr.readAsDataURL(files[0]);
        fr.addEventListener("load", () => {
          this.imageUrl = fr.result;
          this.imageFile = files[0]; // this is an image file that can be sent to server...
        });
      } else {
        this.imageName = "";
        this.imageFile = "";
        this.imageUrl = "";
      }
    },
    // サーバーへアップロード処理
    upload() {
      let formData = new FormData
      formData.append('name', this.name)
      formData.append('date', this.date)
      formData.append('meals', this.meals)
      formData.append('price', this.price)
      formData.append('review', this.review)
      formData.append('rating', this.rating)
      formData.append('image_file', this.imageFile)
      for( let i = 0; i < this.images.length; i++) {
        let image = this.images[i];
        formData.append('images[]', image);
      }
      this.$axios.$post('http://localhost:4000/api/v1/products',
      formData,
      {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      }).then(response => {
        console.log(reponse.data.status);
      }).catch(error => {
        console.log(error);
      })
    }
  },
}  
</script>