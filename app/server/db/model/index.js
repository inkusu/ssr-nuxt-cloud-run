const Sequelize = require("sequelize");
const config = require("../config/config");

const setting = config[process.env.NODE_ENV];

if (!setting) throw Error("データベースを接続するための環境変数が定義されていません。")

const sequelize = new Sequelize(setting);

const db = {
  sequelize,
  Sequelize,
};

module.exports = db
