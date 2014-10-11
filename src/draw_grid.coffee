exports.draw_grid = (S, grid_size, cell_size) ->
  draw_leg = (x, y) ->
    size = cell_size * 0.5
    S.rect {
      x: x
      y: y
      height: size 
      width: size / 2
      fill: "#00aa00"
    }
  draw_arc = (width, x_sign, y_sign) ->
    "a#{width},#{width} 0 0,1 #{x_sign*width},#{y_sign*width} "
  draw_ellipse = (width, x_sign, y_sign) ->
    draw_arc(width, x_sign, y_sign) + draw_arc(width, -1*x_sign, -1*y_sign)
        
  draw_turtle_path = (i, j) ->
    width = cell_size / 2
    x = i*cell_size
    y = j*cell_size
    path = "M#{x},#{y} "
    for offset in [[1,1], [1,-1], [-1,1], [-1,-1]] 
      path += draw_ellipse(width, offset[0], offset[1])
    head = cell_size / 4
    path += "m#{width / 3},0 " + draw_ellipse(head, 2,0)
    shell = cell_size * 2 / 3
    path += "m#{width / 2},0 " + draw_ellipse(shell , -3 / 2,0)
    S.path {class: "path-turtle", d: path, fill: "#88ff88"}
    
      
  grid_path = ""
  for n in [0..grid_size] by cell_size
    grid_path += "M#{n},1 V#{grid_size-1} M1,#{n} H#{grid_size-1} "
  [
    S.rect {
      class: "grid-background"
      height: grid_size 
      width: grid_size 
      fill: "#ccffcc"
      stroke: "black"
    }
    S.path {class: "grid-lines", d: grid_path, stroke: "#ffffff"}
    draw_turtle_path(1,2)
  ]
