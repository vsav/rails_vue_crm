import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import organizations from './modules/organizations'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    organizations
  },
  plugins: [createPersistedState()]
})
