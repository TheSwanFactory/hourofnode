{god} = require('../src/god')
{vector} = require('../src/god/vector')
rx = require 'reactive-coffee'

exports.test_god = ->
  describe 'God', ->
    it 'exists', ->
      assert.ok god

    it 'creates a root world', ->
      world = god rx, key: 'value'
      assert.ok world
      assert.equal world.get('key'), 'value'

  describe 'Vector', ->
    it 'works', ->
      v_equal = (v1,v2, msg) ->
        assert.equal vector.x(v1), vector.x(v2), "#{msg}[X]"
        assert.equal vector.y(v1), vector.y(v2), "#{msg}[Y]"

      a = [0, 1]
      b = [1, 0]
      ra = rx.array a
      
      v_equal a,a, "vector equality"
      assert.notOk vector.equal(a,b), "vector inequality"

      v_equal ra, a, "rx vector equality"
      assert.notOk vector.equal(ra,b), "rx vector inequality"
      
      v_equal vector.add(ra,b), [1,1], 'vector add'
      v_equal vector.subtract(ra,b), [-1,1], 'vector subtract'

      fired = false
      err = -> fired = true
      v_equal vector.bound([4,-1], 3, err), [2,0], "bounds check"
      assert.ok fired, "error callback fired"

      assert.ok vector.inside([1, 0], 2), "is inside"
      assert.notOk vector.inside([2, 0], 2), "is above"
      assert.notOk vector.inside([1, -1], 2), "is below"
      assert.notOk vector.inside([2, -1], 2), "is both"
      
      assert.equal vector.angle([ 1, 0]),   0, 'vector angle'
      assert.equal vector.angle([ 0, 1]),  90, 'vector angle'
      assert.equal vector.angle([-1, 0]), 180, 'vector angle'
      assert.equal vector.angle([ 0,-1]), -90, 'vector angle'

      v_equal vector.turn(a, vector.to.left), b, "turn left"
      v_equal vector.turn(b, vector.to.right), a, "turn right"