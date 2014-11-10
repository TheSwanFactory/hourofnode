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

  # Enumerations for accessing the components
  axis: {x: X_INDEX, y: Y_INDEX}
  size: {width: X_INDEX, height: Y_INDEX}

  # Compare two vectors and return the result
  equal: (a, b) -> 
    (a[X_INDEX] == b[X_INDEX]) and (a[Y_INDEX] == b[Y_INDEX])

  # Add two vectors and return the result
  add: (a, b) -> [a[X_INDEX] + b[X_INDEX], a[Y_INDEX] + b[Y_INDEX]]
  
  # Add two vectors and return the result
  # 1,0 -> 0, 0,1 -> 90, -1,0 -> 180, 0,-1 -> -90
  angle: (v) ->
    # assume it is already normalized
    # TODO: perform real triginometry
    x = v[X_INDEX] # -1 to 1
    y = v[Y_INDEX] # -1 to 1
    if y < 0 then -90 else 90*(1 - x)

  # Rotate by +/- 90 degrees
  turn: (v, dir) ->
    x = v[X_INDEX] # -1 to 1
    y = v[Y_INDEX] # -1 to 1
    [dir * y, -1 * dir * x]
}
