#
# vector.coffee
# Role: define semantics of arrays treated as X,Y coordinates
# Responsibility: define our geometry
#
#  TODO: find a better name
#  Alternatives: point, vector, math, geometry, coordinates

{my} = require '../my'

X_INDEX = 0
Y_INDEX = 1

DIR_LEFT  =  1
DIR_RIGHT = -1

check = (v) -> 
  my.assert v, "missing vector"
  _.isArray(v) if v
  
get_x = (v) -> if check(v) then v[X_INDEX] else v.at(X_INDEX)
get_y = (v) -> if check(v) then v[Y_INDEX] else v.at(Y_INDEX)

put_x = (v, i) -> if check(v) then v[X_INDEX]=i else v.put(X_INDEX,i)
put_y = (v, i) -> if check(v) then v[Y_INDEX]=i else v.put(Y_INDEX,i)

access = {x: get_x, y: get_y}
settor = {x: put_x, y: put_y}
axis = {x: X_INDEX, y: Y_INDEX}
 
exports.vector = {

  # Enumerations for accessing components
  axis: {x: X_INDEX, y: Y_INDEX, across: X_INDEX, down: Y_INDEX}
  size: {width: X_INDEX, height: Y_INDEX}
  to: {front: 1, back: -1, left: DIR_LEFT, right: DIR_RIGHT}
  x: get_x
  y: get_y

  # Compare two vectors and return the result
  equal: (a, b) -> (get_x(a) == get_x(b)) and (get_y(a) == get_y(b))

  # Add two vectors and return the result
  add: (a, b) -> [get_x(a) + get_x(b), get_y(a) + get_y(b)]
  
  # Subtract b from a
  subtract: (a, b) -> [get_x(a) - get_x(b), get_y(a) - get_y(b)]
  
  # Ensure vector is inside [0,n) , else call error_callback
  bound: (v, n, error_callback) ->
    [get_x, get_y].map (coordinate) ->
      i = coordinate(v)
      return i if i >= 0 and i < n
      error_callback(i, n) if error_callback?
      if i < 0 then 0 else n - 1

  # limit vector to be inside [0,n). Return status
  inside: (v, n) ->
    inside = true
    ['x', 'y'].map (key) ->
      value = access[key] v
      console.log 'inside', inside , v, value, settor[key]
      if value < 0
        settor[key](v, 0) 
        inside = false
      if value >= n
        settor[key](v, n - 1) 
        inside = false
    inside
  
  # Add two vectors and return the result
  # 1,0 -> 0, 0,1 -> 90, -1,0 -> 180, 0,-1 -> -90
  # assume it is already normalized
  # TODO: perform real triginometry
  angle: (v) -> if get_y(v) < 0 then -90 else 90*(1 - get_x(v))

  # Rotate by +/- 90 degrees
  turn: (v, dir) -> [dir * get_y(v), -1 * dir * get_x(v)]
}
