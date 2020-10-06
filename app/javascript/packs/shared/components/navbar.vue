<template lang="pug">
  nav(class="navbar")
    q-header(elevated class="bg-primary text-white")
      q-toolbar
        q-toolbar-title
          q-avatar
            img(src="../../../assets/images/s-logo.svg")
          | CRM
        q-btn(dense flat round icon="menu" @click="right = !right")

    q-drawer(show-if-above v-model="right" side="right" bordered)
      .navbar-links
        q-btn(flat icon="account_circle" class="q-mr-xs") {{ profile.email }}
        q-btn(flat icon="highlight_off" @click="sign_out" ) Sign out
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
      this.getProfile()
    },
    methods: {
      getProfile() {
        this.$api.profile()
            .then(({data}) => {
              this.profile = data
            })
            .catch((error) => this.errors.push(error))
      },
      sign_out() {
        this.$api.sign_out()
            .then(() => location.replace('/'))
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
    color: #1976D2
</style>
