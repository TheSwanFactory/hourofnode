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
      
  grid_path = world.call('grid_path')
  [
    SVG.rect {
      class: "grid-background"
      height: grid_size 
      width: grid_size 
      fill: "#ccffcc"
      stroke: "black"
    }
    #SVG.text {x: 100, y:100}, config_path.toString()
    SVG.path {class: "grid-lines", d: grid_path, stroke: "#ffffff"}
  ]
