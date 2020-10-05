<template lang="pug">
  q-page
    ClientForm
    ClientsTable
</template>

<script>
  import ClientForm from './clientform'
  import ClientsTable from './clientstable'
  export default {
    name: 'Dashboard',
    data: function () {
      return {
        errors: {}
      }
    },
    components: {
      ClientForm,
      ClientsTable
    }
  }
</script>

<style lang="sass" scoped>
</style>
