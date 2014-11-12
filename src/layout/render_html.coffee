{vector} = require '../god/vector'

exports.render_html = (world) ->
  T = world.T()
  dir = world.layout
  {
    tag: if dir == vector.axis.across then T.span else T.div
    name_tag: T.p
    style: {
      border: world.get 'border'
      background: world.get 'fill'
      height: world.get 'height'
      width: world.get 'width'
      position: 'absolute'
      left: world.get 'x'
      top: world.get 'y'
    }
  }
