process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const pugLoader = require('./loaders/pug')
const sassLoader = require('./loaders/sass')
const eslint = require('./loaders/eslint')

environment.loaders.prepend('eslint', eslint)
environment.loaders.prepend('pug', pugLoader)
environment.loaders.prepend('sass', sassLoader)
module.exports = environment.toWebpackConfig()
