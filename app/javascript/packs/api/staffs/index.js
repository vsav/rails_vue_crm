import axios from 'axios'
import Vue from 'vue'

const token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

const api = {
  profile: () => axios.get('/staffs/profile'),
  sign_out: () => axios.get('/staffs/sign_out'),
  clients: {
    index: () => axios.get('/staffs/clients'),
    create: (client) => axios.post('/staffs/clients', client),
    delete: (client_id) => axios.delete(`/staffs/clients/${client_id}`),
    validate: (client) => axios.post('/staffs/validate_client', client)
  },
  organizations: {
    index: () => axios.get('/staffs/organizations'),
    create: (organization) => axios.post('/staffs/organizations', organization),
    update: (organization) => axios.patch(`/staffs/organizations/${organization.id}`, organization),
    delete: (organization_id) => axios.delete(`/staffs/organizations/${organization_id}`),
    validate: (organization) => axios.post('/staffs/validate_organization', organization)
  }
}

Vue.prototype.$api = api
