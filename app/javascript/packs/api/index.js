import axios from 'axios'
import Vue from 'vue'

const api = {
  profile: () => axios.get('/staffs/profile')
}

Vue.prototype.$api = api
