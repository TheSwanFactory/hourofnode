{god} = require('../god')
{game} = require('../game')

exports.test_game = (test, rx) ->
  example = game({name: 'example', level: 1})

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

  test 'level select', (t) ->
    t.equal example.levels.length, 2, 'two levels present'
    t.ok example._CHILDREN, 'children present'
    t.equal example._CHILDREN.length, 1, 'one level selected'
    
    level = example._CHILDREN[0]
    t.equal level.sprites.length, 3, 'level 1 selected'
    t.end()

  test 'game world', (t) ->
    t.ok world = god(rx, example), 'world'
    t.ok shapes = world.get('shapes'), 'shapes'
    t.end()
  