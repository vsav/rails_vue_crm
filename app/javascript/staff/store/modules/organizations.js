export default {
  state: {
    organizations: [],
    organization: {},
  },

  actions: {
  },

  mutations: {
    STORE_DATA: (state, organizations) => {
      state.data = organizations
    }
  },

  namespaced: true
}
