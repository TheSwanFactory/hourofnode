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

exports.layout = (game_dict) ->
  level_dict = game_dict[my.key.children][0]
  level_dict.width = game_dict.width / 2
  level_dict['stroke-width'] = 1
  
  level_dict._CHILDREN = [
    header(level_dict)
    controls(level_dict)
    grid(level_dict)
    inspector
  ]
  game_dict
