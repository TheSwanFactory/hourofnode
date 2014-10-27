{controls} = require('./controls')
exports.layout = {
  path: ""
  rect_path: (world, args) ->
    width = world.get('width')
    height = world.get('height')
    "M0,0 h#{width} v#{height} h-#{width} v-#{height}"
  _LABEL: "layout"
  _CHILDREN: [
    {
      _LABEL: "controls"
      j: (world) -> world.get('split')
      width: (world) -> world.get('size')
      height: 96
      margin: 8
      fill: "#888888"
      stroke: "black"
      path: (world, args) -> world.get('rect_path')
      _AUTHORITY: {
        fill: "#cccccc"
        scale: 96
        transform: (world, args) ->
          scale = world.get('scale')
          margin = world.get('margin')
          x = world.get("_INDEX") * scale + margin
          y = margin
          "translate(#{x},#{y})"
        height: (world) -> world.get('scale') - 2 * world.get('margin')
        width: (world) -> world.get('height')
        name_style: (world) -> 
          margin = world.get('margin')
          middle = world.get('scale') / 2
          {x: middle - margin, y: middle}
      }
      _CHILDREN: [
        ">", ">>", "||","<>", "|<"
      ]
    }
  ]
}