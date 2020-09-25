import axios from 'axios'
import Vue from 'vue'

const api = {
  profile: () => axios.get('/staffs/profile'),
  clients: {
    index: () => axios.get('/staffs/clients_list'),
    create: (client) => axios.post('/staffs/create_client', client),
    delete: (id) => axios.post('/staffs/delete_client', id)
  }
}

Vue.prototype.$api = api
