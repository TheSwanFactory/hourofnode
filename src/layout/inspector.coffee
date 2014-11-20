{my} = require '../my'
{vector} = require '../god/vector'
{inspect_status} = require './inspect_status'
{inspect_commands} = require './inspect_commands'
{inspect_behavior} = require './inspect_behavior'

sprite_inspector = (sprite) ->
  {
    height: 'auto'
    _LABEL: "inspector_#{sprite.get 'name'}"
    _CHILDREN: [
      inspect_status(sprite)
      inspect_commands(sprite)
      inspect_behavior(sprite)
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

  width: (world) -> world.up.get('width') - 4 * my.margin
  x: (world) -> world.up.get('width') + my.margin
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
