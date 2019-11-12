<template>
    <!-- <p>現在地：{{address}}</p> -->
    <!-- <p>lat：{{ latitude }}</p>
    <p>lng：{{ longitude }}</p>
    <br>
    <p>店：{{ shop }}</p>
    <hr> -->
  <v-layout>
    <v-flex xs12 sm6 offset-sm3>
      <v-btn round color="primary" dark @click="getLocation">現在地付近の店を探す</v-btn>
      <v-card>
        <v-img
          class="white--text"
          height="200px"
          src="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
        >
          <v-container fill-height fluid>
            <v-layout fill-height>
              <v-flex xs12 align-end flexbox>
                <span class="headline">Top 10 Australian beaches</span>
              </v-flex>
            </v-layout>
          </v-container>
        </v-img>
        <v-card-title>
          <div>
            <span class="grey--text">Number 10</span><br>
            <span>Whitehaven Beach</span><br>
            <span>Whitsunday Island, Whitsunday Islands</span>
          </div>
        </v-card-title>
        <v-card-actions>
          <v-btn flat color="orange">Share</v-btn>
          <v-btn flat color="orange">Explore</v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
  export default{
    data () {
      return {
        latitude: 0,
        longitude: 0,
        address: "",
        shop: ""
      }
    },
    methods: {
      // 現在地の緯度、経度の取得
      getLocation () {
        if (process.client) {
          if (!navigator.geolocation) {
            alert('現在地情報を取得できませんでした。お使いのブラウザでは現在地情報を利用できない可能性があります。')
            return
          }
          const options = {
            enableHighAccuracy: true,
            timeout: 5000,
            maximumAge: 0
          }
          navigator.geolocation.getCurrentPosition(this.success, this.error, options)
        }
      },
      // 位置情報取得：成功時の処理
      success (position) {
        this.latitude = position.coords.latitude
        this.longitude = position.coords.longitude
        console.log(this.latitude);
        console.log(this.longitude);
        this.getShops();
        this.initMap();
        },
      // 位置情報取得：失敗時の処理
      error (error) {
        switch (error.code) {
          case 1: //PERMISSION_DENIED
            alert('位置情報の利用が許可されていません')
            break
        case 2: //POSITION_UNAVAILABLE
            alert('現在位置が取得できませんでした')
            break
        case 3: //TIMEOUT
            alert('タイムアウトになりました')
            break
          default:
            alert('現在位置が取得できませんでした')
            break
        }
      },
      // Google map APIで住所を取得（geoLocation後に作動）
      initMap() {
        var geocoder = new google.maps.Geocoder();
        var latlng = {lat: this.latitude, lng: this.longitude};
        geocoder.geocode({'location': latlng}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
          console.log(results);
          this.address = results[0].formatted_address;
          console.log(this.address);
        }
        else {
        alert("エラー" + status);
        };
        });
      },
      // ホットペッパーAPIから周辺のデータを取得
      getShops() {
        this.$axios.$get("/api",
          {
            params: {
              'key': '2d1fe3e2b56db033',
              'lat': '34.67',
              'lng': '135.52',
              'range': '5',
              'order': '4',
              'format': 'json'
            },
            headers: {
              'Access-Control-Allow-Origin': '*'
            }
          })
        .then(res => {
          console.log(res)
          this.shop = res.results.shop
        });
      }
    }
  }
</script>
