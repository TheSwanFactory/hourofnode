{god} = require('../god')
{game} = require('../load')

exports.test_game = (test, rx) ->
  example = game(rx, {file: 'example', level: 1})

  test 'game load', (t) ->
    t.ok game, 'load'
    t.ok example, 'example'
    t.end()

  test 'game world', (t) ->
    t.ok example
    t.ok shapes = example.get('shapes'), 'shapes'
    t.end()
  