#
# inspector.coffee
#
# Role: display and modify sprite state
#
# Responsibility:
# * create inspector panes for each sprite
# * load the current inspector

{my} = require '../my'
{vector} = require '../god/vector'
{status} = require './mixins/status'
{actions} = require './mixins/actions'
{behavior} = require './mixins/behavior'

sprite_inspector = (sprite) ->
  {
    height: 'auto'
    width: ''
    _LABEL: "inspector_#{sprite.get 'name'}"
    _CHILDREN: [
      status(sprite)
      actions(sprite)
      behavior(sprite)
    ]
    sprite: sprite
  }

make_inspector = (world, sprite) ->
  inspector = world.make_world sprite_inspector(sprite)
  sprite.put 'inspector', inspector
  inspector

exports.inspector = () ->
  {
    _LABEL: 'inspector'
    _EXPORTS: ['inspect', 'make_inspector']
    make_inspector: (world, sprite) ->
      sprite.get('inspector') or make_inspector(world, sprite)

    inspect: (world, sprite) ->
      world.reset_children()
      world.add_child world.call('make_inspector', sprite)

    width: (world) -> world.up.get('width') - 4 * my.margin
    x: (world) -> world.up.get('width')
    y: 0
    position: 'absolute'
    height: (world) -> world.get('screen').at(vector.size.height) - 2*my.margin
    stroke: my.color.line
    fill: my.color.background

  # TODO: Simplify by adding private _members
    _AUTHORITY: {
      x: () -> 0
      height: () -> 0
      class: 'inspector'
    }
  }
