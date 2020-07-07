// Vueの導入と、エントリのインポート
import Vue from 'vue';
import App from './App.vue';

// ActionCable周り
import ActionCable from 'actioncable'
const cable = ActionCable.createConsumer('ws:localhost:3000/cable');
Vue.prototype.$cable = cable;

// storeのグローバル化
// 全コンポーネントからthis.$storeで呼べる
import store from './store'
Vue.prototype.$store = store

// App.vueをエントリとしてレンダリング
new Vue({
  el: '#app',
  render: h => h(App)
})
