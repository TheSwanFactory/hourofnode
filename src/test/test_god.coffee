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
    v_equal = (v1,v2, message) -> t.ok vector.equal(v1,v2), message

    a = [0, 1]
    b = [1, 0]
    
    v_equal a,a, "vector equality"
    t.notOk vector.equal(a,b), "vector inequality"
    v_equal vector.add(a,b), [1,1], 'vector add'

    t.equal vector.angle([ 1, 0]),   0, 'vector angle'
    t.equal vector.angle([ 0, 1]),  90, 'vector angle'
    t.equal vector.angle([-1, 0]), 180, 'vector angle'
    t.equal vector.angle([ 0,-1]), -90, 'vector angle'
    
    t.end()
    