<template lang="pug">
  #app
    p {{ message }}
    a(href="/clients/sign_out" data-method="delete") Sign out
</template>

<script>
  export default {
    data: function () {
      return {
        message: "Hello Client!"
      }
    }
  }
</script>

<style lang="sass">
  p
    font-size: 2em
    text-align: center
</style>
