<template lang="pug">
  q-page-container
    q-table(
      title="Organizations List"
      :data="clientOrganizations"
      :columns="columns"
      :pagination.sync="pagination"
      row-key="id"
    )

</template>
<script>
export default {
  name: 'ClientOrganizationsTable',
  data () {
    return {
      pagination: {
        rowsPerPage: 10
      },
      errors: {},
      clientOrganizations: [],
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
        }
      ]
    }
  },
  created () {
    this.fetchOrganizations()
  },
  methods: {
    fetchOrganizations () {
      this.$api.organizations.index()
        .then(({ data }) => { this.clientOrganizations = data })
        .catch((error) => { this.errors.fetch = error })
    }
  }
}
</script>
