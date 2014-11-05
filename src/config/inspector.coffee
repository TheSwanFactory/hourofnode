{my} = require('../my')

#TODO: Add SVG scrollbars a la http://www.carto.net/svg/gui/scrollbar/

COMMANDS = 'commands'
EXECUTING = 'executing'
STRATEGY = 'strategy'
TARGET = 'buffer:'

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

# TODO: Add ICON authority for smaller command display
COMMAND_AUTHORITY = $.extend {}, BUTTON_AUTHORITY # shallow copy
COMMAND_AUTHORITY['selected'] = (world) ->
  return false unless world.up.get('selected')
  world.index == world.get('current').get('programs').get('counter') + 1 

display_commands = (name, programs) ->
  signals = programs.get('signals')
  children = Object.keys(signals).map (command) -> 
    {
      _LABEL: command, name: command
      click: (world) ->
        world.send 'command', {name: TARGET, command: command}
        world.get('current').call 'perform', signals[command]
        # TODO: Make this a command event on sprites
    }
  {_LABEL: name, _AUTHORITY: BUTTON_AUTHORITY, _CHILDREN: children}

display_program = (name, children) ->
  children = children.all() unless _.isArray(children)
  children.unshift {name: name, fill: "white", stroke: "white"}
  {
    _LABEL: name,
    selected: (world) -> 
      name == world.get('current').get('programs').get('current')
    _AUTHORITY: COMMAND_AUTHORITY
    _CHILDREN: children
  }

display_strategy = (strategy, programs) ->
  strategy.reset_children()
  strategy.add_child programs
  strategy.put 'height', (world) -> programs.get 'height'
  return if programs.get_local('height')
  programs.put 'height', (world) ->
    my.row.spacing * world._child_count()
  programs.put 'i', 0
  programs.put 'j', 0

  render_row = programs.make_world ROW_AUTHORITY
  render_command = programs.make_world COMMAND_AUTHORITY
  programs.map_children (program) ->
    program.put '_AUTHORITY', render_row 
    program.map_children (command) ->
     command.put '_AUTHORITY', render_command 
  
set_current = (world, current) ->
  world.put('current', current) if current?
  world.get('current')
  
exports.inspector = {
  _LABEL: "inspector"
  _EXPORTS: ['inspect', 'step', 'command']
  time: 0
  step: (world, args) -> world.update('time', 1)
  
  inspect: (world, args) ->
    current = set_current(world, args)
    programs = current.get('programs')
    world.replace_child display_commands(COMMANDS, programs)
    display_strategy world.find_child(STRATEGY), programs
    
  command: (world, args) ->
    {name, command} = args  
    program = world.find_child(STRATEGY).find_child().find_child(name)
    console.log 'command', name, command, world.find_child(STRATEGY), program
    my.assert program, "No program for #{name}"
    program.add_child command
    # TODO: Force Buffer to Update Visually
    world.send 'render'
    
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
    {
      _LABEL: STRATEGY
      _AUTHORITY: ROW_AUTHORITY
    }
  ]

}
