<template lang="pug">
  div(id="dashboard" class="q-pa-md")
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
      loading: false,
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
