<template>
  <nav class="navbar is-white" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <div class="navbar-item">Avocado</div>
      <div class="navbar-burger" data-target="navMenu">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div><!-- navbar-brand END -->
    <div class="navbar-menu" id="navMenu">
      <div class="navbar-end">
        <nuxt-link to="/" class="navbar-item">トップ</nuxt-link>
        <nuxt-link to="/about" class="navbar-item">Avocadoとは？</nuxt-link>
        <nuxt-link to="/contact" class="navbar-item">お問い合わせ</nuxt-link>
      </div>
    </div><!-- navbar-menu END -->
  </nav>
</template>