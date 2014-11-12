exports.render_html = (world) ->
  T = world.T()
  {
    tag: T.div
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
