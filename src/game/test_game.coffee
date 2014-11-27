{god} = require('../god')
{game} = require('../game')

exports.test_game = (test, rx) ->
  example = game(rx, {file: 'example', level: 1})

  test 'game load', (t) ->
    t.ok game, 'game'
    t.ok example, 'example'
    t.end()

  test 'game world', (t) ->
    t.ok example
    t.ok shapes = example.get('shapes'), 'shapes'
    t.end()
  