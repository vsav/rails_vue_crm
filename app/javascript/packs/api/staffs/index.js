import axios from 'axios'
import Vue from 'vue'

const token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

const adapter = axios.create({
  baseURL: '/staffs',
  headers: {
    'Accept': 'application/json'
  }
})

const api = {
  profile: () => adapter.get('/profile'),
  sign_out: () => axios.get('/staffs/sign_out'),
  update_password: (profile) => adapter.patch(`/update_password`, { staff: profile }),
  clients: {
    index: () => adapter.get('/clients'),
    create: (client) => adapter.post('/clients', client),
    update: (client) => adapter.patch(`/clients/${client.id}`, client),
    delete: (client_id) => adapter.delete(`/clients/${client_id}`),
    validate: (client) => adapter.post('/validate_client', client)
  },
  organizations: {
    index: (params) => adapter.get('/organizations', { params: params }),
    create: (organization) => adapter.post('/organizations', organization),
    update: (organization) => adapter.patch(`/organizations/${organization.id}`, organization),
    delete: (organization_id) => adapter.delete(`/organizations/${organization_id}`),
    validate: (organization) => adapter.post('/validate_organization', organization)
  },
  equipment: {
    index: () => adapter.get('/equipment'),
    create: (equipment) => adapter.post('/equipment', equipment),
    update: (equipment) => adapter.patch(`/equipment/${equipment.id}`, equipment),
    delete: (equipment_id) => adapter.delete(`/equipment/${equipment_id}`),
    validate: (equipment) => adapter.post('/validate_equipment', equipment)
  }
}

Vue.prototype.$api = api
