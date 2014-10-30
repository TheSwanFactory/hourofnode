{controls} = require('./controls')
{grid} = require('./grid')
{inspector} = require('./inspector')
exports.layout = {
  _EXPORTS: ['created']
  created: (world, args) -> world.add_child args
  path: ""
  rect_path: (world, args) ->
    width = world.get('width')
    height = world.get('height')
    "M0,0 h#{width} v#{height} h-#{width} v-#{height}"
  name_style: (world) -> 
    {x: world.get('height') / 2, y: world.get('width') / 2}
  _LABEL: "layout"
  _CHILDREN: [
    controls
    grid
    inspector
  ]
}