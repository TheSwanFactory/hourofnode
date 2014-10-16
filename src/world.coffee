class World
  constructor: (rx, label, doc, up) ->
    @rx = rx
    @doc = rx.map() #TODO: Can we accomplish this via "lift" instead?
    @label = label
    @up = up
    for key, value of doc
      if value instanceof Object && !isFunction(value)
        value = new World(rx, key, value, this)
      @doc.put(key, value)
    
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

exports.world = (doc, up) ->
  new World("world", doc, up)
