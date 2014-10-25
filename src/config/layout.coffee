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
      fill: "#cccccc"
      stroke: "black"
      path: (world, args) -> world.get('rect_path')
      _CHILDREN: [
      ]
    }
  ]
}