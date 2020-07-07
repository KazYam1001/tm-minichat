<template>
  <div class='Wrapper'>
    <Sidebar />
    <ChatMain />
  </div>
</template>

<script>
  import Sidebar from './components/Sidebar.vue'
  import ChatMain from './components/ChatMain.vue'
  import {getMessages} from './modules/api'

  export default {
    data: ()=>{
      return {
      }
    },
    components: {
      Sidebar,
      ChatMain
    },
    methods: {
      fetchMessages(group) {
        getMessages(group)
          .then((res)=>{
            if (res.status === 200) {
              this.$store.setMessageList(res.data)
            } else {
              alert(`${res.status} ${res.statusText}`)
            }
          })
      },
    }
  }
</script>

<style scoped>
  .Wrapper {
    display: flex;
  }
</style>
