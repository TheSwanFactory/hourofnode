{my} = require './my'
{render} = require './layout/render'
{controls} = require './layout/controls'
{grid} = require './layout/grid'
{inspector} = require './layout/inspector'
  
exports.layout = {
  _EXPORTS: ["render"]
  render: (world) -> render(world)
  _CHILDREN: [
    controls
    grid
    inspector
  ]
}
