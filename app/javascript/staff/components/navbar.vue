<template lang="pug">
  nav(class="navbar")
    .navbar-container
      a(href="/staffs", class="home-link")
        img(src="../../assets/images/s-logo.svg", class="navbar-logo")
      span(v-if="loading") {{ loadingMessage }}
      span(v-else-if="error") "Something went wrong..."
      span(v-else) {{ navbarHeader }}
      ul(class="navbar-links")
        li(class="navbar-item profile")
          a(href="/staffs/profile") {{ profile.email }}
        li(class="navbar-item")
          a(href="/staffs/sign_out" data-method="delete") Sign out
</template>

<script>
  export default {
    name: 'Navbar',
    data: function() {
      return {
        loading: false,
        error: false,
        profile: {},
        loadingMessage: "Loading...",
        navbarHeader: "STAFF",
      }
    },
    created() {
      this.getStaffProfile()
    },
    methods: {
      getStaffProfile() {
        this.loading = true
        this.$api.profile()
            .then(({data}) => {
              this.profile = data
            })
            .catch(() => this.error = true)
            .finally(() => this.loading = false)
      }
    },
  }
</script>

<style lang="sass" scoped>
  *
    box-sizing: border-box
    margin: 0
    padding: 0

  .navbar
    background-color: #777
    left: 0
    right: 0
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15)

  .navbar-container
    display: flex
    justify-content: space-between
    height: 100%
    align-items: center
    max-width: 100vw
    padding-left: 1.4rem
    padding-right: 1.4rem
    margin-left: auto
    margin-right: auto

  .navbar-logo
    width: 64px

  .navbar-links
    display: flex
    justify-content: space-around
    align-items: center

  .navbar-item
    padding: 1em
    list-style: none
    color: white

  .navbar-item a
    text-decoration: none

  .profile a
    color: white
</style>
