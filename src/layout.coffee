#
# layout.coffee
#
# Role: configure the interface for a level
#
# Responsibility:
# * create dictionaries describing the interface elements
# * associate them as children of the level

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

set_font_size = (dict, size) -> dict.name_style = {font_size: size}

exports.layout = (game_dict) ->
  level_dict = game_dict[my.key.children][0]
  console.log "!! layout level_dict", level_dict
  set_font_size(level_dict, 24)
  set_font_size(level_dict._AUTHORITY = {}, 18)
  level_dict.width = game_dict.width / 2
  level_dict['stroke-width'] = 1
  
  level_dict._CHILDREN = [
    header(level_dict)
    controls(level_dict)
    grid(level_dict)
    inspector
  ]
  game_dict
