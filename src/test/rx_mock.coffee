
exports.rx_mock = (rx) ->
  {
    map: rx.map
    array: rx.array
    bind: (callback) -> callback()
    rxt: {
      tags: {
        div: (attr, body) -> {tag: 'div', attr: attr, body: body}
        span: (attr, body) -> {tag: 'div', attr: attr, body: body}
        p: (attr, body) -> {tag: 'div', attr: attr, body: body}
      }
      svg_tags: {
        g: (attr, body) -> {tag: 'path', attr: attr, body: body}
        path: (attr, body) -> {tag: 'path', attr: attr, body: body}
      }
    }
  }

  