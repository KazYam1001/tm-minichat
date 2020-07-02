<template>
  <div class='message'>
    {{ greeting }} world!
  </div>
</template>

<script>
  module.exports = {
    data: ()=>{
      return {
        greeting: 'hello'
      }
    }
  }
</script>

<style scoped>
  .message {
    font-size: 2rem;
    color: blue;
  }
</style>
