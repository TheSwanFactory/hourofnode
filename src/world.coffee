assert = require 'assert'

wraparound = (n, max) ->
  return max - 0.5 if n < 0
  return 0.5 if n > max
  n
  
RX = "_RX"
LABEL = "_LABEL"
CHILDREN = "_CHILDREN"
AUTHORITY = "_AUTHORITY"
EXPORTS = "_EXPORTS"
HANDLERS = "_HANDLERS"
CSS = "_CSS"

class World
  constructor: (up, label, rx) ->
    assert up, "up always exists"
    assert _.isObject(up), "up is an object"
    @up = up
    cache_rx = rx or @up.get_raw(RX)
    assert cache_rx, "cache_rx"
    @doc = cache_rx.map()
    assert _.isString(label), "label is string"
    @doc.put LABEL, label
    @doc.put CHILDREN, cache_rx.array()
    @doc.put(RX, rx) if rx?
    
  # reactive-coffee tags and binding
  rx: () -> @get(RX)
  T: () -> @rx().rxt.tags
  SVG: () -> @rx().rxt.svg_tags
  bind: () -> @rx().bind
  
  put: (key, value) ->
    @doc.put(key, value)

  get_local: (key) ->
    @doc.get(key)

  # TODO: make @up a list
  get_raw: (key, world) ->
    value = @get_local(key)
    return value if value?
    authority = @get_local(AUTHORITY)
    if authority
      #console.log "Find #{key} in #{authority}"
      value = authority.get_raw(key, @)
      return value if value?
    @up.get_raw(key, world or @)

  get: (key) ->
    value = @get_raw(key)
    return value(@,{}) if _.isFunction(value)
    value

  owner: (key) ->
    return @ if @get_local(key)?
    @up.owner(key) unless @is_root()
    
  handlers_for: (key) ->
    handlers = @get(HANDLERS)
    list = handlers.get(key)
    unless list?
      list = []
      handlers.put(key, list)
    list 

  handle: (key, callback) ->
    handlers = @handlers_for(key)
    handlers.push callback

  send: (key, args) ->
    for handler in @handlers_for(key)
      handler(key, args)
    
  _export_events: ->
    return unless exports = @get_local(EXPORTS)
    for event in exports.all()
      assert _.isFunction @get_raw(event), "No function for #{event}"
      world = @
      @handle event, (key, args) ->
        world.call(key, args)
    
  update: (key, delta, max) ->
    result = @get(key) + delta
    result = wraparound(result, max) if max?
    @put(key, result)

  # TODO: Require mutating actions to be calls, not gets
  call: (key, args) ->
    closure = @get_raw(key)
    assert _.isFunction(closure), "#{key}: #{closure} is not a function"
    closure(@, args)
    
  # TODO: refactor import_dict methods somewhere
  _import_children: (children) ->
    result = @rx().array()
    children = children(@) if _.isFunction(children)
    for value in children
      assert value, 'import child'
      result.push @make_world(value)
    result
    
  import_dict: (dict) ->
    for key, value of dict
      if key == AUTHORITY
        @authority = @_from_dict(value) 
      else
        value = @_import_children(value) if key == CHILDREN
        value = @rx().array(value) if _.isArray(value)
        @put(key, value)
    @_export_events()
    this

  _spawn_world: (label) ->
    world = new World(@, label)
    world.put(AUTHORITY, @authority) if @authority?
    world
    
  _from_value: (value) ->
    assert _.isString(value), "_from_value requires string"
    world = @_spawn_world "#{value}"
    world.put("value", value)
    world.put("name", value)
    world

  _from_dict: (dict) ->
    assert _.isObject(dict), "_from_dict: dict isn't dictionary"
    dict = dict(@) if _.isFunction(dict) # TODO: Verify edge cases
    assert !_.isFunction(dict), "_from_dict: dict is a function"
    label = dict[LABEL] or "#{@get(LABEL)}:#{@_child_count()}"
    world = @_spawn_world label
    world.import_dict dict

  make_world: (value) ->
    return value if @is_world(value)
    return @_from_dict(value) if _.isObject(value)
    @_from_value value
    
  _children: -> @get(CHILDREN)
  _child_array: -> @_children().all()
  _child_count: -> @_children().length()
  has_children: -> @_child_count() > 0
  
  reset_children: -> @put CHILDREN, @rx().array()
    
  add_child: (value) ->
    child = @make_world value
    assert child, "add_child"
    assert !_.isFunction @get_raw(CHILDREN)
    @get(CHILDREN).push(child)
    child
    
  find_children: (label) ->
    return @_child_array() unless label?
    result = []
    for child in @_child_array()
      result.push child if child.label() == label
    result
    
  find_child: (label) ->
    @find_children(label)[0]

  find_parent: (name) ->
    return @ if @label() == name or @is_root()
    @up.find_parent(name)

  find_path: (path) ->
    path = path.split(".") unless _.isArray(path)
    current = @
    for key in path
      if key == "" or !key?
        current = @find_parent()
      else
        current = current.find_child(key)
    assert current, "Can not find key: [#{key}] for path: [#{path}] in #{@}" 
    current
    
  map_children: (callback) ->
    result = []
    index = 0
    for child in @_child_array()
      child.index = index
      result.push callback(child)
      index += 1
    result
  
  label: -> @get(LABEL)

  labels: (starter = []) ->
    starter.push @label()
    klasses = @get(CSS) or []
    klasses = [klasses] unless _.isArray(klasses)
    for klass in klasses
      starter.push klass
    if @is_root() then starter else @up.labels(starter)
    
  toString: -> "World_#{@label()}"
    
  is_world: (obj) -> obj instanceof World
  
  is_root: () -> not @is_world(@up)
  
  is_array: (obj) -> obj instanceof @rx().ObsArray

exports.world = (up, rx, doc) ->
  root = new World(up, "root", rx)
  root.put RX, rx
  root.put HANDLERS, rx.map()
  root.import_dict(doc)
