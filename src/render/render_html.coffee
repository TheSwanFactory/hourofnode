{my} = require '../my'
{vector} = require '../god/vector'

exports.render_html = (world) ->
  T = world.T()
  dir = world.get 'layout'
  tag = if (dir == vector.axis.across) then T.span else T.div
  {
    tag: tag
    name_tag: T.p
    style: {
      border: world.get 'stroke'
      background: world.get 'fill'
      margin: world.get 'margin'
      padding: world.get 'padding'
      position: 'absolute'
      height: world.get 'height'
      width: world.get 'width'
      left: world.get 'x'
      top: world.get 'y'
    }
  }
