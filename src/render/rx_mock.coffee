tag = (name) ->
  (attr, body) -> {tag: name, attr: attr, body: body}
  
exports.rx_mock = (rx) ->
  {
    map: rx.map
    array: rx.array
    bind: (callback) -> callback()
    rxt: {
      tags: {
        div: tag 'div'
        span: tag 'span'
        p: tag 'p'
      }
      svg_tags: {
        svg: tag 'svg'
        g: tag 'g'
        path: tag 'path'
        text: tag 'text'
      }
    }
  }

  