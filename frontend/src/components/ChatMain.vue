<template>
  <article class='chat-main'>
    <header class='group-header'>
      <div class="current-group">
        <p class='current-group-name'>{{ this.currentGroup.name }}</p>
        <!-- $emitでAppコンポーネントのom→openEditModalが発火する -->
        <p @click="openEditModal" class='edit-group-btn'>編集</p>
        <!-- $emitでAppコンポーネントのcm→closeEditModalが発火する -->
        <Modal ref='modalEdit' @close="closeEditModal" v-if='modalEdit'>
          <!-- Modalのslotに差し込む -->
          <button @click="updateGroup">編集</button>
        </Modal>
      </div>
      <p class='remove-group-btn'>チャットグループを削除する</p>
    </header>
    <section class='message-container'>
      <p class='message'>hello</p>
      <p class='message'>hi</p>
      <p class='message'>good bye</p>
      <p class='message'>hello</p>
      <p class='message'>hi</p>
      <p class='message'>good bye</p>
      <p class='message'>hello</p>
      <p class='message'>hi</p>
      <p class='message'>good bye</p>
      <p class='message'>hello</p>
      <p class='message'>hi</p>
      <p class='message'>good bye</p>
      <p class='message'>hello</p>
      <p class='message'>hi</p>
      <p class='message'>good bye</p>
      <p class='message'>hello</p>
      <p class='message'>hi</p>
      <p class='message'>good bye</p>
    </section>
    <form action="#" class="message-form">
      <input type="text" class='message-text-field'>
      <input type="submit" class='submit-btn'>
    </form>
  </article>
</template>

<script>
  import axios from 'axios'
  import {getGroups} from '../modules/api'
  import Modal from './Modal.vue'

  export default {
    components: { Modal },
    data() {
      return {
        modalEdit: false,
        currentGroup: {},
        groupChannel: null // ActionCable用
      }
    },
    created() {
      this.groupChannel = this.$cable.subscriptions.create( "GroupChannel",{
        received: (data) => {
          // ActionCableで配信されてきたものがdataに入る
          // updateならdataはcurrentGroupと同じグループのはずなのでヘッダのグループ名を更新
          // createの時は何もしない(Sidebarコンポーネントの更新はある)
          if (data.id === this.currentGroup.id) {
            this.currentGroup = data
          }
        },
      })
    },
    mounted() {
      this.fetchCurrentGroup()
    },
    methods: {
      openEditModal() {
        this.modalEdit = true
      },
      closeEditModal() {
        this.modalEdit = false
      },
      // api.jsに引っ越すとうまくいかない
      // this.currentGroupに対して別メソッド内で代入するとおかしくなる？
      fetchCurrentGroup(id) {
        axios
          .get(`/api/groups/${id}`)
            .then((res) => {
              this.currentGroup = res.data
            })
      },
      updateGroup() {
        this.$refs.modalEdit.updateGroup(this.currentGroup.id)
      },
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
