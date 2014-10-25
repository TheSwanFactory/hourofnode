exports.layout = {
  path: ""
  _LABEL: "layout"
  _CHILDREN: [
    {
      _LABEL: "controls"
      j: (world) -> world.get('split')
      height: 96
      fill: "#cccccc"
      stroke: "black"
      path: (world, args) ->
        size = world.get('size')
        height = world.get('height')
        "M0,0 h#{size} v#{height } h-#{size} v-#{height}"
    }
  ]
}