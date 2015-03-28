querystring = require('querystring')
fs = require('fs')
path = require('path')

module.exports = (robot) ->
  robot.router.get "/hubot/temp.mp3", (req, res) ->
    query = querystring.parse(req._parsedUrl.query)
    tmp = path.join(__dirname, '..', 'tmp',query.id)
    fs.exists tmp, (exists) ->
      if exists
        fs.readFile tmp,(err,data) ->
          res.writeHead(200, {'Content-Type': 'audio/mpeg'})
          res.end(data);
      else
        res.status(404).send('Not found')
