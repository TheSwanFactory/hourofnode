{draw} = require('../draw')

exports.test_draw = (test, rx) ->
  test "draw exists", (t) ->
    t.ok draw
    t.end()
  
