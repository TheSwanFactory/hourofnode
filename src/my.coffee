#
# my.coffee
#
# Role: collect all my configuration parameters
#
# Responsibility:
# * isolate hard-coded values in one place
# * provide namespace for other helper functions
#

# TODO: Make 'my' kinds inherit values somehow
# TODO: Pull element colors into their own namespace

sys = require 'sys'
assert = require 'assert'

SURVEY='https://docs.google.com/forms/d/1ovfw26rDoWGoxEGLV8HjPxmVmBMpuJIpi9ZExIfvRCU/viewform?usp=send_form'
is_local = window.location.hostname == 'localhost'

inspect = (world, n=1) ->
  console.log "inspect #{world} #{n}"
  return unless is_local
  result = "\n#{Array(n+1).join '!'} inspect #{world}:"
  result = "#{result}\n#{sys.inspect world.doc.x}"

  children = world._child_array() or []
  for child in children
    result = "#{result}\n #{inspect(child, n+1)}"
  result

# iPad sizes based on https://stackoverflow.com/questions/3375706/ipad-browser-width-height-standard/9049670#9049670
PAGE = [1024, 720]
IPAD = {width: PAGE[0], height: PAGE[1]}
HALF = IPAD.width / 2
TOUCH = 64
CONTROL = 96
MARGIN = 4

BUTTON_COLOR = 'azure'
BUTTON_BACKGROUND = 'grey'
ROW_BACKGROUND = 'darkgrey'
COMMAND_COLOR = 'beige'
COMMAND_BACKGROUND = 'lightgrey'

exports.my = {
  beta: false
  test: false #is_local
  online: _?
  inspect: inspect
  assert: assert
  feedback_url: SURVEY
  dup: (a, b) -> if $? then $.extend({}, a, b) else a
  not_editable: (sprite) ->  "The #{sprite.get('kind')} '#{sprite.get('name')}' is not currently editable. Click 'Edit' to enter edit mode and edit all objects."
  page_dimensions: PAGE
  column_1_width: HALF
  column_2_width: HALF
  cell_width: 30
  device: IPAD
  margin: MARGIN
  grid: {size: HALF, split: 8}
  duration: {step: 1000, tone: 150}
  row: {size: TOUCH + 2*MARGIN, spacing: TOUCH + 4*MARGIN}
  action_limit: 7
  speed: 1
  level_server: 'http://hourofnode-games.herokuapp.com'

  button: {
    size: TOUCH
    padding: MARGIN
    class: 'button'
  }
  command: {
    size: TOUCH
    class: 'command'
  }
  action: {
    padding: MARGIN
    class: 'action'
  }
  control: {
    padding: MARGIN
    color: BUTTON_COLOR
    class: 'control'
  }
  color: {
    button: BUTTON_COLOR
    row: BUTTON_BACKGROUND
    grid: '#cceeff' # pale blue
    gridline: 'white'
    command: COMMAND_COLOR
    line: 'black'
    selection: 'black'
    unselected: 'grey'
  }
  program: {
    class: 'program'
  }
  key: {
    authority: '_AUTHORITY'
    children: '_CHILDREN'
    exports: '_EXPORTS'
    kind: '_KIND'
    label: '_LABEL'
    setup: '_SETUP'
  }
}
