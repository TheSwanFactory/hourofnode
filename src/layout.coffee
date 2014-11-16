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
#     inspector
#       active_sprite.state...

exports.layout = (game_dict) ->
  level_dict = game_dict[my.key.children][0]
  console.log "!! layout level_dict", level_dict
  level_dict.name_style = {font_size: 24}
  level_dict._AUTHORITY = {name_style: {font_size: 18}}
  level_dict.width = game_dict.width / 2
  
  level_dict._CHILDREN = [
    header(level_dict)
    controls(level_dict)
    # grid(level_dict)
    inspector
  ]
  game_dict
