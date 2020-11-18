import Vue from 'vue'
import VueRouter from 'vue-router'

import ClientForm from '../components/client/form'
import ClientsTable from '../components/client/table'
import ClientOrganizationsTable from '../components/client/organizations'
import OrganizationForm from '../components/organization/form'
import OrganizationsTable from '../components/organization/table'
import OrganizationClientsTable from '../components/organization/clients'
import OrganizationEquipmentTable from '../components/organization/equipment'
import EquipmentForm from '../components/equipment/form'
import EquipmentTable from '../components/equipment/table'
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
          path: '/clients/new',
          component: ClientForm,
          name: 'new_client'
        },
        {
          path: '/clients/:id/edit',
          component: ClientForm,
          name: 'edit_client'
        },
        {
          path: '/clients/:id/manage_organizations',
          component: ClientOrganizationsTable,
          name: 'manage_client_organizations'
        }
      ]
    },
    {
      path: '/organizations',
      component: OrganizationsTable,
      name: 'organizations',
      children: [
        {
          path: '/organizations/new',
          component: OrganizationForm,
          name: 'new_organization'
        },
        {
          path: '/organizations/:id/edit',
          component: OrganizationForm,
          name: 'edit_organization'
        },
        {
          path: '/organizations/:id/manage_clients',
          component: OrganizationClientsTable,
          name: 'manage_organization_clients'
        },
        {
          path: '/organizations/:id/manage_equipment',
          component: OrganizationEquipmentTable,
          name: 'manage_organization_equipment'
        }
      ]
    },
    {
      path: '/equipment_list',
      component: EquipmentTable,
      name: 'equipment_list',
      children: [
        {
          path: '/equipment_list/new',
          component: EquipmentForm,
          name: 'new_equipment'
        },
        {
          path: '/equipment_list/:id/edit',
          component: EquipmentForm,
          name: 'edit_equipment'
        }
      ]
    }
  ]
})

export default router
