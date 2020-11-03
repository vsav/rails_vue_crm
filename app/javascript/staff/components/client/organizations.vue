<template lang="pug">
  q-dialog(ref="clientOrganizationsDialog" persistent )
    q-card(style="width: 700px; max-width: 80vw;")
      q-card-section
        q-table(
          :title="client.full_name + ' Organizations List'"
          :data="organizations"
          :columns="columns"
          :pagination.sync="pagination"
          selection="multiple"
          :selected.sync="selected"
          row-key="id"
        )
        q-btn.q-ma-md(@click.prevent="updateOrganizationsList(client)" label="Update" color="orange" icon="warning")
        q-btn.q-ma-md(@click.prevent="hide()" label="Cancel")
</template>
<script>
export default {
  name: 'ClientOrganizationsTable',
  props: {
    client: Object
  },
  data() {
    return {
      pagination: {
        rowsPerPage: 10
      },
      errors: {},
      organizations: [],
      selected: [],
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
  created() {
    this.fetchOrganizations()
  },
  updated() {
    this.client.organizations = this.selected
  },
  methods: {
    fetchOrganizations() {
      this.$api.organizations.index()
        .then(({data}) => this.organizations = data)
        .catch((error) => this.errors['fetch'] = error)
      this.selectOrganizations()
    },
    updateOrganizationsList(client) {
      this.loading = true
      this.$api.clients.update(client)
        .catch((error) => this.errors['update'] = error)
        .finally(() => {
          this.loading = false
          this.hide()
        })
    },
    show () {
      this.$refs.clientOrganizationsDialog.show()
    },
    hide () {
      this.$router.push({name: 'clients'})
      this.$refs.clientOrganizationsDialog.hide()
    },
    selectOrganizations() {
      this.client.organizations.forEach(organization => {
        this.selected.push(organization)
      })
    }
  }
}
</script>
