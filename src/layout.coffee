#
# layout.coffee
#
# Role: generate interface dictionary for a game dictionary
#
# Responsibility:
# * export and invoke a render method
# * create game state objects
# * create sprite state objects for each sprite
# * ensure only the currently-selected sprite's state is ddisplay

{my} = require './my'
{vector} = require './god/vector'
{render} = require './render'

{header} = require './layout/header'
{controls} = require './layout/controls'
{grid} = require './layout/grid'
{inspector} = require './layout/inspector'

# Desired Structure
# game
#   level
#     header
#     controls
#     grid
#       sprite1
#       sprite2...
#     <-- state...

exports.layout = (game_dict) ->
  size = game_dict.page_dimensions
  level_dict = game_dict[my.key.children][0]
  console.log "!! layout level_dict", level_dict

  level_dict.height = size[vector.size.height]
  level_dict.width = size[vector.size.width]
  level_dict.fill = 'azure'
  level_dict.stroke = 'black'
  
  level_dict._AUTHORITY = {height: 'auto', width: 'auto', stroke: undefined}
  level_dict._CHILDREN = [
    header(level_dict)
    # controls(level_dict)
    # grid(level_dict)
    # sprites?
    # inspector?
  ]
  game_dict
