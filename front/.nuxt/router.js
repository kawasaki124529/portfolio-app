import Vue from 'vue'
import Router from 'vue-router'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _1bbad8e0 = () => interopDefault(import('../pages/inspire.vue' /* webpackChunkName: "pages/inspire" */))
const _490e6182 = () => interopDefault(import('../pages/signup.vue' /* webpackChunkName: "pages/signup" */))
const _4e550fc0 = () => interopDefault(import('../pages/signup2.vue' /* webpackChunkName: "pages/signup2" */))
const _7f799735 = () => interopDefault(import('../pages/user.vue' /* webpackChunkName: "pages/user" */))
const _2dfb1658 = () => interopDefault(import('../pages/index.vue' /* webpackChunkName: "pages/index" */))

Vue.use(Router)

export const routerOptions = {
  mode: 'history',
  base: decodeURI('/'),
  linkActiveClass: 'nuxt-link-active',
  linkExactActiveClass: 'nuxt-link-exact-active',
  scrollBehavior,

  routes: [{
    path: "/inspire",
    component: _1bbad8e0,
    name: "inspire"
  }, {
    path: "/signup",
    component: _490e6182,
    name: "signup"
  }, {
    path: "/signup2",
    component: _4e550fc0,
    name: "signup2"
  }, {
    path: "/user",
    component: _7f799735,
    name: "user"
  }, {
    path: "/",
    component: _2dfb1658,
    name: "index"
  }],

  fallback: false
}

export function createRouter () {
  return new Router(routerOptions)
}
