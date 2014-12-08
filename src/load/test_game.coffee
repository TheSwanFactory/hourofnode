{god} = require('../god')
{load} = require('../load')

exports.test_game = (test, rx) ->
  example = load(rx, {game: 'example', level: 1})

  test 'game load', (t) ->
    t.ok example, 'example'
    t.ok example.is_world(example), 'is world'
    t.end()

  test 'game list', (t) ->
    t.ok list = load(rx, {list: 'test'}), 'list'
    t.ok example.is_world(list), 'list is world'
    t.end()

  test 'game next_params', (t) ->
    t.ok params = example.get('next_params'), 'next_params'
    t.equal params.level, 2, 'level'
    t.ok url = example.get('next_url'), 'next_url'
    t.end()

