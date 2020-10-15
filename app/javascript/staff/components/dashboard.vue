<template lang="pug">
  .dashboard.q-pa-md
    q-tabs(dense v-model="tab")
      q-tab(name="clients" label="Clients" icon="people_outlined")
      q-tab(name="organizations" label="Organizations"  icon="domain")
    q-tab-panels(v-model="tab" animated)
      q-tab-panel(name="clients")
        ClientsTable
      q-tab-panel(name="organizations")
        OrganizationsTable

</template>

<script>
  import ClientForm from './client/form'
  import ClientsTable from './client/table'
  import OrganizationsTable from './organization/table'
  export default {
    name: 'Dashboard',
    data: function () {
      return {
        tab: ''
      }
    },
    components: {
      ClientForm,
      ClientsTable,
      OrganizationsTable
    }
  }
</script>

<style lang="sass" scoped>
</style>
