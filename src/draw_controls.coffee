exports.controls = {
    fill: "grey"
    stroke: "black"
    path: (world, args) -> 
      size = world.get('scale')
      "M0,0 h#{size} v#{size} h-#{size} v#{-size}"
      # TODO: Create high-level rect path
}
