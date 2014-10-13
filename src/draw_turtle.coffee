draw_leg = (scale, offset, dir) ->
  arc = if dir < 1 then 0 else 1
  "m#{offset*scale},0 l#{scale},#{dir*3*scale}
   a1,2 0 1,#{arc} #{-1*scale},#{-1*dir*3*scale}z m#{-offset*scale},0"
  
draw_legs = (scale) ->
  draw_leg(scale, 1, -1) + draw_leg(scale, 1, 1) + 
  draw_leg(scale, -1, -1) + draw_leg(scale, -1, 1)

draw_face = (scale, dir) ->
  "m#{dir*3.5*scale},0 
   a20,#{10+dir*5} 0 0,0 #{2*dir*scale},0 
   a20,#{10-dir*5} 0 0,0 #{-2*dir*scale},0 
   z "
   
draw_faces = (scale, dir) ->
  draw_face(scale, 1) + draw_face(scale, -1)

draw_tail = (scale, dir) ->
  "m#{-3.2*scale},#{dir*0.3}
   a3,2 0 1,0 #{-0.4*scale},0
   a3,2 0 1,0 #{0.4*scale},0
   z "
draw_tails = (scale, dir) ->
  draw_tail(scale, 1) + draw_tail(scale, -1)

draw_shell = (scale) ->
  "m#{-3*scale},0 a3,2 0 1,0 #{6*scale},0 
   m0,0           a3,2 0 1,0 #{-6*scale},0z
  "

exports.draw_turtle = {
    stroke: "green"
    rel_paths: (world, args) -> 
      scale = world.get('scale') / 10
      console.log(scale)
      [
        draw_legs(scale) #+ draw_faces(scale) + draw_tails(scale)
        draw_shell(scale)
      ] 
    children: {
      ME: {
        i: 3
        j: 3
        fill: "#88ff88"
        path: (world, args) -> 
          scale = world.get('scale')
          x = world.get('i') + 0.5 * scale
          y = world.get('j') + 0.5 * scale
          rel_paths = world.call('rel_paths', args)
          ("M#{x},#{y} " + path for path in rel_paths)
      }
    }
  }