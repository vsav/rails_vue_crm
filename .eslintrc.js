module.exports = {
  root: true,

  parserOptions: {
    parser: 'babel-eslint',
    ecmaVersion: 2020,
    sourceType: 'module'
  },

  env: {
    browser: true
  },

  extends: [
    'plugin:vue/essential',
    'standard'
  ],

  plugins: [
    'vue'
  ],

  globals: {
    ga: true,
    cordova: true,
    __statics: true,
    process: true,
    Capacitor: true,
    chrome: true
  },

  rules: {
  }
}
