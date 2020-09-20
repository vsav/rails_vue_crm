<template lang="pug">
  #app
    p {{ message }}
    a(href="/staffs/sign_out" data-method="delete") Sign out
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Staff!"
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
