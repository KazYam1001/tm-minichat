import axios from 'axios'
import constant from '../config/constant'

// グループ全件取得
// /api/groupsを叩き、結果をgroupListに入れる
export const getGroups = (groupList)=> {
  const path = '/api/groups'
  axios
    .get(constant.LocalOrigin + path)
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

// グループ1件取得
export const getGroup = (id)=>{
  const path = `/api/groups/${id}`
  return axios.get(constant.LocalOrigin + path)
}

// グループ作成
export const postGroup = (token, groupName, groupChannel)=> {
  const path = '/api/groups'
  axios
    .post(constant.LocalOrigin + path, {
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
  const path = `/api/groups/${groupId}`
  axios
    .put(constant.LocalOrigin + path, {
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
  const path = `/api/groups/${groupId}`
  axios
    .delete(constant.LocalOrigin + path, {
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
  const path = `/api/groups/${group.id}/messages`
  return axios.get(constant.LocalOrigin + path)
}
