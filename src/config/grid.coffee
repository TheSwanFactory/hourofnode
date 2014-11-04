{my} = require('../my')
exports.grid = {
  _LABEL: "grid"
  path: ""
  _CHILDREN: [
    {
      _LABEL: "background"
      fill: my.color.grid
      stroke: "black"
      path: (world, args) ->
        size = world.get('size')
        "M0,0 h#{size} v#{size} h-#{size} v#{-size}"
    }
    {
      _LABEL: "gridlines"
      stroke: my.color.gridline
      path: (world, args) ->
        size = world.get('size')
        scale = world.get('scale')
        path = ""
        for n in [scale..size-1] by scale 
          path  += "M#{n},1 V#{size - 1} M1,#{n} H#{size - 1} "
        path 
    }
    {
      _LABEL: "sprites"
      _EXPORTS: ['created']
      created: (world, args) ->
        child = args
        my.assert world.is_world child
        world.add_child child 
        world.send 'inspect', child
    }
  ]
}