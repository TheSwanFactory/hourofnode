transform = (world) ->
  center = world.get('scale') / 2
  translate = "translate(#{world.get('x') || 0},#{world.get('y') || 0})"
  rotate = world.get('angle') && center? && "rotate(#{world.get('angle')} #{center} #{center})"
  "#{translate} #{rotate || ''}"

exports.render_svg = (world) ->
  SVG = world.SVG()
  
  # TODO: handle selection
  # TODO: allow named paths?

  path_tags = (paths) ->
    return [] unless paths
    path_dict = {stroke: world.get('stroke'), fill: world.get('fill')}
    paths.map (path) ->
      path_dict['d'] = path
      SVG.path path_dict 

  svg_tag = (attrs, body) ->
    attrs['transform'] = transform(world)
    SVG.svg {
      xmlns: "http://www.w3.org/2000/svg"
      "xmlns:xlink": "http://www.w3.org/1999/xlink"
      class: "render_svg #{world}"
      width: world.get 'width'
      height: world.get 'height'
    }, [SVG.g attrs, body]
  {
    tag: svg_tag
    name_tag: SVG.text
    path_tags: path_tags world.get('paths')
  }
