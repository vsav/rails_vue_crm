<template lang="pug">
  q-table(
    title="Organizations List"
    :data="organizations"
    :columns="columns"
    :pagination.sync="pagination"
    row-key="id"
    :filter="filter"
    @request="onRequest"
    binary-state-sort
  )
    template(v-slot:body-cell-actions="organization")
      q-td(:organization="organization")
        q-btn(@click.prevent="deleteOrganization(organization)" icon="delete" round)
        q-btn(@click="editOrganization(organization)" icon="edit" round v-model="organization")
    template(v-slot:body-cell-clients="organization")
      q-td(:organization="organization")
        q-btn(@click="manageClients(organization)" icon="group_add" round)
        q-btn(@click="manageEquipment(organization)" icon="biotech" round)
    template(v-slot:top-right)
      q-input(borderless dense debounce="300" v-model="filter" label="Name | INN | OGRN")
        template(v-slot:prepend)
          q-icon(name="search")
      q-btn.q-ma-md(label="Create Organization" color="primary" @click="showForm")
</template>
<script>
import OrganizationForm from "./form";
import OrganizationClientsTable from "./clients"
import OrganizationEquipmentTable from "./equipment"

export default {
  name: 'OrganizationsTable',
  data() {
    return {
      pagination: {
        sortBy: 'name',
        descending: false,
        page: 1,
        rowsPerPage: 5,
        rowsNumber: ''
      },
      errors: {},
      organizations: [],
      organization: {},
      filter: '',
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
          align: 'left'
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
          label: 'Manage Clients | Equipment',
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
  mounted () {
    this.onRequest({
      pagination: this.pagination,
      filter: undefined
    })
  },
  methods: {
    onRequest (props) {
      const {page, sortBy, descending, rowsPerPage} = props.pagination
      const filter = props.filter
      this.loading = true
      this.$api.organizations.index({ search: filter, sort_by: sortBy, page: page, descending: descending, per_page: rowsPerPage })
          .then(({data}) => {
            this.organizations = data.organizations
            this.pagination.rowsNumber = data.meta.rows_number
            this.pagination.rowsPerPage = rowsPerPage
            this.pagination.page = data.meta.page
            this.pagination.sortBy = sortBy
            this.pagination.descending = descending })
          .catch((error) => this.errors['fetch'] = error)
          .finally(()=> this.loading = false)
    },
    setOrganization(organization) {
      this.organization = organization
      this.organization.clients = organization.clients
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
    },
    manageClients(organization) {
      this.$router.push({ name: 'manage_organization_clients', params: {id: organization.row.id }})
      this.$q.dialog({
        component: OrganizationClientsTable,
        parent: this,
        organization: organization.row
      })
    },
    manageEquipment(organization) {
      this.$router.push({ name: 'manage_organization_equipment', params: {id: organization.row.id }})
      this.$q.dialog({
        component: OrganizationEquipmentTable,
        parent: this,
        organization: organization.row
      })
    },
    editOrganization(organization) {
      this.setOrganization(organization.row)
      this.$router.push({ name: 'edit_organization', params: {id: organization.row.id }})
      this.$q.dialog({
        component: OrganizationForm,
        parent: this,
        edited_organization: this.organization
      })
    }
  }
}
</script>
