import axios from 'axios'
import Vue from 'vue'

const token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

const adapter = axios.create({
  baseURL: '/clients',
  headers: {
    'Accept': 'application/json'
  }
})

const api = {
  profile: () => adapter.get('/profile'),
  sign_out: () => axios.get('/clients/sign_out'),
  organizations: {
    index: () => adapter.get('/organizations')
  }
}

Vue.prototype.$api = api
