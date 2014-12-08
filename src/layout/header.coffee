{my} = require '../my'
{make} = require '../render/make'
{done_dialog} = require './done_dialog'


exports.header = (level) ->

  anchor = (label, key) ->
    make.anchor label, level.get key

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

  make.rows 'header', [
    make.columns 'progress', [
      "Level #{level.get('level_index')} of #{level.get('level_count')}"
      anchor "skip", 'next_params'
    ]
    { name: 'Level Progress', _LABEL: 'level_progress' }
    make.columns 'stats', [
      metric 'click'
      metric 'brick'
      metric 'tick'
    ]
    done_dialog(level)
  ]
