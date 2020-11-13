import Vue from 'vue'
import App from '../staff.vue'
import './api/staffs'
import './quasar'
import router from '../staff/router'
import store from '../staff/store'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        router,
        store,
        render: h => h(App)
    }).$mount()
    document.body.appendChild(app.$el)
})
