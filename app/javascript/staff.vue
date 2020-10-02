<template lang="pug">
  #app
    navbar
    dashboard
</template>

<script>
  import Navbar from './staff/components/navbar.vue'
  import Dashboard from './staff/components/dashboard'

  export default {
    components: {
      Navbar,
      Dashboard
    }
  }
</script>
