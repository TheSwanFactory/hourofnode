#
# vector.coffee
# Role: define semantics of arrays treated as X,Y coordinates
# Responsibility: define our geometry
#
#  TODO: find a better name
#  Alternatives: point, vector, math, geometry, coordinates

X_INDEX = 0
Y_INDEX = 1

DIR_LEFT  =  1
DIR_RIGHT = -1

x = (v) -> if _.isArray(v) then v[X_INDEX] else v.at(X_INDEX)
y = (v) -> if _.isArray(v) then v[Y_INDEX] else v.at(Y_INDEX)

exports.vector = {

  # Enumerations for accessing components
  axis: {x: X_INDEX, y: Y_INDEX}
  size: {width: X_INDEX, height: Y_INDEX}
  to: {left: DIR_LEFT, right: DIR_RIGHT }

  # Compare two vectors and return the result
  equal: (a, b) -> (x(a) == x(b)) and (y(a) == y(b))

  # Add two vectors and return the result
  add: (a, b) -> [a[X_INDEX] + b[X_INDEX], a[Y_INDEX] + b[Y_INDEX]]
  
  # Ensure vector is in bounds
  bound: (v, n) -> v
  
  # Add two vectors and return the result
  # 1,0 -> 0, 0,1 -> 90, -1,0 -> 180, 0,-1 -> -90
  # assume it is already normalized
  # TODO: perform real triginometry
  angle: (v) -> if y(v) < 0 then -90 else 90*(1 - x(v))

  # Rotate by +/- 90 degrees
  turn: (v, dir) -> [dir * y(v), -1 * dir * x(v)]
}