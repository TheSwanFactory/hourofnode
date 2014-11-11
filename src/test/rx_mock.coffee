
exports.rx_mock = (rx) ->
  {
    map: rx.map
    array: rx.array
    bind: (args) -> {args: args}
    rxt: {
      tags: {
        div: (attr, body) -> {tag: 'div', attr: attr, body: body}
      }
      svg_tags: {
        path: (attr, body) -> {tag: 'path', attr: attr, body: body}
      }
    }
  }

  