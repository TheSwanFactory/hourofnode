{my} = require '../my'
{make} = require '../render/make'


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

  make.rows 'header', [
    { _LABEL: 'level_name', name: level.get('level_name') }
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
