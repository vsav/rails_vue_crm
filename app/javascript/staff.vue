<template lang="pug">
  q-layout(view="hHh lpR fFf")
    template(v-if="loading")
      Loading
    template(v-else)
      Navbar
      Dashboard
</template>

<script>
  import Navbar from './staff/components/navbar.vue'
  import Dashboard from './staff/components/dashboard'
  import Loading from './packs/shared/components/loading'

  export default {
    data: function() {
      return {
        loading: true
      }
    },
    components: {
      Navbar,
      Dashboard,
      Loading
    },
    created() {
      this.loading = false
    }
  }
</script>
