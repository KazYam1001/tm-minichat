<template>
  <div class='Wrapper'>
    <Sidebar />
    <ChatMain />
  </div>
</template>

<script>
  import Sidebar from './components/Sidebar.vue'
  import ChatMain from './components/ChatMain.vue'

  export default {
    data: ()=>{
      return {
      }
    },
    components: {
      Sidebar,
      ChatMain
    },
  }
</script>

<style scoped>
  .Wrapper {
    display: flex;
  }
</style>
