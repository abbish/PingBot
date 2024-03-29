# Description:
#   This command is for checking Pingping's health.
#

shelljs = require "shelljs"
_ = require "lodash"

module.exports = (robot) ->
  robot.respond /你好/i, (res) ->
    res.reply "主人好！"
    res.reply "您需要什么帮助 ?"

  robot.respond /升级/i, (res) ->
    res.reply "好的，请稍后 ..."
    shelljs.exec "git pull --reb", (code, stdout, stderr) ->
      res.reply stdout || stderr

      if code != 0
        res.reply "升级失败。"
      else
        res.reply "升级完成。"

  robot.respond /重启/i, (res) ->
    shelljs.exec "pm2 restart PingBot"

  robot.respond /命令 (.*)/i, (res) ->
    command = res.match[1]
    res.reply "执行命令：" + command
    shelljs.exec command, (code, stdout, stderr) ->
      res.reply stdout || stderr

  robot.respond /当前版本/i, (res) ->
    shelljs.exec "git log -1", (code, stdout, stderr) ->
      res.reply stdout

  robot.hear /有人在吗？/i, (res) ->
    res.reply "有啊。"

  robot.hear /今天/i, (res) ->
    res.reply new Date()

  robot.hear /明天/i, (res) ->
    res.reply "有雨"


# robot.respond /open the (.*) doors/i, (res) ->
#   doorType = res.match[1]
#   if doorType is "pod bay"
#     res.reply "I'm afraid I can't let you do that."
#   else
#     res.reply "Opening #{doorType} doors"
#
# robot.hear /I like pie/i, (res) ->
#   res.emote "makes a freshly baked pie"
#
# lulz = ['lol', 'rofl', 'lmao']
#
# robot.respond /lulz/i, (res) ->
#   res.send res.random lulz
#
# robot.topic (res) ->
#   res.send "#{res.message.text}? That's a Paddlin'"
#
#
# enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
# leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
#
# robot.enter (res) ->
#   res.send res.random enterReplies
# robot.leave (res) ->
#   res.send res.random leaveReplies
#
# answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
#
# robot.respond /what is the answer to the ultimate question of life/, (res) ->
#   unless answer?
#     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
#     return
#   res.send "#{answer}, but what is the question?"
#
# robot.respond /you are a little slow/, (res) ->
#   setTimeout () ->
#     res.send "Who you calling 'slow'?"
#   , 60 * 1000
#
# annoyIntervalId = null
#
# robot.respond /annoy me/, (res) ->
#   if annoyIntervalId
#     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
#     return
#
#   res.send "Hey, want to hear the most annoying sound in the world?"
#   annoyIntervalId = setInterval () ->
#     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
#   , 1000
#
# robot.respond /unannoy me/, (res) ->
#   if annoyIntervalId
#     res.send "GUYS, GUYS, GUYS!"
#     clearInterval(annoyIntervalId)
#     annoyIntervalId = null
#   else
#     res.send "Not annoying you right now, am I?"
#
#
# robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
#   room   = req.params.room
#   data   = JSON.parse req.body.payload
#   secret = data.secret
#
#   robot.messageRoom room, "I have a secret: #{secret}"
#
#   res.send 'OK'
#
# robot.error (err, res) ->
#   robot.logger.error "DOES NOT COMPUTE"
#
#   if res?
#     res.reply "DOES NOT COMPUTE"
#
# robot.respond /have a soda/i, (res) ->
#   # Get number of sodas had (coerced to a number).
#   sodasHad = robot.brain.get('totalSodas') * 1 or 0
#
#   if sodasHad > 4
#     res.reply "I'm too fizzy.."
#
#   else
#     res.reply 'Sure!'
#
#     robot.brain.set 'totalSodas', sodasHad+1
#
# robot.respond /sleep it off/i, (res) ->
#   robot.brain.set 'totalSodas', 0
#   res.reply 'zzzzz'
