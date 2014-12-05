{my} = require '../my'
{make} = require '../render/make'
{dialogs} = require './dialogs'

exports.header = (level) ->

  track = (event, key) ->
    dict = { _LABEL: key, _EXPORTS: [event], name: (world) -> world.get(key) }
    dict[key] = level.get(key) or 0
    dict[event] = (world, args) ->
      offset = if (args == -1) then -1 else 1
      world.put key, world.get(key) + offset
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
      dialogs(level)
    ]
    { name: 'Level Progress', _LABEL: 'level_progress' }
    make.columns 'stats', [
      metric 'click'
      metric 'brick'
      metric 'tick'
    ]
  ]
