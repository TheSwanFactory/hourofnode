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
    t.ok example.grid_size, 'from source'
    t.ok example.comment, 'from destination'
    t.notOk example.statement, 'no false positive'
    t.end()

  test 'game override', (t) ->
    t.end()

  test 'game extend', (t) ->
    t.end()
  