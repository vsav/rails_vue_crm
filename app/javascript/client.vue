<template lang="pug">
  q-layout(view="hHh lpR fFf")
    template(v-if="loading")
      Loading
    template(v-else)
      Navbar
      ClientOrganizationsTable
</template>

<script>
import Navbar from './packs/shared/components/navbar'
import Loading from './packs/shared/components/loading'
import ClientOrganizationsTable from './client/components/organization/table'

export default {
  data: function() {
    return {
      loading: true
    }
  },
  components: {
    Navbar,
    Loading,
    ClientOrganizationsTable
  },
  created() {
    this.loading = false
  }
}
</script>
