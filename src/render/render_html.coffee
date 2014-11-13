{my} = require '../my'
{vector} = require '../god/vector'

exports.render_html = (world) ->
  T = world.T()
  dir = world.get 'layout'
  tag = if (dir == vector.axis.across) then T.span else T.div
  has_position = world.get('x') or world.get('y')
  {
    tag: tag
    name_tag: T.span
    style: {
      border: world.get 'stroke'
      background: world.get 'fill'
      margin: world.get 'margin'
      padding: world.get 'padding'
      position: 'absolute' if has_position
      height: world.get 'height'
      width: world.get 'width'
      left: world.get 'x'
      top: world.get 'y'
    }
  }
