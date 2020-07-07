<template>
  <aside class='sidebar'>
    <span @click="openNewModal" class="material-icons new-group-btn">add_circle_outline</span>
    <!-- 子コンポーネントからcloseの発火を受けたらcloseNewModalを動かす -->
    <Modal ref='modalNew' @close="closeNewModal" v-if='modalNew'>
      <!-- Modalのslotに差し込む -->
      <button @click="createGroup">送信</button>
    </Modal>
    <section class='group-container'>
      <div class='group'  v-for="group in groupList" :key="group.id">
        <p @click="selectGroup(group)" class='group-name'>{{ group.name }}</p>
        <span class='group-notice'> {{ group.id }} </span>
      </div>
    </section>
  </aside>
</template>

<script>
  import axios from 'axios'
  import {getGroups} from '../modules/api'
  import Modal from './Modal.vue'

  export default {
    components: { Modal },
    data() {
      return {
        modalNew: false,
        groupList: [],
        groupChannel: null, // ActionCable用
      }
    },
    created() {
      this.groupChannel = this.$cable.subscriptions.create( "GroupChannel",{
        received: (data) => {
          // ActionCableから配信があったらサイドバーを更新する
          this.groupList = []
          this.fetchGroups()
        },
      })
    },
    mounted() {
      // マウント直後にグループ一覧を取得
      this.fetchGroups()
    },
    methods: {
      openNewModal() {
        this.modalNew = true
      },
      closeNewModal() {
        this.modalNew = false
      },
      fetchGroups() {
        // api.jsのgetGroupsにgroupListを渡す
        getGroups(this.groupList)
      },
      createGroup() {
        // $refsで子コンポーネントのメソッドを使える
        // modalNewはModalコンポーネントを呼ぶ時にref=を使って名付けている
        this.$refs.modalNew.createGroup()
      },
      selectGroup(group) {
        this.$store.setCurrentGroup(group)
        this.$parent.fetchMessages(group)
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
    cursor: pointer;
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
