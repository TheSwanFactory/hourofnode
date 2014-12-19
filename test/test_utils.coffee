{utils} = require '../src/utils'

describe 'Utils', ->
  describe 'storage', ->
    beforeEach ->
      localStorage.clear()

    describe 'store', ->
      it 'stores key/value pairs', ->
        utils.store 'key', 'value'
        assert.equal localStorage['key'], 'value'

      it 'stores objects', ->
        utils.store key: 'value', name: 'Daniel'
        assert.equal localStorage['key'],  'value'
        assert.equal localStorage['name'], 'Daniel'

    describe 'fetch', ->
      it 'fetches keys', ->
        localStorage['key'] = 'value'
        assert.equal utils.fetch('key'), 'value'

      it 'fetches array', ->
        localStorage['key']  = 'value'
        localStorage['name'] = 'Daniel'

        assert.ok _.isEqual(utils.fetch(['key', 'name']), ['value', 'Daniel'])

      it 'fetches object', ->
        localStorage['key']  = 'value'
        localStorage['name'] = 'Daniel'

        assert.ok _.isEqual(utils.fetch_object(['key', 'name']), {key: 'value', name: 'Daniel'})

    describe 'type casting', ->
      it 'fetches booleans', ->
        utils.store 'happy', true
        utils.store 'angry', false

        assert.equal utils.fetch('happy'), true
        assert.equal utils.fetch('angry'), false

      it 'fetches integers', ->
        utils.store 'hours', 40

        assert.equal utils.fetch('hours'), 40

      it 'fetches floats', ->
        utils.store 'minutes', 3.5

        assert.equal utils.fetch('minutes'), 3.5

      it 'fetches strings', ->
        utils.store 'string', 'hello'

        assert.equal utils.fetch('string'), 'hello'
