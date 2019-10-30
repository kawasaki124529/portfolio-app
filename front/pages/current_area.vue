<template>
  <div>
    <button @click="getLocation">
      現在地付近
    </button>
  </div>
</template>

<script>
  export default{
    data () {
      return {
        latitude: 0,
        longitude: 0
      }
    },
    methods: {
      getLocation () {
        if (process.client) {
          if (!navigator.geolocation) {
            alert('現在地情報を取得できませんでした。お使いのブラウザでは現在地情報を利用できない可能性があります。')
            return
          }

          const options = {
            enableHighAccuracy: false,
            timeout: 5000,
            maximumAge: 0
          }

          navigator.geolocation.getCurrentPosition(this.success, this.error, options)
        }
      },
      
      // 位置情報取得：成功の処理
      success (position) {
        this.latitude = position.coords.latitude
        this.longitude = position.coords.longitude
        console.log(this.latitude)
        console.log(this.longitude)
      },

      // 位置情報取得：失敗の処理
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
      }
    }
  }
</script>