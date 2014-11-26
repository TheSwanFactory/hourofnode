{my} = require '../my'
{sprites} = require './sprites'
{law} = require './mixins/law'

exports.grid = () -> {
  _LABEL: "grid"
  height: (world) -> world.get('grid_size')
  width: (world) -> world.get('grid_size')
  paths: []
  obstruction: true
  _CHILDREN: [
    {
      _LABEL: "background"
      fill: my.color.grid
      stroke: "black"
      paths: (world) ->
        size = world.get_plain('grid_size')
        ["M0,0 h#{size} v#{size} h-#{size} v#{-size}"]
    }
    {
      _LABEL: "gridlines"
      stroke: my.color.gridline
      paths: (world) ->
        size = world.get_plain('grid_size')
        cell = world.get_plain('cell_size')
        path = ""
        for n in [cell..size-1] by cell 
          path  += "M#{n},1 V#{size - 1} M1,#{n} H#{size - 1} "
        [path] 
    }
    sprites
    law
  ]
}
