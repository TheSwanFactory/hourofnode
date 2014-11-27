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

exports.layout = [
    header
    controls
    grid
    inspector
  ]
