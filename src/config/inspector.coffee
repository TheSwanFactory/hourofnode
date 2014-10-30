assert = require 'assert'

ROW_SIZE = 96
MARGIN = 8

ROW_AUTHORITY = {
    fill: "#cccccc"
    transform: (world, args) ->
      margin = world.get('margin')
      scale = world.get('scale')
      x = world.index * scale + margin
      y = margin
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
  height: (world) -> world.get('size')
  margin: MARGIN
  fill: "#888888"
  stroke: "black"
  path: (world, args) -> world.get('rect_path')
  _AUTHORITY: {
    fill: "#aaaaaa"
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
      _CHILDREN: ['curr', 'name', 'pos', 'dir']
    }
    {
      _LABEL: 'commands'
      _AUTHORITY: ROW_AUTHORITY
      _CHILDREN: (world, args) ->
        signals = world.get('signals')
        if signals? then Object.keys signals else []
    }
  ]

}
