{vector} = require '../god/vector'

group = (label, items, direction) -> {
  _AUTHORITY: {layout: direction}
  _LABEL: label
  _CHILDREN: items
}

exports.make = {
  rows: (label, items) -> group(label, items, vector.axis.down)
  columns: (label, items) -> group(label, items, vector.axis.across)
}
