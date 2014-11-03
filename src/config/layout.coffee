{render} = require('../util/render')
{draw} = require('../util/draw')
{controls} = require('./controls')
{grid} = require('./grid')
{inspector} = require('./inspector')
exports.layout = {
  path: ""
  rect_path: (world, args) ->
    width = world.get('width')
    height = world.get('height')
    "M0,0 h#{width} v#{height} h-#{width} v-#{height}"
  name_style: (world) -> 
    {x: world.get('height') / 2, y: world.get('width') / 2}
  render: (world) ->
    div = world.T().div
    div {id: "layout"}, [
      div {id: "controls"}
      div {id: "grid"}, draw world.find_child('grid')
      div {id: "inspector"}
    ]
    
  _LABEL: "layout"
  _CHILDREN: [
    #controls
    grid
    #inspector
  ]
}