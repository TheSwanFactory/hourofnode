{my} = require('../my')

BUTTON_AUTHORITY = {
    fill: my.color.button
    x: (world, args) -> world.index * my.button.spacing + my.margin
    y: my.margin
    height: my.button.size
    width: my.button.size
    click: (world, args) -> world.send world.get('value')
}
exports.inspector = {
  _LABEL: "inspector"
  _EXPORTS: ['inspect']
  inspect: (world, args) ->
    world.put('current', args)
    
  i: (world) -> world.get('split')
  width: (world) -> world.get('device').width - world.get('size')
  height: (world) -> world.get('size') + my.control.spacing
  path: (world, args) -> world.get('rect_path')
  fill: my.color.background
  stroke: "black"
  _AUTHORITY: { # ROW Configuration
    fill: my.color.row
    x: my.margin
    y: (world, args) -> world.index * my.row.spacing + my.margin
    height: (world) -> my.row.size
    width: (world) ->  world.up.get('width') - 2*my.margin
    click: (world, args) -> world.send world.get('value')
  }
  _CHILDREN: [
    {
      _LABEL: 'info'
      _AUTHORITY: BUTTON_AUTHORITY
      _CHILDREN: [
        { # Show turtle icon
          name: (world) -> world.get('current').label()
          path: (world) ->
            paths = world.get('current').get('path')
            middle = world.get('scale') / 2.5
            center = "M#{middle},#{middle}"
            paths.unshift center
            paths
          fill: (world) -> world.get('current').get('fill')
        }
        {name: (world) -> world.get('current').label()}
        {name: (world) ->
          c = world.get('current'); "#{c.get('i')},#{c.get('j')}"}
        {name: (world) ->
          c = world.get('current'); "#{c.get('v_i')}x#{c.get('v_j')}"}
      ]
    }
    {
      _LABEL: 'commands'
      _AUTHORITY: BUTTON_AUTHORITY
      _CHILDREN: []
    }
  ]

}
