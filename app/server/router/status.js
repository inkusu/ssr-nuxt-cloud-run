const Router = require('koa-router')
const router = new Router()

const db = require('../db/model')
const mail = require('../service/mail')

/**
 * データベース接続確認API
 */
router.get('/api/status/db', ctx => {
  return db.sequelize.authenticate()
    .then(() => {
      ctx.body = {
        'status': 'ok'
      }
    })
    .catch(err => {
      ctx.body = {
        'status': 'ng',
        'message': err
      }
    })
})

/**
 * メール接続状態確認API
 */
router.get('/api/status/mail', async (ctx, next) => {
  try{
    await mail.getSMTP.sendMail({
      from: process.env.SMTP_USER,
      to: 'wakai@vogaro.co.jp',
      text: 'テストメール',
    })
    ctx.body = {
      'status': 'ok',
      'message': 'テストメール送信に成功しました'
    }

  }catch (error) {
    ctx.body = {
      'status': 'ng',
      'message': 'テストメール送信に失敗しました',
      'info': error
    }

  }
})


module.exports = router
