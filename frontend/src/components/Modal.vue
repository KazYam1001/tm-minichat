<template>
  <transition name="modal" appear>
    <!-- イベントにselfをつけると他の要素に伝播しなくなる -->
    <!-- $emitで親コンポーネントのcloseイベントを発火する -->
    <div class="modal-overlay" @click.self="$emit('close')">
      <div class="modal-window">
        <div class="modal-content">
          <label class='group-form-label'>グループ名</label>
          <div><input v-model="groupName"></div>
        </div>
        <footer class="modal-footer">
          <slot />
        </footer>
      </div>
    </div>
  </transition>
</template>

<script>
  import axios from 'axios'
  import {postGroup, putGroup} from '../modules/api.js'

  export default {
    data() {
      return {
        token: '',
        groupName: ''
      }
    },
    mounted() {
      this.token = document.querySelector('meta[name=csrf-token]').getAttribute('content')
    },
    methods: {
      createGroup() {
        if (this.groupName === '') {
          alert('グループ名を入力して下さい')
          return
        }
        // post /api/groups を叩く
        postGroup(this.token, this.groupName, this.$parent.groupChannel)
        this.$emit('close')
        this.groupName = ''
        return
      },
      updateGroup(groupId) {
        if (this.groupName === '') {
          alert('グループ名を入力して下さい')
          return
        }
        // put /api/groups/:id を叩く
        putGroup(this.token, groupId, this.groupName, this.$parent.groupChannel)
        this.$emit('close')
      },
    }
  }
</script>

<style>
  .modal-overlay {
    display: flex;
    align-items: center;
    justify-content: center;
    position: fixed;
    z-index: 30;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
  }
  .modal-window {
    background: #fff;
    border-radius: 4px;
    overflow: hidden;
  }
  .modal-content {
    padding: 10px 20px;
  }
  .group-form-label {
    color: #222;
  }
  .modal-footer {
    background: #ccc;
    padding: 10px;
    text-align: right;
  }

  /* この辺公式からコピーして理解不足 */
  /* オーバーレイのトランジション */
  .modal-enter-active, .modal-leave-active {
    transition: opacity 0.4s;
  }
  /* オーバーレイに包含されているモーダルウィンドウのトランジション */
  .modal-window {
    transition: opacity 0.4s, transform 0.4s;
  }
  /* ディレイを付けるとモーダルウィンドウが消えた後にオーバーレイが消える */
  .modal-leave-active {
    transition: opacity 0.6s ease 0.4s;
  }
  .modal-enter, .modal-leave-to {
    opacity: 0;
  }

</style>
