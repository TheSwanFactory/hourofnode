{my} = require('../my')

ROW_SIZE = 96
MARGIN = 8

ROW_AUTHORITY = {
    fill: my.color.button
    x: (world, args) -> world.index * world.get('scale') + my.margin
    y: (world, args) -> my.margin
    transform: (world, args) ->
      margin = world.get('margin')
      scale = world.get('scale')
      x = world.index * world.get('scale') + my.margin
      y = my.margin
      "translate(#{x},#{y})" # TODO: Refactor
    height: (world) -> world.get('scale') - 4 * world.get('margin')
    width: (world) -> world.get('height')
    name_style: (world) -> 
      margin = world.get('margin')
      middle = world.get('scale') / 2
      {x: middle - margin, y: middle}
    
    click: (world, args) -> world.send world.get('value')
}
exports.inspector = {
  _LABEL: "inspector"
  i: (world) -> world.get('split')
  width: (world) -> world.get('size')
  height: (world) -> world.get('size') + my.control.spacing
  fill: my.color.background
  stroke: "black"
  path: (world, args) -> world.get('rect_path')
  _AUTHORITY: {
    fill: my.color.row
    scale: ROW_SIZE
    transform: (world, args) ->
      scale = world.get('scale')
      margin = world.get('margin')
      x = margin
      y = world.index * scale + margin
      "translate(#{x},#{y})" # TODO: Refactor
    height: (world) -> world.get('scale') - 2 * world.get('margin')
    width: (world) -> world.get('size') - 2 * world.get('margin')
    name_style: (world) -> 
      margin = world.get('margin')
      middle = world.get('scale') / 2
      {x: middle - margin, y: middle}
    
    click: (world, args) -> world.send world.get('value')
  }
  _CHILDREN: [
    {
      _LABEL: 'info'
      _AUTHORITY: ROW_AUTHORITY
      _CHILDREN: [
        {
          name: (world) -> world.get('current').label()
          path: (world) ->
            paths = world.get('current').get('path')
            middle = world.get('scale') / 2.5
            center = "M#{middle},#{middle}"
            paths.unshift center
            console.log paths
            paths
          fill: (world) -> world.get('current').get('fill')
        }
        'name'
        'pos'
        'dir'
      ]
    }
    {
      _LABEL: 'commands'
      _AUTHORITY: ROW_AUTHORITY
      _CHILDREN: []
    }
  ]

}
