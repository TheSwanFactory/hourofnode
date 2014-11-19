{my} = require '../my'

exports.render_svg = (world) ->
  SVG = world.SVG()

  path_dict = (path) ->
    dict = {
      d: path
      stroke: world.get('stroke')
      fill: world.get('fill')
    }
    if world.get('selected')
      dict['stroke']= my.color.selection
      dict['stroke-width'] = 3
    dict 
  path_tags = (paths) ->
    return [] unless paths
    paths.map (path) -> SVG.path path_dict(path)

  svg_tag = (attrs, body) ->
    attrs['transform'] = world.get('transform') || ''
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
