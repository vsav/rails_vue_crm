<template lang="pug">
  q-layout(view="hHh lpR fFf")
    q-page-container
      template(v-if="loading")
        Loading
      template(v-else)
        Navbar
        Dashboard
</template>

<script>
import Navbar from './packs/shared/components/navbar'
import Dashboard from './staff/components/dashboard'
import Loading from './packs/shared/components/loading'

export default {
  data: function () {
    return {
      loading: false
    }
  },
  components: {
    Navbar,
    Dashboard,
    Loading
  }
}
</script>
