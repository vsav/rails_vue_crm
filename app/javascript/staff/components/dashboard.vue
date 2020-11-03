<template lang="pug">
  .dashboard.q-pa-md
    q-tabs(dense v-model="tab")
      q-route-tab(name="clients" label="Clients" icon="people_outlined" to="/clients")
      q-route-tab(name="organizations" label="Organizations"  icon="domain" to="/organizations")
      q-route-tab(name="equipment" label="Equipment"  icon="biotech" to="/equipment_list")
    q-tab-panels(v-model="tab" animated)
      q-tab-panel(name="clients")
        router-view
      q-tab-panel(name="organizations")
        router-view
      q-tab-panel(name="equipment")
        router-view
</template>

<script>
  export default {
    name: 'Dashboard',
    data: function () {
      return {
        tab: ''
      }
    }
  }
</script>

<style lang="sass" scoped>
</style>
