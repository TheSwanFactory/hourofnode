{my} = require '../my'
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
    right_column = world.get 'size'
    div {id: "layout"}, [
      div {id:'inspector'}, render world.find_child('controls')
      div {id: "controls"}, render world.find_child('controls')
      div {id: "grid"}, draw world.find_child('grid')
    ]
    
  _LABEL: "layout"
  _CHILDREN: [
    controls
    grid
    inspector
  ]
}