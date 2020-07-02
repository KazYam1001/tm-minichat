<template>
  <aside class='sidebar'>
    <!-- クリックしたらopenModalメソッドを動かす -->
    <span @click="openModal" class="material-icons new-group-btn">add_circle_outline</span>
    <!-- data.modalがtrueになったらModalコンポーネントが表示される -->
    <Modal @close='closeModal' v-if='modal'>
      <!-- methodはこっちに書きたいのでslotを使う -->
      <!-- Modalのslotに差し込む -->
      <label class='group-form-label'>グループ名</label>
      <div><input v-model="groupName"></div>
      <!-- slot ここまで -->
      <!-- Modalのslot name=footerに差し込む -->
      <template slot="footer">
        <button @click="submitGroup">送信</button>
      </template>
      <!-- slot name=footer ここまで -->
    </Modal>
    <section class='group-container'>
      <div class='group'  v-for="group in groups" :key="group.id">
        <p class='group-name'>{{ group.name }}</p>
        <span class='group-notice'> {{ group.id }} </span>
      </div>
    </section>
  </aside>
</template>

<script>
  import axios from 'axios'
  import Modal from './Modal.vue'

  export default {
    components: { Modal },
    data() {
      return {
        modal: false,
        groupName: '',
        groups: [],
        groupChannel: null
      }
    },
    created() {
      this.groupChannel = this.$cable.subscriptions.create( "GroupChannel",{
        received: (data) => {
          console.log(data)
          // ここでdata.groupsにpush
          // this.messages.push(data)
        },
      })
    },
    mounted() {
      this.fetchGroups()
    },
    methods: {
      fetchGroups() {
        // /api/booksを叩いてレスポンスをresで受け取る
        axios.get('/api/groups').then((res) => {
          // res.dataにコントローラで作った@groupsのJSONが入ってる
          for(var i = 0; i < res.data.length; i++) {
            // this.groupsに上記jsonをforで回しながらpushしていく
            this.groups.push(res.data[i]);
          }
        }, (error) => {
          console.log(error);
        });
      },
      openModal() {
        this.modal = true
      },
      closeModal() {
        this.modal = false
      },
      submitGroup() {
        // ここでaction_cable叩く
        const groupName = this.groupName
        this.groupChannel.perform('create', {
          groupName: groupName,
        });
        this.closeModal()
        this.groupName = ''
        return
      }
    }
  }
</script>

<style scoped>
  .sidebar {
    height: 100vh;
    width: 250px;
    padding: 0 0.7rem;
    background-color: #ccc;
    font-size: 1rem;
    color: white;
  }
  .new-group-btn {
    height: 5.4rem;
    padding-top: 1.2rem;
    padding-bottom: 1.2rem;
    font-size: 3rem;
    cursor: pointer;
  }
  .group-form-label {
    color: #222;
  }
  .group-container {
    height: calc(100% - 5.4rem);
    overflow: scroll;
  }
  .group {
    display: flex;
    margin-bottom: 1.5rem;
  }
  .group-name {
    margin-right: 1rem;
  }
  .group-notice {
    height: 1.5rem;
    min-width: 2.2rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 0.75rem;
    background-color: tomato;
    font-size: 0.8rem;
  }
</style>
