{my} = require '../my'
{vector} = require '../god/vector'

make_inspector = (sprite) ->
  "the sprite's behavior will go here"
  
get_inspector = (sprite) ->
  inspector = sprite.get 'inspector'
  return inspector if inspector
  make_inspector(sprite)
  
# TODO: Simplify by adding private _members
exports.inspector = {
  _LABEL: 'inspector'
  x: (world) -> world.get('width')
  y: 2*my.margin
  height:(world) -> world.get('screen').at vector.size.height
  stroke: my.color.line
  fill: my.color.background
  _AUTHORITY: {x:0, height: 'auto'}
  _CHILDREN: [
    {
      _LABEL: 'status'
      _EXPORTS: ['inspect']
      name: 'status'
      inspect: (world, sprite) -> world.put 'inspected', sprite
    }
    {
      _LABEL: 'behavior'
      _EXPORTS: ['inspect']
      inspect: (world, sprite) ->
        world.reset_children()
        world.add_child get_inspector(sprite)
    }
  ]
}
