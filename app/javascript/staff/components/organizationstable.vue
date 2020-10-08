<template lang="pug">
  q-table(
    title="Organizations List"
    :data="organizations"
    :columns="columns"
    :pagination.sync="pagination"
    row-key="id"
  )
    template(v-slot:body-cell-actions="organization")
      q-td(:organization="organization")
        q-btn(@click.prevent="deleteOrganization(organization)" icon="delete" round)
    template(v-slot:top-right)
      q-btn(label="Create Organization" color="primary" @click="showForm" class="q-ma-md right" )
</template>
<script>
import OrganizationForm from "./organizationform";

export default {
  name: 'OrganizationsTable',
  data() {
    return {
      pagination: {
        rowsPerPage: 10
      },
      errors: {},
      organizations: [],
      columns: [
        {
          name: 'name',
          label: 'Name',
          field: 'name',
          align: 'left',
          sortable: true
        },
        {
          name: 'structure',
          label: 'Structure',
          field: 'structure',
          align: 'left',
          sortable: true
        },
        {
          name: 'inn',
          label: 'INN',
          field: 'inn',
          align: 'left',
          sortable: true
        },
        {
          name: 'ogrn',
          label: 'OGRN',
          field: 'ogrn',
          align: 'left',
          sortable: true
        },
        {
          name: 'clients',
          label: 'Clients',
          field: row => this.getClients(row).join(' | '),
          align: 'left'
        },
        {
          name: 'actions',
          label: 'Actions'
        }
      ]
    }
  },
  created() {
    this.fetchOrganizations()
  },
  methods: {
    fetchOrganizations() {
      this.$api.organizations.index()
          .then(({data}) => this.organizations = data)
          .catch((error) => this.errors['fetch'] = error)
    },
    getClients(row) {
      const data = row.clients
      const clients = []
      data.forEach(client => clients.push(client.full_name))
      return clients
    },
    deleteOrganization(organization) {
      const organization_id = organization.row.id
      this.$api.organizations.delete(organization_id)
          .then(() => this.fetchOrganizations())
          .catch((error) => this.errors['delete'] = error)
    },
    showForm() {
      this.$q.dialog({
        component: OrganizationForm,
        parent: this
      })
    }
  }
}
</script>
