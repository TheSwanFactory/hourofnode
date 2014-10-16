class World
  constructor: (@label, @up) ->
    @up.get()
    @doc = rx.map()

  get_local: (key) ->
    @doc.get(key)

  get_raw: (key, world=this) ->
    value = @get_local(key)
    if value? then value else @up.get_raw(key, this)

  get: (key) ->
    value = @get_raw(key)
    if isFunction(value)
      return value(this,{})
    value

  getChildren: ->
    @get('_children')

  getChild: (key) ->
    @getChildren().get(key)

  put: (key, value) ->
    @doc.put(key, value)
    
  addChild: (key, value) ->
    children = @getChildren()
    n = _.size children
    value['label'] = key
    children.put(n, value)
    
  reset: (key, delta) ->
    @put(key, @get(key) + delta)

  call: (key, args) ->
    closure = @get_raw(key)
    closure(this, args)
    
  bind: (exp) ->
    @rx.bind exp

  map: (callback) ->
    result = []
    for key in Object.keys(@doc.x)
      value = @get_raw(key)
      result.push callback(key, value)
    result

  toString: ->
    "World:#{@label}"

exports.world = (label, up) ->
  new World(label, up)
