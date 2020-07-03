<template>
  <article class='chat-main'>
    <header class='group-header'>
      <div class="current-group">
        <p class='current-group-name'>{{ this.currentGroup.name }}</p>
        <p @click="openModal" class='edit-group-btn'>編集</p>
        <Modal ref='modal' @close='closeModal' v-if='modal'>
          <!-- Modalのslotに差し込む -->
          <label class='group-form-label'>新しいグループ名</label>
          <div><input v-model="groupName"></div>
          <!-- slot ここまで -->
          <!-- Modalのslot name=footerに差し込む -->
          <template slot="footer">
            <button @click="updateGroup">編集</button>
          </template>
          <!-- slot name=footer ここまで -->
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
  import Modal from './Modal.vue'

  export default {
    components: { Modal },
    props: ['modal'],
    data() {
      return {
        currentGroup: '',
        groupName: '',
      }
    },
    mounted() {
      this.fetchCurrentGroup()
    },
    methods: {
      fetchCurrentGroup(id) {
        // /api/groups/:idを叩く
        axios.get(`/api/groups/${id}`).then((res) => {
          this.currentGroup = res.data
        })
      },
      updateGroup() {
        console.log(2)
      },
      openModal() {
        this.groupName = this.currentGroup.name
        this.modal = true
      },
      closeModal() {
        this.modal = false
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
