<template>
  <nav id="nav-bar" class="navbar is-dark" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <div class="navbar-item">
        <i class="fas fa-tint fa-4x has-text-info"></i>
        <span class="is-size-3">Water Me</span>
      </div>

      <a role="button" @click="expandMenu" class="navbar-burger" aria-label="menu" aria-expanded="false" :class="{ 'is-active': activator }">
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>

    <div class="navbar-menu" id="navMenu" :class="{ 'is-active': activator }">
      <div class="navbar-end">
        <a v-if="user"class="navbar-item" href="/users/sign_out" data-method="delete">
          Sign out
        </a>
        <a v-else class="navbar-item" href="/users/sign_in">
          Sign in
        </a>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      activator: false,
    }
  },
  props: ["user"],
  methods: {
    expandMenu() {
      this.activator = !this.activator
      return this.activator
    }
  }
}

</script>

<style scoped>

</style>
