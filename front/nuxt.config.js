require('dotenv').config()

import colors from 'vuetify/es5/util/colors'

export default {
  mode: 'universal',
  /*
  ** Headers of the page
  */
  head: {
    titleTemplate: '%s - ' + process.env.npm_package_name,
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { rel: "stylesheet", href:"https://use.fontawesome.com/releases/v5.6.1/css/all.css"}
    ],
    // google maps apiのソースファイル
    script: [
      { src: 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAoKtlpsxU9X_HYywM7dysT4w2dSoAalyw'}
    ]
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    '~/assets/css/main.css'
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    { src: '~/plugins/axios.js'},
    { src: '~/plugins/storeStorage.js', ssr: false },
    { src: '~/plugins/cookieStorage.js' },
    { src: '~/plugins/vee-validate.js'}
  ],
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
    '@nuxtjs/vuetify',
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/pwa',
    '@nuxtjs/dotenv',
    '@nuxtjs/proxy',
    'nuxt-webfontloader'
  ],
  webfontloader: {
    google: {
      families: ['Sawarabi Gothic']
    }
  },
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: { 
  },
  proxy: {
    '/api': { target: 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/',
              pathRewrite: { '^/api' : '/'}
            },
  },
  /*
  ** vuetify module configuration
  ** https://github.com/nuxt-community/vuetify-module
  */
  vuetify: {
    theme: {
      dark: false,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3
        }
      }
    }
  },
  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    transpile: [
      'vuetify/lib',
      "vee-validate/dist/rules"
    ],
    extend (config, ctx) {
    }
  }
}
