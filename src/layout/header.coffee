{my} = require '../my'
{make} = require '../render/make'

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
      "/"
      level.get('goal')[key].toString()
    ]
  make.rows 'header', [
    make.columns 'progress', [
      "Level"
      level.get('level_index').toString()
      "of"
      level.get('level_count').toString()
    ]
    make.columns 'stats', [
      metric 'click'
      metric 'brick'
      metric 'tick'
    ]
  ]
