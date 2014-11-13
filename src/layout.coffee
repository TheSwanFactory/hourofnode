# layout.coffee
#
# Role: generate the user interface for a game level
#
# Responsibility:
# * export and invoke a render method
# * create game state objects
# * create sprite state objects for each sprite
# * ensure only the currently-selected sprite's state is ddisplay

{my} = require './my'
{render} = require './render'
{header} = require './layout/header'
{controls} = require './layout/controls'
{grid} = require './layout/grid'
{inspector} = require './layout/inspector'
  
views = {
  _EXPORTS: ["render"]
  render: (world) -> render(world)
  _CHILDREN: [
    header
    controls
    grid
    inspector # select which sprite_state to display
  ]
}

exports.layout = (game_level) ->
  game_level._CHILDREN = [views]
  