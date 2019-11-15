import Vue from 'vue'
import Router from 'vue-router'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _f6d33606 = () => interopDefault(import('../pages/current_area.vue' /* webpackChunkName: "pages/current_area" */))
const _671eb956 = () => interopDefault(import('../pages/new_topic.vue' /* webpackChunkName: "pages/new_topic" */))
const _34780b0c = () => interopDefault(import('../pages/signin.vue' /* webpackChunkName: "pages/signin" */))
const _490e6182 = () => interopDefault(import('../pages/signup.vue' /* webpackChunkName: "pages/signup" */))
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
    path: "/current_area",
    component: _f6d33606,
    name: "current_area"
  }, {
    path: "/new_topic",
    component: _671eb956,
    name: "new_topic"
  }, {
    path: "/signin",
    component: _34780b0c,
    name: "signin"
  }, {
    path: "/signup",
    component: _490e6182,
    name: "signup"
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
