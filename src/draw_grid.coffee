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
    S.g {class: "grid-lines"},[
      draw_xgrid(cell_size )
      draw_xgrid(2*cell_size )
      draw_ygrid(cell_size )
      draw_ygrid(2*cell_size )
    ]
  ]
