{god} = require('../god')
{vector} = require('../god/vector')

exports.test_god = (test, rx) ->
  test 'god exists', (t) ->
    t.ok god, "god"
    t.end()

  test 'god creates root world', (t) ->
    world = god(rx, {key: "value"})
    t.ok world, "world"
    t.equal world.get("key"), "value"
    t.end()

  test 'vector', (t) ->
    v_equal = (v1,v2, msg) ->
      t.equal vector.x(v1), vector.x(v2), "#{msg}[X]"
      t.equal vector.y(v1), vector.y(v2), "#{msg}[Y]"

    a = [0, 1]
    b = [1, 0]
    ra = rx.array a
    
    v_equal a,a, "vector equality"
    t.notOk vector.equal(a,b), "vector inequality"

    v_equal ra, a, "rx vector equality"
    t.notOk vector.equal(ra,b), "rx vector inequality"
    
    v_equal vector.add(ra,b), [1,1], 'vector add'
    v_equal vector.subtract(ra,b), [-1,1], 'vector subtract'

    fired = false
    err = -> fired = true
    v_equal vector.bound([4,-1], 3, err), [2,0], "bounds check"
    t.ok fired, "error callback fired"

    t.ok vector.inside([1, 0], 2), "is inside"
    t.notOk vector.inside([2, 0], 2), "is above"
    t.notOk vector.inside([1, -1], 2), "is below"
    t.notOk vector.inside([2, -1], 2), "is both"
    
    t.equal vector.angle([ 1, 0]),   0, 'vector angle'
    t.equal vector.angle([ 0, 1]),  90, 'vector angle'
    t.equal vector.angle([-1, 0]), 180, 'vector angle'
    t.equal vector.angle([ 0,-1]), -90, 'vector angle'

    v_equal vector.turn(a, vector.to.left), b, "turn left"
    v_equal vector.turn(b, vector.to.right), a, "turn right"
    t.end()
    
