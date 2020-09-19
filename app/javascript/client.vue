<template>
  <div id="app">
    <p>{{ message }}</p>
    <a href="/clients/sign_out" data-method="delete">Sign out</a>
  </div>
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

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
