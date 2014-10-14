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

exports.draw_turtle = {
    stroke: "green"
    transform: (world, args) ->
      console.log('turtle.transform')
      console.log(world)
      scale = world.get('scale')
      x = world.get('i') + 0.5 * scale
      y = world.get('j') + 0.5 * scale
      # TODO: perform real triginometry
      angle = 90*(1-world.get('v_i')) #0, 90, 180, 90, 0
      angle = -angle if world.get('v_j') == -1
      "translate(#{x},#{y}) rotate(#{angle})"
    path: (world, args) -> 
      scale = world.get('scale') / 10
      [
        draw_legs(scale) + draw_face(scale)# + draw_eyes(scale)
        draw_shell(scale)
      ]
    children: {
      ME: {
        i: 4
        j: 4
        v_i: 0
        v_j: -1
        fill: "#88ff88"
      }
    }
  }