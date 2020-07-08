export default {
  state: {
    currentGroup: {},
    messageList: [],
  },
  setCurrentGroup(group) {
    this.state.currentGroup = group
  },
  setMessageList(messageList) {
    this.state.messageList = messageList
  }
}
