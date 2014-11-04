{my} = require('../my')

#TODO: Add SVG scrollbars a la http://www.carto.net/svg/gui/scrollbar/

COMMANDS = 'commands'
EXECUTING = 'executing'
STRATEGY = 'strategy'
DEFAULT = 'default'

BUTTON_AUTHORITY = {
    fill: my.color.button
    x: (world, args) -> world.index * my.button.spacing + my.margin
    y: my.margin
    height: my.button.size
    width: my.button.size
}

ROW_AUTHORITY = {
    fill: my.color.row
    x: my.margin
    y: (world, args) -> world.index * my.row.spacing + my.margin
    height: (world) -> my.row.size
    width: (world) ->  world.up.get('width') - 2*my.margin
  }

display_commands = (name, programs) ->
  signals = programs.get('signals')
  my.assert signals, "no current signals"
  children = Object.keys(signals).map (command) -> 
    {
      _LABEL: command, name: command
      click: ->
        programs.call('add', {name: DEFAULT, command: command})
        #programs.send 'inspect'
    }
  {_LABEL: name, _AUTHORITY: BUTTON_AUTHORITY, _CHILDREN: children}
  
# TODO: Add ICON authority for smaller command display
display_program = (name, children) ->
  children = children.all() unless _.isArray(children)
  children.unshift {name: name, fill: "white", stroke: "white"}
  {
    _LABEL: name,
    selected: (world) -> 
      counter = world.get('current').get('programs').get('counter')
      counter + 1 == world.index
    _AUTHORITY: BUTTON_AUTHORITY,
    _CHILDREN: children
  }

display_strategy = (strategy, programs) ->
  strategy.reset_children()
  programs.map_children (child) ->
    strategy.add_child display_program(child.label(), child.get('value'))
  strategy.put 'height', my.row.spacing*programs._child_count()
  
set_current = (world, args) ->
  current = world.get('current')
  if args?
    current = args
    world.put('current', current) 
  my.assert current, "No current turtle"
  current

set_selection = (world, counter) ->
  counter += 1
  world.map_children (child) ->
    child.put('selected', true) if child.index == counter
  
exports.inspector = {
  _LABEL: "inspector"
  _EXPORTS: ['inspect', 'step']
  time: 0
  step: (world, args) -> world.update('time', 1)
  inspect: (world, args) ->
    current = set_current(world, args)
    programs = current.get('programs')
    
    world.replace_child display_commands(COMMANDS, programs)
    
    program = programs.get('program')
    my.assert program, "no current program"
    world.replace_child display_program(EXECUTING, program)
        
    strategy = world.find_child(STRATEGY)
    strategy.authority = world.make_world ROW_AUTHORITY
    display_strategy strategy, programs
    
  i: (world) -> world.get('split')
  width: (world) -> world.get('device').width - world.get('size')
  height: (world) -> world.get('size') + my.control.spacing
  fill: my.color.background
  stroke: "black"
  _AUTHORITY: ROW_AUTHORITY
  _CHILDREN: [
    {
      _LABEL: 'info'
      _AUTHORITY: BUTTON_AUTHORITY
      _CHILDREN: [
        { # Show turtle icon
          path: (world) ->
            paths = world.get('current').get('path')
            middle = world.get('scale') / 2.5
            center = "M#{middle},#{middle}"
            paths.unshift center
            paths
          fill: (world) -> world.get('current').get('fill')
        }
        {name: (world) -> world.get('current').label()}
        {
          fill: (world) -> world.get('current').get('fill')
          name: (world) -> world.get('current').get('fill')
          name_style: {x: 30, y: 30, fill: "white", stroke: "white"}
        }
        {
          name: (world) -> world.get('current').get('p').all().toString()
        }
        {name: (world) ->
          v = world.get('current').get('v').all(); "#{v[0]}x#{v[1]}"}
        {name: (world) -> "T: #{world.get('time')}"}
      ]
    }
    COMMANDS
    EXECUTING
    {_LABEL: STRATEGY}
  ]

}
