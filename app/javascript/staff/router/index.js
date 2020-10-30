import Vue from 'vue'
import VueRouter from 'vue-router'

import ClientForm from '../components/client/form'
import ClientsTable from '../components/client/table'
import ClientOrganizationsTable from '../components/client/organizations'
import OrganizationForm from '../components/organization/form'
import OrganizationsTable from '../components/organization/table'
import OrganizationClientsTable from '../components/organization/clients'
import Dashboard from '../components/dashboard'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  base: '/staffs',
  routes: [
    {
      path: '/',
      redirect: '/dashboard'
    },
    {
      path: '/dashboard',
      component: Dashboard,
      name: 'dashboard'
    },
    {
      path: '/clients',
      component: ClientsTable,
      name: 'clients',
      children: [
        {
          path: '/clients/:id/edit',
          component: ClientForm,
          name: 'edit_client',
        },
        {
          path: '/clients/:id/manage_organizations',
          component: ClientOrganizationsTable,
          name: 'manage_client_organizations',
        }
      ]
    },

    {
      path: '/organizations',
      component: OrganizationsTable,
      name: 'organizations',
      children: [
        {
          path: '/organizations/:id/edit',
          component: OrganizationForm,
          name: 'edit_organization',
        },
        {
          path: '/organizations/:id/manage_clients',
          component: OrganizationClientsTable,
          name: 'manage_organization_clients',
        }
      ]
    }
  ]
})

export default router
