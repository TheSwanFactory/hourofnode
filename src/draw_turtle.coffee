arc_path = (width, x_sign, y_sign) ->
  "a#{width},#{width} 0 0,1 #{x_sign*width},#{y_sign*width} "
ellipse_path = (width, x_sign, y_sign) ->
  arc_path(width, x_sign, y_sign) + arc_path(width, -1*x_sign, -1*y_sign)
turtle_path = (cell_size) ->
  path = ""
  width = cell_size / 2
  for offset in [[1,1], [1,-1], [-1,1], [-1,-1]] 
    path += ellipse_path(width, offset[0], offset[1])
  head = cell_size / 4
  path += "m#{width / 3},0 " + ellipse_path(head, 2,0)
  shell = cell_size * 2 / 3
  path += "m#{width / 2},0 " + ellipse_path(shell , -3 / 2,0)

exports.draw_turtle = (SVG, world) ->
  cell_size = world.get('scale')
  me = world.get("ME")
  x = me.bind -> me.get("i") * cell_size
  y = me.bind -> me.get("j") * cell_size
  path = me.bind -> "M#{x.get()},#{y.get()} " + turtle_path(cell_size)
  SVG.path {class: "path-turtle", d: path, fill: "#88ff88"}
