<template lang="pug">
  div(id="dashboard")
    form(ref="createClientForm", id="create-client-form")
      fieldset
        legend Create New Client
        .form-group
          label(for="full-name") Full Name
          input(v-model="client.full_name", id="full-name", @blur="validateName(client.full_name, validations)", placeholder="John Doe")
          br/
          small(v-if="validations.full_name") {{validations.full_name}}
        .form-group
          label(for="phone-number") Phone Number
          input(v-model="client.phone", id="phone-number", @blur="validatePhone(client.phone, validations), validateUniqueness(client, validations)" placeholder="223322")
          br/
          small(v-if="validations.phone") {{validations.phone}}
        .form-group
          label(for="email") Email
          input(v-model="client.email", id="email", type="email", @blur="validateEmail(client.email, validations), validateUniqueness(client, validations)", placeholder="john@domain.com")
          br/
          small(v-if="validations.email") {{validations.email}}
        .form-group
          label(for="password") Password
          input(v-model="client.password", id="password", type="password", @blur="validatePassword(client.password, validations)")
          br/
          small(v-if="validations.password") {{validations.password}}
        .form-group
          label(for="password-confirmation") Password Confirmation
          input(v-model="client.password_confirmation", id="password-confirmation", type="password", @input="validatePasswordConfirmation(client.password, client.password_confirmation, validations)")
          br/
          small(v-if="validations.password_confirmation") {{validations.password_confirmation}}
        button.create-button.button(@click.prevent="createClient()" type="button" :disabled="Object.keys(this.validations).length > 0") Create client

    template(v-if="loading")
      p Loading...
    template(v-else)
      table
        thead Clients List
          tr
            th Id
            th Full Name
            th Phone Number
            th Email
            th Actions
        tbody
          tr(v-for='client in clients' :key='client.id')
            td {{ client.id }}
            td {{ client.full_name }}
            td {{ client.phone }}
            td {{ client.email }}
            td
              button(class="button delete-button" @click.prevent ="deleteClient(client)" type="button") Delete client
</template>

<script>
import { validateName, validateEmail, validatePhone, validatePassword, validatePasswordConfirmation, validateUniqueness } from "../utils/validations"

export default {
  name: 'Dashboard',
  data: function () {
    return {
      loading: false,
      errors: {},
      validations: {},
      clients: [],
      client: {
        full_name: '',
        phone: '',
        email: '',
        password: '',
        password_confirmation: ''
      },
      validateName,
      validateEmail,
      validatePhone,
      validatePassword,
      validatePasswordConfirmation,
      validateUniqueness
    }
  },
  created() {
    this.fetchClients()
  },
  methods: {
    fetchClients() {
      this.loading = true
      this.$api.clients.index()
          .then(({data}) => this.clients = data)
          .catch((error) => this.errors['fetch'] = error)
          .finally(() => this.loading = false)
    },
    createClient() {
      this.loading = true
      const client = this.client
      this.$api.clients.create({client})
          .then(() => this.fetchClients())
          .catch((error) => this.errors['create'] = error)
          .finally(() => {
            this.loading = false
            this.clearForm()
          })
    },
    deleteClient(client) {
      this.loading = true
      const client_id = client.id
      this.$api.clients.delete(client_id)
        .then(() => this.fetchClients())
        .catch((error) => this.errors['delete'] = error)
        .finally(() => this.loading = false)

    },
    clearForm() {
      this.client.full_name = ''
      this.client.email = ''
      this.client.phone = ''
      this.client.password = ''
      this.client.password_confirmation = ''
    }
  }
}
</script>

<style lang="sass" scoped>
  *
    padding: 0
    margin: 0

  #create-client-form
    width: 30%
    margin: 2em auto

  #create-client-form label
    margin-left: 1em

  .form-group input
    padding: .5em
    margin: .5em
    border-radius: 5px

  small
    margin-left: 1em
    color: #ff0000

  .button
    margin: 1em
    padding: .5em
    border-radius: 5px

  .create-button
    border-color: rgba(00, 80, 00, 1)
    color: rgba(00, 80, 00, 1)

  .create-button:disabled
    border-color: rgba(00, 80, 00, .5)
    color: rgba(00, 80, 00, .5)

  .delete-button
    border-color: rgba(255, 00, 00, 1)
    color: rgba(255, 00, 00, 1)

  table
    margin: 2em auto
    font-size: 1.2em
    text-align: center

  .border-red
    border-color: red
</style>
