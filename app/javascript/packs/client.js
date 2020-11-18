import Vue from 'vue'
import App from '../client.vue'
import './api/clients'
import './quasar'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})
