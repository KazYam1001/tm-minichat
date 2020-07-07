<template>
  <article class='chat-main'>
    <header class='group-header'>
      <div class="current-group">
        <p class='current-group-name'>{{ sharedState.currentGroup.name }}</p>
        <p @click="openEditModal" class='edit-group-btn'>編集</p>
        <Modal ref='modalEdit' @close="closeEditModal" v-if='modalEdit'>
          <!-- Modalのslotに差し込む -->
          <button @click="updateGroup">編集</button>
        </Modal>
      </div>
      <p @click="destroyGroup" class='remove-group-btn'>チャットグループを削除する</p>
    </header>
    <section class='message-container'>
      <p v-for="message in sharedState.messageList" :key="message.id" class='message'>{{ message.content }}</p>
    </section>
    <form @submit.prevent="createMessage" action="#" class="message-form">
      <input v-model="messageContent" type="text" class='message-text-field'>
      <input type="submit" class='submit-btn'>
    </form>
  </article>
</template>

<script>
  import axios from 'axios'
  import {deleteGroup, postMessage} from '../modules/api'
  import Modal from './Modal.vue'

  export default {
    components: { Modal },
    data() {
      return {
        groupChannel: null, // ActionCable用
        messageContent: '',
        modalEdit: false,
        sharedState: this.$store.state, // store.stateまでしか読めない？currentGroupつけるとエラー
        token: '',
      }
    },
    created() {
      this.groupChannel = this.$cable.subscriptions.create( "GroupChannel",{
        received: (data) => {
          // ActionCableで配信されてきたものがdataに入る
          // data.actionにどのアクションから来たか(create/update/destroy)を格納してある
          if (data.action === 'update') {
            // updateならdataはcurrentGroupと同じグループのはずなのでヘッダのグループ名を更新
            this.$store.setCurrentGroup(data.group)
          } else if (data.action === 'destroy') {
            // destroyなら別のグループが送られてきているので削除されたことを通知して移動
            alert('このグループは削除されたため、別のグループへ移動します')
            this.$store.setCurrentGroup(data.group)
          }
          // createの時は何もしない(Sidebarコンポーネントの更新はある)
        },
      })
    },
    mounted() {
      this.token = document.querySelector('meta[name=csrf-token]').getAttribute('content')
      this.fetchCurrentGroup()
    },
    methods: {
      openEditModal() {
        this.modalEdit = true
      },
      closeEditModal() {
        this.modalEdit = false
      },
      // グループ CRUD操作
      fetchCurrentGroup(id) {
        axios
          .get(`/api/groups/${id}`)
            .then((res) => {
              // currentGroupの状態はstoreで管理している
              // store内のデータ書き換えはstore内のメソッドに任せる
              this.$store.setCurrentGroup(res.data)
              // メッセージ一覧もセットで取得する
              this.$parent.fetchMessages(res.data)
            })
      },
      updateGroup() {
        this.$refs.modalEdit.updateGroup(this.sharedState.currentGroup.id)
      },
      destroyGroup() {
        if (confirm('本当に削除しますか？')) {
          deleteGroup(this.token, this.sharedState.currentGroup.id, this.groupChannel)
        }
      },
      // グループ関係ここまで
      createMessage() {
        postMessage(this.sharedState.currentGroup, this.messageContent, this.token)
          .then((res)=>{
            if (res.status === 200) {
              console.log(res.data)
              this.messageContent = ''
            } else {
              alert(`${res.status} ${res.statusText}`)
            }
          })
      }
    }
  }
</script>

<style scoped>
  .chat-main {
    height: 100vh;
    width: calc(100vw - 200px);
    display: flex;
    flex-direction: column;
    padding: 1rem;
    color: #222;
  }
  .group-header {
    height: 5.4rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: solid 1px #222;
  }
  .current-group {
    display: flex;
  }
  .current-group-name {
    margin-left: 1.5rem;
    font-size: 1.7rem;
  }
  .edit-group-btn {
    margin-left: 1rem;
    padding-top: 1rem;
    color: #aaa;
    cursor: pointer;
  }
  .group-form-label {
    color: #222;
  }
  .remove-group-btn {
    margin-right: 1rem;
    color: #aaa;
    cursor: pointer;
  }
  .message-container {
    padding-top: 1rem;
    padding-left: 1.5rem;
    flex-grow: 1;
    overflow: scroll;
  }
  .message {
    margin-bottom: 1rem;
    font-size: 1.5rem;
  }
  .message-form {
    display: flex;
    height: 4rem;
  }
  .message-text-field {
    flex-grow: 1;
    height: 3rem;
    border: solid 1px #aaa;
    border-radius: 5px;
  }
  .submit-btn {
    height: 3rem;
    width: 5rem;
    margin-left: 2rem;
    font-size: 1.5rem;
    background-color: #777;
    color: #eee;
    border: solid 1px #eee;
    border-radius: 5px;
  }
</style>
