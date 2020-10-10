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
        q-btn(@click="editOrganization(organization)" icon="edit" round v-model="organization")
    template(v-slot:body-cell-clients="organization")
      q-td(:organization="organization")
        q-btn(@click="manageClients(organization)" icon="group_add" round)
    template(v-slot:top-right)
      q-btn(label="Create Organization" color="primary" @click="showForm" class="q-ma-md right" )
</template>
<script>
import OrganizationForm from "./form";
import OrganizationClientsTable from "./clients"

export default {
  name: 'OrganizationsTable',
  data() {
    return {
      pagination: {
        rowsPerPage: 10
      },
      errors: {},
      organizations: [],
      organization: {
      },
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
          label: 'Manage Clients',
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
    this.fetchOrganizations()
  },
  methods: {
    fetchOrganizations() {
      this.$api.organizations.index()
          .then(({data}) => this.organizations = data)
          .catch((error) => this.errors['fetch'] = error)
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
      this.$q.dialog({
        component: OrganizationClientsTable,
        parent: this,
        organization: organization.row
      })
    },
    editOrganization(organization) {
      this.setOrganization(organization.row)
      this.$q.dialog({
        component: OrganizationForm,
        parent: this,
        edited_organization: this.organization
      })
    }
  }
}
</script>
