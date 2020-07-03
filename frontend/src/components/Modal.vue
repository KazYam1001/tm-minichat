<template>
  <transition name="modal" appear>
    <div class="modal-overlay" @click.self="$emit('close')">
      <div class="modal-window">
        <div class="modal-content">
          <slot/>
        </div>
        <footer class="modal-footer">
          <slot name="footer">
          </slot>
        </footer>
      </div>
    </div>
  </transition>
</template>

<script>
  import axios from 'axios'
  import {postGroup} from '../modules/api.js'

  export default {
    data() {
      return {
      }
    },
    methods: {
      createGroup() {
        // モーダルで入力された値
        const groupName = this.$parent.groupName
        if (groupName === '') {
          alert('グループ名を入力して下さい')
          return
        }
        // csrfトークン
        const token = document.querySelector('meta[name=csrf-token]').getAttribute('content')
        // ActionCable用チャンネル
        const groupChannel = this.$parent.groupChannel
        // post /api/groups を叩く
        postGroup(token, groupName, groupChannel)
        this.$parent.closeModal()
        this.$parent.groupName = ''
        return
      }
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
