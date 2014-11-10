{god} = require('../god')
{game} = require('../game')

exports.test_game = (test, rx) ->
  world = god(rx, config)

  test 'game load', (t) ->
    t.ok game, 'game'
    t.ok example = game 'example', 'example'
    t.end()
  