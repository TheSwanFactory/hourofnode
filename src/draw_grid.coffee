exports.draw_grid = (SVG, world) ->
  grid_size = world.get('size')
  cell_size = world.get('scale')
  draw_leg = (x, y) ->
    size = cell_size * 0.5
    SVG.rect {
      x: x
      y: y
      height: size 
      width: size / 2
      fill: "#00aa00"
    }    
      
  grid_path = ""
  for n in [0..grid_size] by cell_size
    grid_path += "M#{n},1 V#{grid_size-1} M1,#{n} H#{grid_size-1} "
  [
    SVG.rect {
      class: "grid-background"
      height: grid_size 
      width: grid_size 
      fill: "#ccffcc"
      stroke: "black"
    }
    SVG.path {class: "grid-lines", d: grid_path, stroke: "#ffffff"}
  ]
