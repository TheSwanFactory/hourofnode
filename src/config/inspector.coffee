{my} = require('../my')

BUTTON_AUTHORITY = {
    fill: my.color.button
    x: (world, args) -> world.index * my.button.spacing + my.margin
    y: my.margin
    height: my.button.size
    width: my.button.size
    click: (world, args) -> world.send world.get('value')
}

ROW_AUTHORITY = {
    fill: my.color.row
    x: my.margin
    y: (world, args) -> world.index * my.row.spacing + my.margin
    height: (world) -> my.row.size
    width: (world) ->  world.up.get('width') - 2*my.margin
    click: (world, args) -> world.send world.get('value')
  }

display_program = (name, commands) ->
  children = commands.all()
  children.unshift {name: name, fill: "white", stroke: "white"}
  {
    _LABEL: name
    _AUTHORITY: BUTTON_AUTHORITY
    _CHILDREN: children
  }

display_strategy = (strategy, programs) ->
  strategy.reset_children()
  programs.map_children (child) ->
    strategy.add_child display_program(child.label(), child.get('value'))
  strategy.put 'height', my.row.spacing*programs._child_count()
  
exports.inspector = {
  _LABEL: "inspector"
  _EXPORTS: ['inspect']
  inspect: (world, args) ->
    current = args
    my.assert world.is_world current, "can only inspect worlds"
    world.put('current', current)
    strategy = world.find_child('strategy')
    strategy.authority = world.make_world ROW_AUTHORITY
    programs = current.get('programs')
    display_strategy strategy, programs
    
  i: (world) -> world.get('split')
  width: (world) -> world.get('device').width - world.get('size')
  height: (world) -> world.get('size') + my.control.spacing
  path: (world, args) -> world.get('rect_path')
  fill: my.color.background
  stroke: "black"
  _AUTHORITY: ROW_AUTHORITY
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
    'commands'
    'program'
    {_LABEL: 'strategy'}
  ]

}
