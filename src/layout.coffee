# layout.coffee
# Role: describe the user interface for a game
# Responsibility:
# * export and invoke a render method
# * display the state of the game
# * display the state of the current sprite

# TODO: Move views into a different folder than layout tools

{my} = require './my'
{render} = require './render'
{header} = require './layout/header'
{controls} = require './layout/controls'
{grid} = require './layout/grid'
{inspector} = require './layout/inspector'
  
exports.layout = {
  _EXPORTS: ["render"]
  render: (world) -> render(world)
  _CHILDREN: [
    header
    controls
    grid
    inspector # select which sprite_state to display
  ]
}
