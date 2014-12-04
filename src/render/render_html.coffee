{my} = require '../my'
{vector} = require '../god/vector'

exports.render_html = (world) ->
  T = world.T()
  tag_name = world.get('tag_name') or 'div'
  tag = T[tag_name]
  my.assert tag, "No tag for #{tag_name} in #{world}"
  has_position = world.get('x') or world.get('y')
  has_border = world.get('stroke')
  {
    tag: tag
    name_tag: name_tag(T, tag_name)
    href: world.get 'href'
    style: {
      padding: world.get 'padding'
      position: world.get_local 'position'
      height: world.get 'height'
      min_height: world.get_local 'min_height'
      width: world.get 'width'
      left: world.get 'x'
      top: world.get 'y'
    }
  }

# TODO: find a way to draw an SVG icon based on the name
name_tag = (T, tag_name) ->
  if tag_name is 'button'
    (attrs, content) -> if _.isString(content) then content else content.get()
  else
    T.span
