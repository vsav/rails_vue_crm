import axios from 'axios'
import Vue from 'vue'

const token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

const api = {
  profile: () => axios.get('/staffs/profile'),
  clients: {
    index: () => axios.get('/staffs/clients'),
    create: (client) => axios.post('/staffs/clients', client),
    delete: (client_id) => axios.delete(`/staffs/clients/${client_id}`)
  }
}

Vue.prototype.$api = api
