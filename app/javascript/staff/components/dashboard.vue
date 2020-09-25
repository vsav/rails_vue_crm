<template lang="pug">
  #dashboard
    template(v-if="loading")
      p Loading...
    template(v-else-if="error")
      p Something went wrong...
    template(v-else)
      form(class="create-client-form")
        fieldset
          legend Create New Client
          label(for="full-name") Full Name
          input(v-model="client.full_name", id="full-name", placeholder="John Doe")
          br/
          small Name must contain minimum 5 characters
          br/
          br/
          label(for="phone-number") Phone Number
          input(v-model="client.phone", id="phone-number", placeholder="223322")
          br/
          small Phone number must contain only digits
          br/
          br/
          label(for="email") Email
          input(v-model="client.email", id="email", placeholder="john@domain.com")
          br/
          small Please enter valid email address
          br/
          br/
          label(for="password") Password
          input(v-model="client.password", id="password", type="password")
          br/
          small Please use strong password
          br/
          br/
          label(for="password-confirmation") Password Confirmation
          input(v-model="client.password_confirmation", id="password-confirmation", type="password")
          br/
          small Re-enter your password
          button.create-button.button(@click="createClient") Create client
                                      //:disabled="Object.keys(this.errors).length > 0")

          table
            thead Clients List
              tr
                th Id
                th Full Name
                th Phone Number
                th Email
            tbody
              tr(v-for='client in clients' :key='client.id')
                td {{ client.id }}
                td {{ client.full_name }}
                td {{ client.phone }}
                td {{ client.email }}
</template>

<script>
export default {
  name: 'Dashboard',
  data: function () {
    return {
      loading: false,
      error: false,
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
          .catch(() => this.error = true)
          .finally(() => this.loading = false)
    },
    createClient() {
      this.loading = true
      const client = this.client
      this.$api.clients.create({client})
          .then(({data}) => this.clients.push(data))
          .catch(() => this.error = true)
          .finally(() => this.loading = false)
      this.clearForm()
    },
    clearForm() {
      this.client.full_name =''
      this.client.phone = ''
      this.client.email = ''
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
  p
    font-size: 2em
    text-align: center
</style>
