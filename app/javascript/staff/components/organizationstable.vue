<template lang="pug">
  q-table(
    title="Organizations List"
    :data="organizations"
    :columns="columns"
    :pagination.sync="pagination"
    row-key="id"
  )
</template>
<script>
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
    }
  }
}
</script>
