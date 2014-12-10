queryString = require 'query-string'
rx = require 'reactive-coffee'

custom_level = rx.cell({ sprites: [], goal: {} })

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

get_sprite_index = (sprite) ->
  index_of_conditional sprite.up.find_children(), (s) ->
    s.uid == sprite.uid

log_sprite_change = (world, args) ->
  [sprite, key, value] = args

  level_sprite_index = get_sprite_index sprite

  return unless level_sprite_index > -1

  update_level (level) ->
    level.sprites[level_sprite_index][key] = value

sprite_index = 0
make_sprite = (world, sprite_dict) ->
  level = get_level_copy()

  index  = sprite_index++
  sprite =
    kind:     sprite_dict.kind
    position: sprite_dict.position

  update_level (level) ->
    if level.sprites[index]?
      $.extend level.sprites[index], sprite
    else
      level.sprites.push sprite

delete_sprite = (world, sprite) ->
  level_sprite_index = get_sprite_index sprite

  return unless level_sprite_index > -1

  update_level (level) ->
    level.sprites.splice level_sprite_index, 1

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

url = ->
  search = queryString.parse location.search
  search.custom = JSON.stringify custom_level.get()
  "#{location.origin}#{location.pathname}?#{queryString.stringify search}"

exports.changelog =
  world: (level) ->
    {
      _EXPORTS:          ['log_sprite_change', 'make_sprite', 'delete_sprite', 'level_change', 'click', 'tick', 'brick']
      log_sprite_change: log_sprite_change
      make_sprite:       make_sprite
      delete_sprite:     delete_sprite
      level_change:      level_change
      click:             metrics.click
      tick:              metrics.tick
      brick:             metrics.brick
    }

  set_custom: (custom) ->
    custom_level.set custom

  url: url

