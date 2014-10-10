exports.draw_grid = (S, grid_size, grid_split) ->
  cell_size = grid_size / grid_split
  draw_xgrid = (x) ->
    S.path {d: "M#{x},1 V#{grid_size-1}", stroke: "#ffffff"}
  draw_ygrid = (y) ->
    S.path {d: "M1,#{y} H#{grid_size-1}", stroke: "#ffffff"}
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
      S.ellipse {
        class: "body"
        cx: x, cy: y
        rx: length, ry: width
        fill: "#00ff00"
        stroke: "#88ff88"
      }
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
    ]
  [
    S.rect {
      class: "grid-background"
      height: grid_size 
      width: grid_size 
      fill: "#ccffcc"
      stroke: "black"
    }
    S.g {class: "grid-lines"},[1..grid_split-1].map (n) ->
      S.g {class: "grid-lines n#{n}"}, [
        draw_xgrid(n*cell_size)
        draw_ygrid(n*cell_size)
      ]
    draw_turtle(2,4)
  ]
