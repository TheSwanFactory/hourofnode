{my} = require '../my'
{render} = require('../util/render')
{draw} = require('../util/draw')
{controls} = require('./controls')
{grid} = require('./grid')
{inspector} = require('./inspector')
  
exports.layout = {
  _EXPORTS: ["render"]
  i: 0
  j: 0
  x: (world) -> world.get('scale') * world.get('i')
  y: (world) -> world.get('scale') * world.get('j')
  angle: 0
  translate: (world) -> "translate(#{world.get('x')},#{world.get('y')})"
  rotate: (world) -> "rotate(#{world.get('angle')})"
  transform: (world) -> "#{world.get('translate')} #{world.get('rotate')}"
  rect_path: (world, args) ->
    width = world.get('width')
    height = world.get('height')
    "M0,0 h#{width} v#{height} h-#{width} v-#{height}"
  name_style: (world) -> 
    {x: world.get('height') / 2, y: world.get('width') / 2}
  render: (world) -> render(world)
  border: (world) -> 
    if world.get('selected')
      "3px solid goldenrod" 
    else
      "1px solid #{world.get('stroke')}"
  _LABEL: "layout"
  _CHILDREN: [
    controls
    grid
    inspector
  ]
}