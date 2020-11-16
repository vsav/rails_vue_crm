<template lang="pug">
  q-dialog(ref="organizationClientsDialog" persistent )
    q-card(style="width: 700px; max-width: 80vw;")
      q-card-section
        q-table(
          :title="organization.name + ' Clients List'"
          :data="clients"
          :columns="columns"
          :pagination.sync="pagination"
          selection="multiple"
          :selected.sync="selected"
          row-key="id"
        )
        q-btn.q-ma-md(@click.prevent="updateClientsList(organization)" label="Update" color="orange" icon="warning")
        q-btn(@click.prevent="hide()" label="Cancel" class="q-ma-md")

</template>
<script>
export default {
  name: 'OrganizationClientsTable',
  props: {
    organization: Object
  },
  data () {
    return {
      pagination: {
        rowsPerPage: 10
      },
      errors: {},
      clients: [],
      selected: [],
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
        }
      ]
    }
  },
  created () {
    this.fetchClients()
  },
  updated () {
    this.organization.clients = this.selected
  },
  methods: {
    fetchClients () {
      this.$api.clients.index()
        .then(({ data }) => { this.clients = data.clients })
        .catch((error) => { this.errors.fetch = error })
      this.selectClients()
    },
    updateClientsList (organization) {
      this.loading = true
      this.$api.organizations.update(organization)
        .catch((error) => { this.errors.update = error })
        .finally(() => {
          this.loading = false
          this.hide()
        })
    },
    show () {
      this.$refs.organizationClientsDialog.show()
    },
    hide () {
      this.$router.push({ name: 'organizations' })
      this.$refs.organizationClientsDialog.hide()
    },
    selectClients () {
      this.organization.clients.forEach(client => {
        this.selected.push(client)
      })
    }
  }
}
</script>
