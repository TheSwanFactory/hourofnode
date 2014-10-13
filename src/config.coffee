exports.config = {
  size: 480
  split: 6
  scale: (world, args) ->
    world.get('size') / world.get('split')
  paths: {
    background: {
      fill: "#ccffcc"
      stroke: "black"
      path: (world, args) ->
        size = world.get('size')
        "M0,0 h#{size / 2 } v#{size} h-#{size} v#{-size}"
    }
  }
  grid_path: (world, args) ->
    size = world.get('size')
    scale = world.get('scale')
    path = ""
    for n in [scale..size-1] by scale 
      path  += "M#{n},1 V#{size - 1} M1,#{n} H#{size - 1} "
    path 
  ME: {
    isa: "turtle"
    i: 3
    j: 3
    fill: "#88ff88"
  }
}
