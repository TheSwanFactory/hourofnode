{my} = require '../my'
{vector} = require '../god/vector'

exports.render_html = (world) ->
  T = world.T()
  tag_name = world.get_plain('tag_name') or 'div'
  tag = T[tag_name]
  my.assert tag, "No tag for #{tag_name} in #{world}"
  has_position = world.get('x') or world.get('y')
  has_border = world.get('stroke')
  {
    tag: tag
    name_tag: name_tag(T, tag_name)
    style: {
      margin: world.get 'margin'
      padding: world.get 'padding'
      position: world.get_local 'position'
      height: world.get 'height'
      width: world.get 'width'
      left: world.get 'x'
      top: world.get 'y'
    }
  }

name_tag = (T, tag_name) ->
  if tag_name is 'button'
    (attrs, content) ->
      if _.isString(content)
        content
      else
        content.get()
  else
    T.span