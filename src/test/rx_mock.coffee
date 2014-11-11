
exports.rx_mock = (rx) ->
  {
    map: rx.map
    array: rx.array
    bind: (args) -> {args: args}
    rxt: {
      tags: {
        div: (args, children) -> {args: args, children: children}
      }
      svg_tags: {
        path: (args, children) -> {args: args, children: children}
      }
    }
  }

  