{my} = require '../my'
{sprites} = require './sprites'

exports.grid = {
  _LABEL: "grid"
  paths: []
  _CHILDREN: [
    {
      _LABEL: "background"
      fill: my.color.grid
      stroke: "black"
      paths: (world) ->
        size = world.get('size')
        ["M0,0 h#{size} v#{size} h-#{size} v#{-size}"]
    }
    {
      _LABEL: "gridlines"
      stroke: my.color.gridline
      paths: (world) ->
        size = world.get('size')
        scale = world.get('scale')
        path = ""
        for n in [scale..size-1] by scale 
          path  += "M#{n},1 V#{size - 1} M1,#{n} H#{size - 1} "
        [path] 
    }
    #sprites
  ]
}