exports.draw_grid = {
  _CHILDREN: [
    {
      fill: "#ccffcc"
      stroke: "black"
      path: (world, args) ->
        size = world.get('size')
        "M0,0 h#{size} v#{size} h-#{size} v#{-size}"
    }
    {
      stroke: "white"
      path: (world, args) ->
        size = world.get('size')
        scale = world.get('scale')
        path = ""
        for n in [scale..size-1] by scale 
          path  += "M#{n},1 V#{size - 1} M1,#{n} H#{size - 1} "
        path 
    }
  ]
}