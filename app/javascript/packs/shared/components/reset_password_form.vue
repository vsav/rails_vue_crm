<template lang="pug">
  q-dialog(ref="resetPasswordDialog" persistent)
    q-card(class="q-dialog-plugin")
      q-card-section
        q-form(
          ref="resetPasswordForm"
          class="form q-gutter-md"
        )
          q-input(
            outlined
            v-model='profile.password'
            label="New Password *"
            hint='Minimum 5 symbols'
            :type="isPwd ? 'password' : 'text'"
            lazy-rules="ondemand"
            :rules="validationRules.password")
            template(v-slot:append)
              q-icon.cursor-pointer(
                :name="isPwd ? 'visibility_off' : 'visibility'"
                @click='isPwd = !isPwd')
          q-input(
            outlined
            v-model='profile.password_confirmation'
            label="Confirm Password *"
            hint='Re-enter your password'
            :type="isPwd ? 'password' : 'text'"
            :rules="[v => v === profile.password || 'Password didnt match']"
          )
            template(v-slot:append)
              q-icon.cursor-pointer(
                :name="isPwd ? 'visibility_off' : 'visibility'"
                @click='isPwd = !isPwd')
      q-card-actions
        q-btn(type="submit" color="primary" @click="validate()") Update Password
        q-btn(@click.prevent="hide()" label="Cancel" class="q-ma-md")
</template>

<script>
import { validationRules } from '../utils/validations'

export default {
  name: 'staffResetPasswordForm',
  props: {
    profile: Object
  },
  data: function () {
    return {
      loading: false,
      errors: [],
      isPwd: true,
      validationRules
    }
  },
  methods: {
    updatePassword (profile) {
      this.loading = true
      this.$api.update_password(profile)
        .catch((error) => { this.errors.updatePassword = error })
        .finally(() => {
          this.loading = false
          this.hide()
        })
    },
    clearForm () {
      this.profile.password = ''
      this.profile.password_confirmation = ''
    },
    validate () {
      this.$refs.resetPasswordForm.validate()
        .then((response) => {
          if (response === true) {
            this.updatePassword(this.profile)
            this.clearForm()
          }
        })
    },
    show () {
      this.$refs.resetPasswordDialog.show()
    },
    hide () {
      this.$refs.resetPasswordDialog.hide()
    }
  }
}
</script>

<style lang="sass" scoped>
</style>
