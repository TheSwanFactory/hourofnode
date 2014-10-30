{my} = require('../my')

BUTTON_AUTHORITY = {
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
  path: (world, args) -> world.get('rect_path')
  fill: my.color.background
  stroke: "black"
  _AUTHORITY: { # ROW Configuration
    fill: my.color.row
    x: my.margin
    y: (world, args) -> world.index * my.row.spacing + my.margin
    height: (world) -> my.row.size
    width: (world) -> world.get('size') - 2 * my.margin
    click: (world, args) -> world.send world.get('value')
  }
  _CHILDREN: [
    {
      _LABEL: 'info'
      _AUTHORITY: BUTTON_AUTHORITY
      _CHILDREN: [
        {
          name: (world) -> world.get('current').label()
          path: (world) ->
            paths = world.get('current').get('path')
            middle = world.get('scale') / 2.5
            center = "M#{middle},#{middle}"
            paths.unshift center
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
      _AUTHORITY: BUTTON_AUTHORITY
      _CHILDREN: []
    }
  ]

}
