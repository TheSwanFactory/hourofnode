#
# my.coffee
#
# Role: collect all my configuration parameters
#
# Responsibility:
# * isolate hard-coded values in one place
# * provide namespace for other helper functions

# TODO: Make 'my' kinds inherit values somehow
# TODO: Pull element colors into their own namespace

sys = require 'sys'
assert = require 'assert'

inspect = (world, n=1) ->
  console.log "#{Array(n+1).join '!'} inspect #{world}"
  sys.inspect world.doc.x
  children = world._child_array() or []
  for child in children
    inspect(child, n+1)

# iPad sizes based on https://stackoverflow.com/questions/3375706/ipad-browser-width-height-standard/9049670#9049670
PAGE = [1024, 690]
IPAD = {width: 1024, height: 690}
HALF = IPAD.width / 2
TOUCH = 64
CONTROL = 96
MARGIN = 8

BUTTON_COLOR = 'azure'
BUTTON_BACKGROUND = 'grey'
ROW_BACKGROUND = 'darkgrey'
COMMAND_COLOR = 'beige'
COMMAND_BACKGROUND = 'lightgrey'

exports.my = {
  test: window.location.hostname == 'localhost'
  inspect: (world) -> sys.inspect world.doc.x
  assert: assert
  page_dimensions: PAGE
  column_1_width: HALF
  column_2_width: HALF
  cell_width: 30
  device: IPAD
  margin: MARGIN
  grid: {size: HALF, split: 8}
  row: {size: TOUCH + 2*MARGIN, spacing: TOUCH + 4*MARGIN}
  button: {
    size: TOUCH
    spacing: TOUCH + 2*MARGIN
    padding: 2*MARGIN
    margin: MARGIN
    color: BUTTON_COLOR
    background: BUTTON_BACKGROUND 
  }
  command: {
    size: TOUCH
    spacing: TOUCH + 2*MARGIN
    padding: 2*MARGIN
    margin: MARGIN
    color: BUTTON_COLOR
    background: BUTTON_BACKGROUND 
  }
  control: {
    size: CONTROL
    spacing: CONTROL + 4*MARGIN
    padding: 4*MARGIN
    margin: 2*MARGIN
    color: BUTTON_COLOR
    background: ROW_BACKGROUND 
  }
  color: {
    button: BUTTON_COLOR
    background: ROW_BACKGROUND 
    row: BUTTON_BACKGROUND
    grid: '#ccffcc' # pale_green
    gridline: 'white'
    command: COMMAND_COLOR
    line: 'black'
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
