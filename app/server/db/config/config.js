// sequelize cliからも起動するためjsファイルのまま
require('dotenv').config();
const path = require('path');

module.exports = {
  'define': {
    'underscored': true
  },
  // local db
  'development': {
    'timezone': '+09:00',
    'username': process.env.DB_USERNAME,
    'password': process.env.DB_PASSWORD,
    'database': process.env.DB_NAME,
    'host': process.env.DB_HOST,
    'dialect': 'mysql',
    'modelPaths': [
      path.join(__dirname, '/../models/*.model.js')
    ]
  },
  // staging db
  'test': {
    'timezone': '+09:00',
    'username': process.env.DB_USERNAME,
    'password': process.env.DB_PASSWORD,
    'database': process.env.DB_NAME,
    'host': 'localhost',
    'dialect': 'mysql',
    "dialectOptions": {
      "socketPath": process.env.DB_HOST
    },
    'logging': function () {},
    'modelPaths': [
      path.join(__dirname, '/../models/*.model.js')
    ]
  },
  // production db
  'production': {
    'timezone': '+09:00',
    'username': process.env.DB_USERNAME,
    'password': process.env.DB_PASSWORD,
    'database': process.env.DB_NAME,
    'host': 'localhost',
    'dialect': 'mysql',
    "dialectOptions": {
      "socketPath": process.env.DB_HOST
    },
    'logging': function () {},
    'modelPaths': [
      path.join(__dirname, '/../models/*.model.js')
    ]
  },
}
