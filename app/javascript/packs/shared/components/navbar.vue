<template lang="pug">
  nav(class="navbar")
    q-header(elevated class="bg-primary text-white")
      q-toolbar
        q-toolbar-title
          router-link(to="/")
            q-avatar
              img(src="../../../assets/images/s-logo.svg")
          | CRM

        q-btn-dropdown(dense flat round dropdown-icon="menu")
          q-list
            q-item
              q-item-section
                q-btn(flat icon="account_circle" class="q-mr-xs" align="left" :ripple="false") {{ profile.email }}
            q-item
              q-item-section
                q-btn(flat icon="vpn_key" @click="change_password" align="left" :ripple="false") Change Password
            q-item
              q-item-section
                q-btn(flat icon="highlight_off" @click="sign_out" align="left" :ripple="false") Sign out
</template>
<script>
import resetPasswordForm from './reset_password_form'

export default {
  name: 'Navbar',
  data: function () {
    return {
      errors: [],
      profile: {}
    }
  },
  created () {
    this.getProfile()
  },
  methods: {
    getProfile () {
      this.$api.profile()
        .then(({ data }) => {
          this.profile = data
        })
        .catch((error) => this.errors.push(error))
    },
    sign_out () {
      this.$api.sign_out()
        .then(() => location.replace('/'))
    },
    change_password () {
      this.$q.dialog({
        component: resetPasswordForm,
        parent: this,
        profile: this.profile
      })
    }
  }
}
</script>

<style lang="sass" scoped>
</style>
