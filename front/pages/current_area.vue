<template>
  <v-layout>
    <v-flex xs12 sm6 offset-sm3>
      <div class="text-center">
        <v-select
          v-model="keyword"
          :items="[
            'ハンバーガー',
            '居酒屋',
            'ダイニングバー',
            '創作料理',
            '和食',
            '洋食',
            'イタリアン・フレンチ',
            '中華',
            '焼肉・ホルモン',
            '韓国料理',
            'アジア・エスニック料理',
            '各国料理',
            'カラオケ・パーティ',
            'バー・カクテル',
            'ラーメン',
            'お好み焼き',
            'カフェ・スイーツ',
            'その他グルメ'
          ]"
          label="ジャンルから選ぶ"
        />
        <v-btn rounded color="primary" dark @click="getLocation">
          現在地付近の店を探す
        </v-btn>
        <p>半径３km圏内 おすすめ順</p>
        <!-- 検索結果：現在地情報 -->
        <v-content v-show="latitude !== 0">
          <h4>現在地</h4>
          <p>緯度：{{ latitude }}, 経度：{{ longitude }}</p>
          <p id="current_address" />
          <br >
          <p>検索結果：{{ length }}件</p>
        </v-content>
        <!-- 検索結果０件の場合 -->
        <v-alert v-show="alert" type="warning" transition="fade-transition">
          近くに該当する店が見つかりませんでした
        </v-alert>
      </div>
      <br >
      <!-- 検索結果：店舗情報 -->
      <v-content v-for="shop in shops" :key="shop.id">
        <v-card class="grey lighten-3 ma-1">
          <v-img class="white--text" width="100%" :src="shop.photo.pc.l">
            <v-container fill-height fluid>
              <v-layout fill-height>
                <v-flex xs12 align-end flexbox>
                  <span
                    class="headline"
                    style="background-color:rgba(21,21,75,0.5);"
                    >{{ shop.catch }}</span
                  >
                </v-flex>
              </v-layout>
            </v-container>
            <template v-slot:placeholder>
              <v-layout fill-height align-center justify-center ma-0>
                <v-progress-circular indeterminate color="grey lighten-5" />
              </v-layout>
            </template>
          </v-img>
          <v-card-title>
            <div>
              <span class="brown--text">{{ shop.name }}</span
              ><br />
              <span class="grey--text">・平均予算：</span><br >
              <span> {{ shop.budget.average }}</span
              ><br />
              <span class="grey--text">・アクセス：</span><br >
              <span>{{ shop.mobile_access }}</span
              ><br />
              <span class="grey--text">・営業時間：</span><br >
              <span>{{ shop.open }}</span>
            </div>
          </v-card-title>
          <v-card-actions>
            <v-btn text color="orange" :href="shop.urls.pc" target="newtab">
              URL(HotPepper)
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-content>
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  data() {
    return {
      latitude: 0,
      longitude: 0,
      shops: "",
      keyword: "ハンバーガー",
      alert: false,
      length: ""
    }
  },
  methods: {
    // 現在地の緯度、経度の取得
    getLocation() {
      if (process.client) {
        if (!navigator.geolocation) {
          alert(
            "現在地情報を取得できませんでした。お使いのブラウザでは現在地情報を利用できない可能性があります。"
          )
          return
        }
        const options = {
          enableHighAccuracy: true,
          timeout: 5000,
          maximumAge: 0
        }
        navigator.geolocation.getCurrentPosition(
          this.success,
          this.error,
          options
        )
      }
    },
    // 位置情報取得：成功時の処理
    success(position) {
      this.latitude = position.coords.latitude
      this.longitude = position.coords.longitude
      console.log(this.latitude)
      console.log(this.longitude)
      this.getShops()
      this.initMap()
      if (this.alert === true) {
        this.alert = false
      }
    },
    // 位置情報取得：失敗時の処理
    error(error) {
      switch (error.code) {
        case 1: //PERMISSION_DENIED
          alert("位置情報の利用が許可されていません")
          break
        case 2: //POSITION_UNAVAILABLE
          alert("現在位置が取得できませんでした")
          break
        case 3: //TIMEOUT
          alert("タイムアウトになりました")
          break
        default:
          alert("現在位置が取得できませんでした")
          break
      }
    },
    // Google map APIで住所を取得（geoLocation後に作動）
    initMap() {
      var geocoder = new google.maps.Geocoder()
      var latlng = { lat: this.latitude, lng: this.longitude }
      geocoder.geocode({ location: latlng }, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
          console.log(results)
          var elm = document.getElementById("current_address")
          elm.textContent = results[1].formatted_address
        } else {
          alert("エラー" + status)
        }
      })
    },
    // ホットペッパーAPIから周辺のデータを取得
    getShops() {
      this.$axios
        .$get(process.env.shopApi, {
          params: {
            key: "2d1fe3e2b56db033",
            lat: this.latitude,
            lng: this.longitude,
            keyword: this.keyword,
            range: "5",
            order: "4",
            format: "json"
          },
          headers: {
            "Access-Control-Allow-Origin": "*"
          }
        })
        .then(res => {
          console.log(res.results.shop)
          this.shops = res.results.shop
          this.length = res.results.shop.length
          if (res.results.shop.length === 0) {
            this.alert = true
          }
        })
    }
  }
}
</script>
