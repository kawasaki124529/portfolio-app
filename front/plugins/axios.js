export default function({ $axios, redirect }) {
  // $axios.setToken('access_token')
  
  $axios.onResponse(config => {
      $axios.setHeader('Access-Control-Allow-Origin', '*' /** 許可するドメイン http://exsample.com あるいは通すだけなら '*' **/)
    })
  }