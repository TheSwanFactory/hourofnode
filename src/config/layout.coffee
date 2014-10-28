{controls} = require('./controls')
{grid} = require('./grid')
exports.layout = {
  path: ""
  rect_path: (world, args) ->
    width = world.get('width')
    height = world.get('height')
    "M0,0 h#{width} v#{height} h-#{width} v-#{height}"
  _LABEL: "layout"
  _CHILDREN: [
    grid
    controls
  ]
}