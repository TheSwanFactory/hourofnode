{my} = require '../my'
{vector} = require '../god/vector'
{inspect_status} = require './inspect_status'

sprite_inspector = (sprite) ->
  {
    _LABEL: "inspector_#{sprite.get 'name'}"
    _CHILDREN: [
      inspect_status(sprite)
      "commands"
      "behavior"
    ]
  }
  
make_inspector = (world, sprite) ->
  inspector = world.make_world sprite_inspector(sprite)
  sprite.put 'inspector', inspector
  inspector
  
exports.inspector = {
  _LABEL: 'inspector'
  _EXPORTS: ['inspect']
  inspect: (world, sprite) ->
    world.reset_children()
    inspector = sprite.get('inspector') or make_inspector(world, sprite)
    world.add_child inspector 

  x: (world) -> world.get('width') - 4
  y: 2*my.margin
  position: 'absolute'
  height: (world) -> world.get('screen').at vector.size.height
  stroke: my.color.line
  fill: my.color.background

# TODO: Simplify by adding private _members
  _AUTHORITY: {
    x: () -> 0
    height: () -> 0
  }
}
