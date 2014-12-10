{my}    = require '../my'
{make}  = require '../render/make'
{utils} = require '../utils'

exports.header = (level) ->

  anchor = (label, key) ->
    href = level.get key
    if href then make.anchor(label, href) else " "

  track = (event, key) ->
    dict = { _LABEL: key, _EXPORTS: [event], name: -> level.get(key) }
    level.get(key) || level.put(key, 0)
    dict[event] = (world, args) ->
      offset = if (args == -1) then -1 else 1
      level.put key, level.get(key) + offset
    dict

  metric = (event) ->
    key = "#{event}s"
    make.columns key, [
      _.capitalize "#{key}: "
      track(event, key)
      " / #{level.get('goal')[key]}"
    ]

  level_name_key = 'level_name'
  level_name = utils.editable_field
    _LABEL:  level_name_key
    name:    level.get level_name_key
    edit_mode: -> level.get 'edit_mode'
    after_save: (world, value) ->
      world.send 'level_change', [level_name_key, value]
      level.put level_name_key, value

  make.rows 'header', [
    level_name
    make.columns 'progress', [
      anchor "<", 'previous_params'
      " Level #{level.get('level_index')} of #{level.get('level_count')}"
      anchor ">", 'next_params'
    ]
    make.columns 'stats', [
      metric 'click'
      metric 'brick'
      metric 'tick'
    ]
  ]
