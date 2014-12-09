queryString = require 'query-string'
rx = require 'reactive-coffee'

custom_level = rx.cell({ sprites: [] })

get_level_copy = ->
  $.extend {}, custom_level.get()

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

  level = get_level_copy()
  level.sprites[level_sprite_index][key] = value

  custom_level.set level

sprite_created = (world, sprite) ->
  return unless level_sprite_index > -1

  level = get_level_copy()
  level.sprites[level_sprite_index]

sprite_index = 0
make_sprite = (world, sprite_dict) ->
  level = get_level_copy()

  index  = sprite_index++
  sprite =
    kind:     sprite_dict.kind
    position: sprite_dict.position

  if level.sprites[index]?
    $.extend level.sprites[index], sprite
  else
    level.sprites.push sprite

  custom_level.set level

delete_sprite = (world, sprite) ->
  level_sprite_index = get_sprite_index sprite

  return unless level_sprite_index > -1

  level = get_level_copy()
  level.sprites.splice level_sprite_index, 1

  custom_level.set level

url = ->
  search = queryString.parse location.search
  search.custom = JSON.stringify custom_level.get()
  "#{location.origin}#{location.pathname}?#{queryString.stringify search}"

exports.changelog =
  world: (level) ->
    {
      _EXPORTS:          ['log_sprite_change', 'make_sprite', 'delete_sprite']
      log_sprite_change: log_sprite_change
      make_sprite:       make_sprite
      delete_sprite:     delete_sprite
      tag_name:          'a'
      name:              'custom level'
      href:              rx.bind url
    }

  set_custom: (custom) ->
    custom_level.set custom

