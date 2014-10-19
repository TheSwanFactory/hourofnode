{god} = require('../god')
{draw} = require('../draw')

exports.test_draw = (test, rx) ->
  lab = god(rx, {
    size: 480
    scale: 80
    fill: "green"
    stroke: "black"
    path: "M0,0 L100,100"
  })

  test "draw exists", (t) ->
    t.ok draw, "draw"
    t.ok lab , "lab"
    t.end()

  test "draw lab", (t) ->
    result = draw(lab)
    console.log result
    t.end()
  
