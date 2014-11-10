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

  test 'vector', (t, message) ->
    v_equal = (v1,v2) -> t.ok vector.equal(v1,v2), message

    a = [0, 1]
    b = [1, 0]
    v_equal a,a, "vector equality"
    t.notOk vector.equal(a,b), "vector inequality"

    sum = vector.add(a,b)
    
    t.end()
    