queryString = require 'query-string'
rx          = require 'reactive-coffee'

custom_level = rx.cell({ sprites: [], goal: {} })

actions_to_object = (actions) ->
  keys   = actions.keys()
  object = {}

  for key in keys
    object[key] = actions.get(key).all()

  object

get_level_copy = ->
  $.extend {}, custom_level.get()

update_level = (change) ->
  level = get_level_copy()
  change level
  custom_level.set level

index_of_conditional = (list, condition) ->
  index = -1
  for item, i in list
    return index = i if condition(item)

  index

log_sprite_change = (world, args) ->
  [sprite, key, value] = args

  update_level (level) ->
    level.sprites[sprite.index][key] = value

sprite_index = 0
make_sprite = (world, sprite_dict) ->
  level = get_level_copy()

  index  = sprite_index++
  sprite =
    kind:     sprite_dict.kind
    position: sprite_dict.position
    actions:  actions_to_object(sprite_dict.actions)

  update_level (level) ->
    if level.sprites[index]?
      $.extend level.sprites[index], sprite
    else
      level.sprites.push sprite

delete_sprite = (world, sprite) ->
  update_level (level) ->
    level.sprites.splice sprite.index, 1

level_change = (world, args) ->
  [key, value] = args

  return unless key? and value?

  update_level (level) ->
    level[key] = value

metrics = {}
for metric in ['click', 'tick', 'brick']
  do (metric) ->
    plural = "#{metric}s"
    metrics[metric] = (world) ->
      update_level (level) ->
        level.goal[plural] = world.get plural, false

normalize_action_args = (args) ->
  [sprite, program] = args

  args[1] = program.label() if sprite.is_world program

  args

store_action = (world, args) ->
  [sprite, program, action, index] = normalize_action_args args

  update_level (level) ->
    sprite  = level.sprites[sprite.index]

    sprite_actions  = sprite.actions ?= {}
    program_actions = sprite.actions[program] ?= []

    index ?= program_actions.length

    program_actions.splice index, 0, action

remove_action = (world, args) ->
  [sprite, program, action_or_index] = normalize_action_args args

  update_level (level) ->
    sprite  = level.sprites[sprite.index]

    program_actions = sprite.actions[program]

    index = if _.isNumber(action_or_index) then action_or_index else action_or_index.index

    program_actions.splice index, 1

move_action = (world, args) ->
  [sprite, program, old_index, new_index] = normalize_action_args args

  level_sprite  = custom_level.get().sprites[sprite.index]
  level_program = level_sprite.actions[program]
  action        = level_program[old_index]

  remove_action world, [sprite, program, old_index]
  store_action  world, [sprite, program, action, new_index]

url = ->
  search = queryString.parse location.search
  search.custom = JSON.stringify custom_level.get()
  "#{location.origin}#{location.pathname}?#{queryString.stringify search}"

pretty_source = ->
  JSON.stringify custom_level.get(), null, 4

exports.changelog =
  world: (level) ->
    {
      _EXPORTS: [
        'log_sprite_change'
        'make_sprite'
        'delete_sprite'
        'level_change'
        'click'
        'tick'
        'brick'
        'store_action'
        'remove_action'
        'move_action'
      ]
      log_sprite_change: log_sprite_change
      make_sprite:       make_sprite
      delete_sprite:     delete_sprite
      level_change:      level_change
      click:             metrics.click
      tick:              metrics.tick
      brick:             metrics.brick
      store_action:      store_action
      remove_action:     remove_action
      move_action:       move_action
    }

  set_custom: (custom) ->
    custom_level.set custom

  url:           url
  pretty_source: pretty_source

