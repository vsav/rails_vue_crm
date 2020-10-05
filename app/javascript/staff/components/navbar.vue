<template lang="pug">
  nav(class="navbar")
    q-header(elevated class="bg-primary text-white")
      q-toolbar
        q-toolbar-title
          q-avatar
            img(src="../../assets/images/s-logo.svg")
          CRM
        q-btn(dense flat round icon="menu" @click="right = !right")

    q-drawer(show-if-above v-model="right" side="right" bordered)
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
        errors: [],
        right: false,
        profile: {},
      }
    },
    created() {
      this.getStaffProfile()
    },
    methods: {
      getStaffProfile() {
        this.$api.profile()
            .then(({data}) => {
              this.profile = data
            })
            .catch((error) => this.errors.push(error))
      }
    }
  }
</script>

<style lang="sass" scoped>
  .navbar-logo
    width: 64px

  .navbar-links
    display: flex
    justify-content: space-around
    align-items: center

  .navbar-item
    list-style: none

  .navbar-item a
    text-decoration: none

  .profile a
    color: #1976D2
</style>
