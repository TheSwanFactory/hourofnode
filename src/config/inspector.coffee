{my} = require('../my')

#TODO: Add SVG scrollbars a la http://www.carto.net/svg/gui/scrollbar/

COMMANDS = 'commands'
EXECUTING = 'executing'
STRATEGY = 'strategy'
TARGET = 'buffer:'

BUTTON_AUTHORITY = {
    fill: my.color.button
    x: (world) -> world.index * my.button.spacing + my.margin
    y: my.margin
    height: my.button.size
    width: (world) ->  world.get('height')
}

ROW_AUTHORITY = {
    fill: my.color.row
    x: my.margin
    y: (world) -> world.index * my.row.spacing + my.margin
    height: (world) -> my.row.size
    width: (world) -> world.up.get('width') - 2*my.margin
  }

COMMAND_SIZE = my.button.size * 0.8
COMMAND_SPACE = COMMAND_SIZE + my.margin
COMMAND_BORDER = "2px solid #{my.color.row}"
COMMAND_SELECTED = '2px solid goldenrod'
COMMAND_AUTHORITY = {
  height: COMMAND_SIZE
  width: (world) ->  world.get('height')
  x:(world) -> world.index * COMMAND_SPACE + my.margin / 2
  fill: my.color.command
  border: (world) ->
    program = world.up
    label = program.label()
    programs = program.up
    current = programs.get('current')
    counter = programs.get('counter')
    return COMMAND_SELECTED if label == current and world.index == counter  
    COMMAND_BORDER 
}

PROGRAM_SPACE = COMMAND_SPACE + my.margin
PROGRAM_AUTHORITY = $.extend {}, ROW_AUTHORITY
PROGRAM_AUTHORITY['y'] = (world) -> world.index * PROGRAM_SPACE + my.margin
# TODO: implement selected

display_commands = (name, programs) ->
  signals = programs.get('signals')
  children = Object.keys(signals).map (command) -> 
    {
      _LABEL: command, name: command
      click: (world) ->
        world.send 'command', {name: TARGET, command: command}
        # TODO: Make this call a command event on sprites
        world.get('current').call 'perform', signals[command]
    }
  {_LABEL: name, _AUTHORITY: BUTTON_AUTHORITY, _CHILDREN: children}

display_strategy = (strategy, programs) ->
  strategy.reset_children()
  strategy.add_child programs
  strategy.put 'height', (world) -> programs.get 'height'
  return if programs.get_local('height')
  programs.put 'i', 0
  programs.put 'j', 0
  programs.put 'height', (world) ->
     PROGRAM_SPACE * world._child_count() + 2*my.margin

  render_row = programs.make_world PROGRAM_AUTHORITY
  render_command = programs.make_world COMMAND_AUTHORITY
  programs.map_children (program) ->
    program.put '_AUTHORITY', render_row # TODO: Fix width
    program.authority = render_command
    program.map_children (command) ->
     command.put '_AUTHORITY', render_command
     if command.label() == program.label()
       command.put 'fill', my.color.row
       command.put 'border', ""
  
set_current = (world, current) ->
  world.put('current', current) if current?
  world.get('current')
  
exports.inspector = {
  _LABEL: "inspector"
  _EXPORTS: ['inspect', 'step', 'command']
  time: 0
  step: (world, args) -> world.update('time', 1)
  
  # TODO: Make this faster on the iPad 1
  inspect: (world, args) ->
    current = set_current(world, args)
    programs = current.get('programs')
    return unless world.is_world programs
    world.replace_child display_commands(COMMANDS, programs)
    display_strategy world.find_child(STRATEGY), programs
    
  command: (world, args) ->
    {name, command} = args  
    program = world.find_child(STRATEGY).find_child().find_child(name)
    my.assert program, "No program for #{name}"
    program.add_child command

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
        { # Show sprite icon
          path: (world) -> world.get('current').get('path')
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
      width: ROW_AUTHORITY['width']
    }
  ]

}
