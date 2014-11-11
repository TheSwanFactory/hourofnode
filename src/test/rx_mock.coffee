exports.rx_mock = () -> {
  rxt: {
    tags: {
      div: (args, children) -> {args: args, children: children}
    }
    svg_tags: {
      path: (args, children) -> {args: args, children: children}
    }
  }
}

  