exports.config = {
  size: 480
  split: 6
  grid_path: (world, args) ->
    size = world.get('size')
    split = world.get('split')
    scale = size / split
    path = ""
    for n in [scale..size-1] by scale 
      path  += "M#{n},1 V#{size -1} M1,#{n} H#{size -1} "
    path 
  ME: {
    isa: "turtle"
    i: 3
    j: 3
    fill: "#88ff88"
  }
}
