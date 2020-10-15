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
        q-btn(@click="editClient(client)" icon="edit" round v-model="client")
    template(v-slot:body-cell-organizations="client")
      q-td(:client="client")
        q-btn(@click="manageOrganizations(client)" icon="domain_disabled" round)
    template(v-slot:top-right)
      q-btn(label="Create Client" color="primary" @click="showForm" class="q-ma-md right" )
</template>
<script>
  import ClientForm from "./form";
  import ClientOrganizationsTable from "./organizations"

  export default {
    name: 'ClientsTable',
    data() {
      return {
        pagination: {
          rowsPerPage: 10
        },
        errors: {},
        clients: [],
        client: {},
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
            name: 'organizations',
            label: 'Organizations',
            align: 'left'
          },
          {
            name: 'actions',
            label: 'Actions',
            align: 'left'
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
      setClient(client) {
        this.client = client
        this.client.organizations = client.organizations
      },
      showForm() {
        this.$q.dialog({
          component: ClientForm,
          parent: this
        })
      },
      manageOrganizations(client) {
        this.$q.dialog({
          component: ClientOrganizationsTable,
          parent: this,
          client: client.row
        })
      },
      editClient(client) {
        this.setClient(client.row)
        this.$q.dialog({
          component: ClientForm,
          parent: this,
          edited_client: this.client
        })
      }
    }
  }
</script>
