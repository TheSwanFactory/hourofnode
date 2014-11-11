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

    t.equal example.levels.length, 2, 'dest levels'
    t.end()

  test 'game extend', (t) ->
    language = example.language
    t.ok language.victory, 'language from destination'
    t.ok language.left, 'language from source'

    shapes = example.shapes
    t.ok shapes.diamond, 'shapes from destination'
    t.ok shapes.turtle, 'shapes from source'
    t.end()
  