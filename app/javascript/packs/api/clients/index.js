import axios from 'axios'
import Vue from 'vue'

const token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

const api = {
  profile: () => axios.get('/clients/profile'),
  sign_out: () => axios.get('/clients/sign_out')
}

Vue.prototype.$api = api
