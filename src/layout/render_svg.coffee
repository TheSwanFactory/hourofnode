exports.render_svg = (world) ->
  SVG = world.SVG()
  {
    tag: SVG.path
    name_tag: SVG.text
    style: {
      border: world.get 'border'
      fill: world.get 'fill'
      height: world.get 'height'
      width: world.get 'width'
      x: world.get 'x'
      y: world.get 'y'
    }
  }
