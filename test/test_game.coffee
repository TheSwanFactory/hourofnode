{god} = require('../src/god')
{load} = require('../src/load')

exports.test_game = ->
  example = load(rx, {game: 'example', level: 1})
  describe 'Game', ->
    it 'loads', ->
      assert.ok example, 'example'
      assert.ok example.is_world(example), 'is world'

    it 'lists', ->
      assert.ok list = load(rx, {list: 'test'}), 'list'
      assert.ok example.is_world(list), 'list is world'

    it '#next_params', ->
      assert.ok params = example.get('next_params'), 'next_params'
      assert.equal params.level, 2, 'level'
      assert.ok url = example.get('next_url'), 'next_url'

