<template lang="pug">
  div(id="dashboard" class="q-pa-md")
    ClientForm

    template(v-if="loading")
      q-spinner(
        color="primary"
        size="3em"
        :thickness="2")

    template(v-else)
      q-table(
        title="Clients List"
        :data="clients"
        :loading="loading"
        row-key="id"
        )
      button(class="button delete-button" @click.prevent ="deleteClient(client)" type="button") Delete client
</template>

<script>
import ClientForm from './clientform'
export default {
  name: 'Dashboard',
  data: function () {
    return {
      loading: false,
      errors: {},
      clients: []
    }
  },
  created() {
    this.fetchClients()
  },
  components: {
    ClientForm
  },
  methods: {
    fetchClients() {
      this.loading = true
      this.$api.clients.index()
          .then(({data}) => this.clients = data)
          .catch((error) => this.errors['fetch'] = error)
          .finally(() => this.loading = false)
    }
  }
}
</script>

<style lang="sass" scoped>

</style>
