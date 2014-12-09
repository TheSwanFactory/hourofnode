queryString = require 'query-string'
rx = require 'reactive-coffee'

index_of_conditional = (list, condition) ->
  index = -1
  for item, i in list
    return index = i if condition(item)

  index

custom_level = rx.cell({ sprites: [] })

log_sprite_change = (world, args) ->
  [sprite, key, value] = args

  level_sprite_index = index_of_conditional sprite.up.find_children(), (s) ->
    s.uid == sprite.uid

  return unless level_sprite_index > -1

  level = $.extend {}, custom_level.get()
  level.sprites[level_sprite_index][key] = value

  custom_level.set level

url = ->
  search = queryString.parse location.search
  search.custom = JSON.stringify custom_level.get()
  "#{location.origin}#{location.pathname}?#{queryString.stringify search}"

exports.changelog =
  world: (level) ->
    sprites = []
    sprites.push({}) for [1..level.get('sprites').length()]

    $.extend true, custom_level.get().sprites, sprites

    {
      _EXPORTS:          ['log_sprite_change']
      log_sprite_change: log_sprite_change
      tag_name:          'a'
      name:              'custom level'
      href:              rx.bind url
    }

  set_custom: (custom) ->
    custom_level.set custom

