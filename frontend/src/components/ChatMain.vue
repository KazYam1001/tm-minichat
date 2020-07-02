<template>
  <article class='chat-main'>
    <header class='group-header'>
      <div class="current-group">
        <p class='current-group-name'>CurrentGroup</p>
        <p class='edit-group-btn'>編集</p>
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
