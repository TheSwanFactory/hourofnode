{my} = require '../my'

exports.inspector = {
  _LABEL: "inspector"
  _EXPORTS: ['inspect']
  
  inspect: (world, args) ->
    active_sprite = args
    world.reset_children()
    world.add_child active_sprite.get('state')
}
