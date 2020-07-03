import axios from 'axios'

// グループ作成
export const postGroup = (token, groupName, groupChannel)=> {
  axios
    .post('/api/groups', {
      authenticity_token: token,
      name: groupName
    })
    .then((res) =>{
      if (res.status === 200) {
        groupChannel.perform('display', {
          group: res.data
        });
      } else {
        alert(`${res.status} ${res.statusText}`)
      }
    })
}
