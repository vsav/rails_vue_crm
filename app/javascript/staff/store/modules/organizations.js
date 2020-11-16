export default {
  state: {
    organizations: [],
    organization: {},
  },
  mutations: {
    STORE_DATA: (state, organizations) => {
      state.data = organizations
    },

    ADD_DATA: (state, organization) => {
      state.data.push(organization)
    },

    UPDATE_DATA: (state, data) => {
      let index = state.data.findIndex(organization => organization.id === data.id)
      state.data.splice(index, 1)
    },

    DELETE_DATA: (state, data) => {
      let index = state.data.findIndex(organization => organization.id === data.id)
      state.data.splice(index, 1)
    }
  },

  namespaced: true
}
