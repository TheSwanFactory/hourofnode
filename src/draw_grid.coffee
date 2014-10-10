exports.draw_grid = (S, grid_size, grid_split) ->
  cell_size = grid_size / grid_split
  draw_leg = (x, y) ->
    size = cell_size * 0.5
    S.rect {
      x: x
      y: y
      height: size 
      width: size / 2
      fill: "#00aa00"
    }
  draw_turtle = (i, j) ->
    length = cell_size * 0.7
    width = cell_size * 0.5
    x = i*cell_size
    y = j*cell_size
    head = x + length
    half_width = width / 2
    S.g {class: "turtle"}, [
      S.circle {
        class: "head"
        cx: head, cy: y
        r: half_width
        fill: "#00aa00"
      }
      S.g {class: "legs"}, [
        draw_leg(x+half_width, y+half_width)
        draw_leg(x-width, y+half_width)
        draw_leg(x+half_width, y-3*half_width)
        draw_leg(x-width, y-3*half_width)
      ]
      S.ellipse {
        class: "body"
        cx: x, cy: y
        rx: length, ry: width
        fill: "#00ff00"
        stroke: "#88ff88"
      }
    ]
  draw_arc = (width, x_sign, y_sign) ->
    "a#{width},#{width} 0 0,1 #{x_sign*width},#{y_sign*width} "
  draw_flipper = (width, x_sign, y_sign) ->
    draw_arc(width, x_sign, y_sign) + draw_arc(width, -1*x_sign, -1*y_sign)
        
  draw_turtle_path = (i, j) ->
    width = cell_size / 2
    x = i*cell_size
    y = j*cell_size
    path = "M#{x},#{y} "
    for offset in [[1,1], [1,-1], [-1,1], [-1,-1]] 
      path += draw_flipper(width, offset[0], offset[1])
    S.path {class: "path-turtle", d: path, stroke: "#00ff00", fill: "#88ff88"}
      
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
    draw_turtle(2,4)
    draw_turtle_path(1,2)
  ]
