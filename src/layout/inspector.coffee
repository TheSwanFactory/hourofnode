{my} = require '../my'

make_inspector = (sprite) ->
  "inspect behavior"
  
get_inspector = (sprite) ->
  inspector = sprite.get 'inspector'
  return inspector if inspector
  make_inspector(sprite)
  
exports.inspector = {
  _LABEL: 'inspector'
  _CHILDREN: [
    {
      _LABEL: 'status'
      _EXPORTS: ['inspect']
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
