<template lang="pug">
  q-table(
    title="Clients List"
    :data="clients"
    :columns="columns"
    :pagination.sync="pagination"
    row-key="id"
  )
    template(v-slot:body-cell-actions="client")
      q-td(:client="client")
        q-btn(@click.prevent="deleteClient(client)" icon="delete" round)
    template(v-slot:top-right)
      q-btn(label="Create Client" color="primary" @click="showForm" class="q-ma-md right" )
</template>
<script>
  import ClientForm from "./clientform";

  export default {
    name: 'ClientsTable',
    data() {
      return {
        pagination: {
          rowsPerPage: 10
        },
        errors: {},
        clients: [],
        columns: [
          {
            name: 'full_name',
            label: 'Full name',
            field: 'full_name',
            align: 'left',
            sortable: true
          },
          {
            name: 'email',
            label: 'Email',
            field: 'email',
            align: 'left',
            sortable: true
          },
          {
            name: 'phone',
            label: 'Phone',
            field: 'phone',
            align: 'left',
            sortable: true
          },
          {
            name: 'actions',
            label: 'Actions',
            align: 'left',
          }
        ]
      }
    },
    created() {
      this.fetchClients()
    },
    methods: {
      fetchClients() {
        this.$api.clients.index()
            .then(({data}) => this.clients = data)
            .catch((error) => this.errors['fetch'] = error)
      },
      deleteClient(client) {
        const client_id = client.row.id
        this.$api.clients.delete(client_id)
            .then(() => this.fetchClients())
            .catch((error) => this.errors['delete'] = error)
      },
      showForm() {
        this.$q.dialog({
          component: ClientForm,
          parent: this
        })
      }
    }
  }
</script>
