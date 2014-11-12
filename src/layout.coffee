{my} = require './my'
{controls} = require './layout/controls'
{grid} = require './layout/grid'
{inspector} = require './layout/inspector'
  
exports.layout = {
  _EXPORTS: ["render"]
  _CHILDREN: [
    controls
    grid
    inspector
  ]
}
