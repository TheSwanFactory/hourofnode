{god} = require('../god')
{draw} = require('../draw')

exports.test_draw = (test, rx) ->
  solo = god(rx, {
    size: 480
    scale: 80
    fill: "green"
    stroke: "black"
    path: "M0,0 L100,100"
  })

  family = god(rx, {
    size: 480
    scale: 80
    fill: "red"
    stroke: "black"
    _CHILDREN: [
      {path: "M0,0 L100,100"}
      {path: "M100,0 L0,100"}
#      {path: ["M50,0 L0,50", "M0,50 L50,0"]}
    ]
  })

  test "draw exists", (t) ->
    t.ok draw, "draw"
    t.ok solo, "solo"
    t.ok family, "family"
    t.end()

  test "draw solo", (t) ->
    result = draw(solo)
    t.end()
  
  test "draw family", (t) ->
    result = draw(family)
    t.end()
  
