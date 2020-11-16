import Vue from 'vue'
import ActionCableVue from 'actioncable-vue';

Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: 'error',
  connectionUrl: process.env.WS_CONNECTION_URL,
  connectImmediately: true,
});

