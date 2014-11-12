{vector} = require '../god/vector'

group = (label, items, direction) -> {
  layout: direction
  _LABEL: label
  _CHILDREN: items
}

exports.rows = (label, items) -> group(label, items, vector.axis.down)

exports.cols = (label, items) -> group(label, items, vector.axis.across)
