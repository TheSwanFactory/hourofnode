#
# vector.coffee
# Role: define semantics of arrays treated as X,Y coordinates
# Responsibility: define our geometry
#
#  TODO: find a better name
#  Alternatives: point, vector, math, geometry, coordinates

X_INDEX = 0
Y_INDEX = 1
exports.vector = {
  axis: {x: X_INDEX, y: Y_INDEX}
  size: {width: X_INDEX, height: Y_INDEX}
  add: (a, b) -> [
    a[X_INDEX] + b[X_INDEX]
    a[Y_INDEX] + b[Y_INDEX]
  ]
}
  