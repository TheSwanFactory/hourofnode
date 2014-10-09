exports.draw_grid = (S, grid_size, grid_split) ->
  cell_size = grid_size / grid_split
  draw_xgrid = (x) ->
    S.line {
      x1: x, y1: 1
      x2: x, y2: grid_size-1
      stroke: "#ffffff"
    }
  draw_ygrid = (y) ->
    S.line {
      x1: 1,           y1: y
      x2: grid_size-1, y2: y
      stroke: "#ffffff"
    }
  [
    S.rect {
      height: grid_size 
      width: grid_size 
      fill: "#ccffcc"
      stroke: "black"
    }
    S.g {class: "xgrid-lines"},[1..grid_split-1].map (n) ->
      draw_xgrid(n*cell_size)
    S.g {class: "ygrid-lines"},[1..grid_split-1].map (n) ->
      draw_ygrid(n*cell_size)
  ]
