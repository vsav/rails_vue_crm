<template lang="pug">
  .dashboard
    ClientForm
    ClientsTable
    OrganizationsTable
</template>

<script>
  import ClientForm from './clientform'
  import ClientsTable from './clientstable'
  import OrganizationsTable from './organizationstable'
  export default {
    name: 'Dashboard',
    data: function () {
      return {
        errors: {}
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
