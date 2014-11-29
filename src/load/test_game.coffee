{god} = require('../god')
{load} = require('../load')

exports.test_game = (test, rx) ->
  example = load(rx, {game: 'example', level: 1})

  test 'game load', (t) ->
    t.ok load, 'load'
    t.ok example, 'example'
    t.end()

  test 'game world', (t) ->
    t.ok example
    t.ok shapes = example.get('shapes'), 'shapes'
    t.end()
  