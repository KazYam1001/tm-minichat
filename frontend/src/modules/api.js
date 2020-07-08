import axios from 'axios'

// グループ全件取得
// /api/groupsを叩き、結果をgroupListに入れる
export const getGroups = (groupList)=> {
  axios
    .get('/api/groups')
      .then(
        (res) => {
          for(var i = 0; i < res.data.length; i++) {
            // this.groupListに上記resをforで回しながらpushしていく
            groupList.push(res.data[i]);
          }
        },
        (error) =>{
          alert(error)
        }
      )
}

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

// グループ編集
export const putGroup = (token, groupId, groupName, groupChannel)=> {
  axios
    .put(`/api/groups/${groupId}`, {
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

// グループ削除
export const deleteGroup = (token, groupId, groupChannel)=> {
  axios
    .delete(`/api/groups/${groupId}`, {
      data: { // deleteでparamsを送りたい時は data: が必要
        authenticity_token: token
      }
    })
      .then((res)=> {
        if (res.status === 200) {
          groupChannel.perform('display', {
            // 返り値は存在する別のグループ
            group: res.data
          });
        } else {
          alert(`${res.status} ${res.statusText}`)
        }
      })
}

// メッセージ全件取得
export const getMessages = (group)=> {
  return axios.get(`/api/groups/${group.id}/messages`)
}

// メッセージ作成
export const postMessage = (group, content, token)=> {
  return axios
    .post(`/api/groups/${group.id}/messages`, {
      authenticity_token: token,
      content: content,
    })
}
