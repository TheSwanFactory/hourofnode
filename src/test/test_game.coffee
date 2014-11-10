{god} = require('../god')
{game} = require('../game')

exports.test_game = (test, rx) ->
  #world = god(rx, config)
  example = game({name: 'example'})

  test 'game load', (t) ->
    t.ok game, 'game'
    t.ok example, 'example'
    t.ok example.name, 'has name property'
    t.end()

  test 'game merge', (t) ->
    t.end()

  test 'game override', (t) ->
    t.end()

  test 'game extend', (t) ->
    t.end()
  