process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const pugLoader = require('./loaders/pug')

environment.loaders.prepend('pug', pugLoader)
module.exports = environment.toWebpackConfig()
