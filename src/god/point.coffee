# Define Semantics of Vectors / Points
# Alternate names: point, vector, math, geometry

X_INDEX = 0
Y_INDEX = 1
exports.point = {
  axis: {x: X_INDEX, y: Y_INDEX}
  size: {width: X_INDEX, height: Y_INDEX}
  add: (a, b) -> [
    a[X_INDEX] + b[X_INDEX]
    a[Y_INDEX] + b[Y_INDEX]
  ]
}
  