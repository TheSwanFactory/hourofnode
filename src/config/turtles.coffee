draw_leg = (scale, offset, dir) ->
  arc = if dir < 1 then 0 else 1
  "m#{offset*scale},0 l#{scale},#{dir*3*scale}
   a1,2 0 1,#{arc} #{-1*scale},#{-1*dir*3*scale}z m#{-offset*scale},0"
  
draw_legs = (scale) ->
  draw_leg(scale, 1, -1) + draw_leg(scale, 1, 1) + 
  draw_leg(scale, -1, -1) + draw_leg(scale, -1, 1)

draw_face = (scale) ->
  "m#{2.5*scale},0 
   a3,2 0 0,0 #{2*scale},0 
   a3,2 0 0,0 #{-2*scale},0 
   z m#{-3.5*scale},0"
   
draw_eyes = (scale) ->
  "m#{3.3*scale},0.3
   a3,2 0 1,0 #{-0.4*scale},0
   a3,2 0 1,0 #{0.4*scale},0
   z "

draw_shell = (scale) ->
  "m#{-3*scale},0 a3,2 0 1,0 #{6*scale},0 
   m0,0           a3,2 0 1,0 #{-6*scale},0z
  "

exports.turtles = {
  _LABEL: "turtles"
  name: (world, args) ->
    world.label()
  stroke: "green"
  v_i: 1
  v_j: 0
  angle: (world, args) ->
    # TODO: perform real triginometry
    value = 90*(1-world.get('v_i')) #0, 90, 180, 90, 0
    value = -angle if world.get('v_j') == -1
    value
  path: (world, args) -> 
    scale = world.get('scale') / 10
    [
      draw_legs(scale) + draw_face(scale)# + draw_eyes(scale)
      draw_shell(scale)
    ]
  go: (world, args) ->
    world.reset('i', world.get('v_i'))
    world.reset('j', world.get('v_j'))
  turn: (world, args) ->
    {dir} = args
    next_v_i =  dir*world.get('v_j')
    next_v_j = -dir*world.get('v_i')
    world.put('v_i', next_v_i )
    world.put('v_j', next_v_j )
  _AUTHORITY: {
    click: (world, args) ->
      owner = world.owner('current')
      owner.put('current', world)
  }
  _CHILDREN: [
    {
      _LABEL: "me"
      i: 2.5
      j: 1.5
      v_i: 0
      v_j: 1
      fill: "#88ff88"
    }
    {
      _LABEL: "yu"
      i: 1.5
      j: 3.5
      fill: "#008800"
    }
  ]
}