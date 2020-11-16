export default {
  state: {
    organizations: [],
    organization: {
      clients: [],
      equipment: []
    }
  },
  mutations: {
    STORE_DATA: (state, organizations) => {
      state.data = organizations
    },

    ADD_DATA: (state, organization) => {
      state.data.push(organization)
    },

    UPDATE_DATA: (state, data) => {
      const index = state.data.findIndex(organization => organization.id === data.id)
      state.data.splice(index, 1, data)
    },

    DELETE_DATA: (state, data) => {
      const index = state.data.findIndex(organization => organization.id === data.id)
      state.data.splice(index, 1)
    }
  },

  namespaced: true
}
