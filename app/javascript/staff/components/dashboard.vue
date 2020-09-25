<template lang="pug">
  div(id="dashboard")
    form(ref="createClientForm", id="create-client-form")
      fieldset
        legend Create New Client
        .form-group
          label(for="full-name") Full Name
          input(v-model="client.full_name", id="full-name", @input="validateName(client.full_name)", placeholder="John Doe")
          br/
          small(v-if="errors.full_name") {{errors.full_name}}
        .form-group
          label(for="phone-number") Phone Number
          input(v-model="client.phone", id="phone-number", @input="validatePhone(client.phone)", placeholder="223322")
          br/
          small(v-if="errors.phone") {{errors.phone}}
        .form-group
          label(for="email") Email
          input(v-model="client.email", id="email", type="email", @input="validateEmail(client.email)", placeholder="john@domain.com")
          br/
          small(v-if="errors.email") {{errors.email}}
        .form-group
          label(for="password") Password
          input(v-model="client.password", id="password", type="password", @input="validatePassword(client.password)")
          br/
          small(v-if="errors.password") {{errors.password}}
        .form-group
          label(for="password-confirmation") Password Confirmation
          input(v-model="client.password_confirmation", id="password-confirmation", type="password", @input="validatePasswordConfirmation(client.password_confirmation)")
          br/
          small(v-if="errors.password_confirmation") {{errors.password_confirmation}}
        button.create-button.button(@click.prevent="createClient()" type="button" :disabled="Object.keys(this.errors).length > 0") Create client

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
export default {
  name: 'Dashboard',
  data: function () {
    return {
      loading: false,
      errors: {},
      clients: [],
      client: {
        full_name: '',
        phone: '',
        email: '',
        password: '',
        password_confirmation: '',
      }
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
      const id = client.id
      this.$api.clients.delete({id})
        .then(() => this.fetchClients())
        .catch((error) => this.errors['delete'] = error)
        .finally(() => this.loading = false)

    },
    validateName(value){
      if (/^[a-z ,.'-]{5,}/i.test(value)) {
        delete this.errors.full_name;
      } else{
        this.errors['full_name'] = 'Name must contain minimum 5 characters';
      }
    },
    validateEmail(value){
      if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value)) {
        delete this.errors.email;
      } else{
        this.errors['email'] = 'Invalid Email Address';
      }
    },
    validatePhone(value){
      if (/^[\d]{5,}/i.test(value)) {
        delete this.errors.phone;
      } else{
        this.errors['phone'] = 'Phone must contain only digits minimum 5 characters';
      }
    },
    validatePassword(value){
      if (/^[\w]{5,}/i.test(value)) {
        delete this.errors.password;
      } else{
        this.errors['password'] = 'Password must contain minimum 5 characters';
      }
    },
    validatePasswordConfirmation(value) {
      if (this.client.password === value) {
        delete this.errors.password_confirmation;
      } else{
        this.errors['password_confirmation'] = 'Password didn\'t match';
      }
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
</style>
