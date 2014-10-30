# iPad sizes based on https://stackoverflow.com/questions/3375706/ipad-browser-width-height-standard/9049670#9049670
IPAD = {width: 1024, height: 690}
HALF = IPAD.width / 2
BUFFER = IPAD.height - HALF
TOUCH = 64
CONTROL = 96
MARGIN = 8

exports.my = {
  assert: require 'assert'
  device: IPAD
  margin: MARGIN
  grid: {size: HALF, split: 8}
  button: {size: TOUCH, spacing: TOUCH + 2*MARGIN}
  row: {size: TOUCH + 2*MARGIN, spacing: TOUCH + 4*MARGIN}
  control: {size: CONTROL, spacing: CONTROL + 4*MARGIN, margin: 2*MARGIN}
  color: {
    button: "azure"
    background: "darkgrey"
    row: "lightgrey"
    grid: "#ccffcc"
    gridline: "white"
  }
}
