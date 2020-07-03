<template>
  <div class='Wrapper'>
    <Sidebar :modal='modal' />
    <ChatMain :modal='modal' />
  </div>
</template>

<script>
  import Sidebar from './components/Sidebar.vue'
  import ChatMain from './components/ChatMain.vue'

  export default {
    data: ()=>{
      return {
        modal: false
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
