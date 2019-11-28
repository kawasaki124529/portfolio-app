import Vue from 'vue'
import { ValidationProvider, ValidationObserver, localize, extend } from 'vee-validate' // 使用する機能
import ja from 'vee-validate/dist/locale/ja.json' // エラーメッセージの日本語化用
import { required, max, min, email } from 'vee-validate/dist/rules' // 使用するバリデーションルール

// VeeValidateがデフォルトで用意している各ルールを使用するよう指定
extend('required', required) // 必須項目のバリデーション
extend('email', email) // emailのバリデーション
extend('max', max) // 最大文字数のバリデーション
extend('min', min) // 最小文字数のバリデーション

Vue.component('ValidationProvider', ValidationProvider)
Vue.component('ValidationObserver', ValidationObserver)
localize('ja', ja)