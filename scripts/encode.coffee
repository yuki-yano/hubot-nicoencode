exec = require('child_process').exec

randomStr = ->
  str = "abcdefghijklmnopqrstuvwxyz"
  (str[Math.floor(Math.random() * str.length)] for index in [1..10]).join ""

module.exports = (robot) ->
  robot.respond /.*(sm\d+)/, (msg) ->
    videoUrl = "http://www.nicovideo.jp/watch/#{msg.match[1]}"
    fileName = "#{randomStr()}.mp3"

    msg.send "#{videoUrl} のエンコードを開始します"
    cmd = "bin/nicovideo-dump #{videoUrl} | ffmpeg -i pipe:0 -ab 196k tmp/#{fileName}"
    exec cmd, (error, stdout, stderr) ->
      console.log('stdout: ' + stdout)
      console.log('stderr: ' + stderr)
      msg.send "#{msg.match[1]} のエンコードが終了しました\n#{process.env.HEROKU_URL}hubot/temp.mp3?id=#{fileName}"
