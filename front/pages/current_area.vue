<template>
  <div>
    <button @click="getLocation">
      現在地付近の店を探す
    </button>
    <button @click="getShops">
      hotpepper
    </button>
    <button @click="fetchSomething">
      fetch
    </button>
  </div>
</template>

<script>
  export default{
    data () {
      return {
        latitude: 0,
        longitude: 0,
        adress: ""
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
      initMap() {
        // Google map APIで住所を取得（緯度経度取得後に作動）
        var geocoder = new google.maps.Geocoder();
        var latlng = {lat: this.latitude, lng: this.longitude};
        geocoder.geocode({'location': latlng}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          this.adress = results[0].formatted_address;
          console.log(this.adress);
        }
        else {
        alert("エラー" + status);
        }
        });
      },
      getShops() {
        this.$axios.get(
          '/api',
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
          }
        )
        .then(response => {
          console.log(response)
        })
      },
      async fetchSomething() {
        const ip = await this.$axios.$get("/api",
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
          });
        console.log(ip);
      }
    }
  }
</script>
