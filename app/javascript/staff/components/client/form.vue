<template lang="pug">
  q-dialog(ref="clientFormDialog" persistent)
    q-card.q-dialog-plugin
      q-card-section
        q-form.form.q-gutter-md(ref="clientForm")
          q-input(
            outlined
            v-model="client.full_name"
            label="Full Name *"
            hint="Only letters. Minimum 5"
            lazy-rules="ondemand"
            :rules="validationRules.fullName")
          q-input(
            outlined
            v-model="client.phone"
            label="Phone *"
            hint="Only digits"
            lazy-rules="ondemand"
            :error="!phoneUniq"
            :error-message="uniqueness.phone"
            :rules="validationRules.phone"
            @blur="validateUniqueness(client)"
            @input="phoneUniq = true"
            )
          q-input(
            outlined
            v-model="client.email"
            label="Email *"
            hint='Please enter valid email address'
            lazy-rules="ondemand"
            :error="!emailUniq"
            :error-message="uniqueness.email"
            :rules="validationRules.email"
            @blur="validateUniqueness(client)"
            @input="emailUniq = true"
            )
          template(v-if="!edited_client")
            q-input(
              outlined
              v-model='client.password'
              label="Password *"
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
              v-model='client.password_confirmation'
              label="Confirm Password *"
              hint='Re-enter your password'
              :type="isPwd ? 'password' : 'text'"
              :rules="[v => v === client.password || 'Password didnt match']"
            )
              template(v-slot:append)
                q-icon.cursor-pointer(
                  :name="isPwd ? 'visibility_off' : 'visibility'"
                  @click='isPwd = !isPwd')
      q-card-actions
        q-btn(type="submit" color="primary" @click="validate()") {{formAction}}
        q-btn.q-ma-md(@click.prevent="hide()" label="Cancel")
</template>

<script>
import { validationRules } from "utils/validations"

export default {
  name: 'ClientForm',
  props: {
    edited_client: Object
  },
  data: function() {
    return {
      loading: false,
      uniqueness: {},
      errors: [],
      client: {
        full_name: '',
        phone: '',
        email: '',
        password: '',
        password_confirmation: '',
        organizations: []
      },
      isPwd: true,
      phoneUniq: true,
      emailUniq: true,
      validationRules,
      formAction: 'Create Client'
    }
  },
  methods: {
    createClient() {
      this.loading = true
      const client = this.client
      this.$api.clients.create({client})
        .catch((error) => this.errors['create'] = error)
        .finally(() => {
          this.loading = false
          this.clearForm()
        })
    },
    updateClient(client) {
      this.loading = true
      this.$api.clients.update(client)
        .catch((error) => this.errors['update'] = error)
        .finally(() => {
          this.loading = false
          this.hide()
        })
    },

    clearForm() {
      this.client.full_name = ''
      this.client.email = ''
      this.client.phone = ''
      this.client.password = ''
      this.client.password_confirmation = ''
    },
    validate() {
      this.$refs.clientForm.validate()
        .then((response) => {
          if(response === true) {
            this.edited_client? this.updateClient(this.client) : this.createClient()
          }
        })
    },
    validateUniqueness(client) {
      this.$api.clients.validate(client)
        .then(({data}) => {
          if(data.uniqueness.phone) {
            this.uniqueness.phone = data.uniqueness.phone
            this.phoneUniq = false
            }
          else if(data.uniqueness.email) {
            this.uniqueness.email = data.uniqueness.email
            this.emailUniq = false
            }
          else {
            delete this.uniqueness.phone
            delete this.uniqueness.email
            this.phoneUniq = true
            this.emailUniq = true
          }
        })
    },
    show () {
      this.$refs.clientFormDialog.show()
    },
    hide () {
      this.$router.push({name: 'clients'})
      this.$refs.clientFormDialog.hide()
    }
  },
  created() {
    if(this.edited_client) {
      this.client = this.edited_client
      this.formAction = 'Update Client'
    } else {
      this.client = {}
      this.formAction = 'Create Client'
    }
  }
}
</script>

<style lang="sass" scoped>
</style>
