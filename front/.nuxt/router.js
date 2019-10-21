import Vue from 'vue'
import Router from 'vue-router'
import { interopDefault } from './utils'
import scrollBehavior from './router.scrollBehavior.js'

const _0e433b93 = () => interopDefault(import('../pages/about.vue' /* webpackChunkName: "pages/about" */))
const _34780b0c = () => interopDefault(import('../pages/signin.vue' /* webpackChunkName: "pages/signin" */))
const _2dfb1658 = () => interopDefault(import('../pages/index.vue' /* webpackChunkName: "pages/index" */))

Vue.use(Router)

export const routerOptions = {
  mode: 'history',
  base: decodeURI('/'),
  linkActiveClass: 'nuxt-link-active',
  linkExactActiveClass: 'nuxt-link-exact-active',
  scrollBehavior,

  routes: [{
    path: "/about",
    component: _0e433b93,
    name: "about"
  }, {
    path: "/signin",
    component: _34780b0c,
    name: "signin"
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
