# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

LOG_DIR = 'log'

fs = require('fs')
util = require('util')
dateFormat = require('dateformat')

unless fs.existsSync(LOG_DIR)
  fs.mkdirSync(LOG_DIR)


module.exports = (robot) ->
  robot.hear /.*/, (res) ->
    msg = res.match
    today = dateFormat(new Date(), "yyyymmdd")
    logfile = util.format('%s/%s.log', LOG_DIR, today)

    fs.readFile logfile, 'utf8', (err, data) ->
      if err
        console.warn(err)
        obj = []
      else
        obj = JSON.parse(data)

      obj.push({msg: msg})
      json = JSON.stringify(obj)

      fs.writeFile logfile, json, 'utf8', (err) ->
        if err
          console.log(err)
        else
          console.log('write successfully')
    # res.reply 'ok'
