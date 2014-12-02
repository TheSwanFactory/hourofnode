#
# world.coffee
# Role: define our object model on top of Reactive Coffee
# Responsibility: loosely bind names to signals ('runtime')
#  * wrap Reactive Coffee primitives
#  * Manage scope and inheritance
#  * Send and handle events
#  * Construct worlds from dictionaries
#  * Distirbute events among child worlds
#  * Locate child and parent worlds
#
#  TODO: break this into roles use _.extend
#  * properties
#  * event handling
#  * import
#  * children

{my} = require '../my'

wraparound = (n, max) ->
  return max - 0.5 if n < 0
  return 0.5 if n > max
  n
  
RX = '_RX'
HANDLERS = '_HANDLERS'
CSS = '_CSS'

class World
  constructor: (up, label, rx) ->
    my.assert up, "up always exists"
    my.assert _.isObject(up), "up is an object"
    @up = up
    cache_rx = rx or @up.get_raw(RX)
    my.assert cache_rx, "cache_rx"
    @doc = cache_rx.map()
    my.assert _.isString(label), "label not a string: #{label}"
    @doc.put my.key.label, label
    @doc.put my.key.children, cache_rx.array()
    @doc.put(RX, rx) if rx?
    # this property is just for debugging. it's helpful in the console to see
    # which world you are dealing with as other properties are not immediately
    # available
    @uid = _.uniqueId()
    
  # reactive-coffee tags and binding
  rx: () -> @get(RX)
  T: () -> @rx().rxt.tags
  SVG: () -> @rx().rxt.svg_tags
  bind: () -> @rx().bind
  
  keys: (all) -> 
    keys = Object.keys @doc.x
    keys.splice keys.indexOf(my.key.label), 1
    keys.splice keys.indexOf(my.key.children), 1
    return keys unless all?
    result = _.uniq keys.concat(all)
    if @up.doc.has(RX) then result else @up.keys(result)
    
  put: (key, value) ->
    value = @rx().array value if _.isArray(value)
    @doc.put(key, value)

  get_local: (key) ->
    if @has_local(key) then @doc.get(key) else null

  has_local: (key) ->
    @doc.has key

  # TODO: make @up a list
  get_raw: (key, world) ->
    value = @get_local(key)
    return value if value?
    authority = @get_local(my.key.authority)
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

  handle_event: (event) ->
    world = @
    @handle event, (key, args) -> world.call(key, args)

  # TODO: Figure out who is expecting a return value from send
  send: (key, args, callback) ->
    for handler in @handlers_for(key)
      value = handler(key, args)
      callback(value) if callback
      value
    
  _export_events: ->
    return unless exports = @get_local(my.key.exports)
    for event in exports.all()
      my.assert _.isFunction(@get_raw(event)), "No function for #{event}"
      @handle_event event
    
  update: (key, delta, max) ->
    result = @get(key) + delta
    result = wraparound(result, max) if max?
    @put(key, result)

  # TODO: Require mutating actions to be calls, not gets
  call: (key, args) ->
    closure = @get_raw(key)
    my.assert _.isFunction(closure), "#{key}: #{closure} is not a function"
    closure(@, args)
    
  make_children: (children) ->
    # console.log 'make_children', children
    result = @rx().array()
    for value in children
      my.assert value, 'import child'
      child = @make_world(value)
      result.push child
    result
    
  import_dict: (dict) ->
    # console.log 'import_dict', dict
    for key, value of dict
      if key == my.key.authority
        # console.log 'import_dict @authority', @authority
        @authority = @_from_dict(value) 
      else
        # console.log 'import_dict not authority', key, value 
        value = @make_children(value) if key == my.key.children
        value = @rx().array(value) if _.isArray(value)
        @put(key, value)
    @_export_events()
    this

  _spawn_world: (label) ->
    world = new World(@, label)
    world.put(my.key.authority, @authority) if @authority?
    @handle my.key.setup, -> world.call(my.key.setup) if world.get_raw(my.key.setup)
    world
    
  _from_value: (value) ->
    my.assert _.isString(value), "_from_value #{value} not a string"
    world = @_spawn_world "#{value}"
    world.put("value", value)
    world.put("name", value)
    world

  _from_dict: (dict) ->
    # console.log '_from_dict', dict
    my.assert _.isObject(dict), "_from_dict: dict isn't dictionary"
    dict = dict(@) if _.isFunction(dict) # TODO: Verify edge cases
    my.assert !_.isFunction(dict), "_from_dict: dict is a function"
    label = dict[my.key.label] or "#{@get(my.key.label)}-#{@_child_count()}"
    world = @_spawn_world label
    world.import_dict dict

  make_world: (value) ->
    # console.log 'make_world', @.doc.x, value
    my.assert value, "make_world: missing value"
    return value if @is_world(value)
    return @_from_dict(value) if _.isObject(value)
    @_from_value value
    
  _children: -> @get(my.key.children)
  _child_array: -> @_children().all()
  _child_count: -> @_children().length()
  has_children: -> @_child_count() > 0
  
  # TODO: Compare performance of emptying vs. replacement
  reset_children: -> @put my.key.children, @rx().array()

  remove_child: (child) ->
    index = child.index
    target = @_child_array()[index]
    return console.error("remove_child failed: not present #{child}") unless child == target
    @_children().removeAt(index)
    
  add_child: (value) ->
    child = @make_world value
    my.assert child, "add_child"
    my.assert !_.isFunction @get_raw(my.key.children)
    @get(my.key.children).push(child)
    child
    
  find_children: (label) ->
    return @_child_array() unless label?
    result = []
    for child in @_child_array()
      result.push child if child.label() == label
    result
    
  find_index: (label) ->
    return -1 unless label?
    index = 0
    for child in @_child_array()
      return index if child.label() == label
      index += 1
    -1

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
    my.assert current, "Can not find key: [#{key}] for path: [#{path}] in #{@}" 
    current

  replace_child: (dict) ->
    label = dict[my.key.label]
    children = @get(my.key.children)
    index = @find_index(label)
    replacement = @make_world(dict)
    my.assert index >= 0, "Need valid index"
    children.put(index, replacement)
    
  map_children: (callback) ->
    result = []
    index = 0
    for child in @_child_array()
      child.index = index
      result.push callback(child)
      index += 1
    result
  
  label: -> @get(my.key.label)
  kind:  -> @get(my.key.kind) or "World"

  labels: (starter = []) ->
    starter.push @label()
    klasses = @get(CSS) or []
    klasses = [klasses] unless _.isArray(klasses)
    for klass in klasses
      starter.push klass
    if @is_root() then starter else @up.labels(starter)
    
  toString: -> "#{@kind()}_#{@label()}"
    
  is_world: (obj) -> obj instanceof World
  
  is_root: () -> not @is_world(@up)
  
  is_array: (obj) -> obj instanceof @rx().ObsArray

exports.world = (up, rx, doc) ->
  root = new World(up, "root", rx)
  root.put RX, rx
  root.put HANDLERS, rx.map()
  root.import_dict(doc)
#  root.send(my.key.setup)
  root
