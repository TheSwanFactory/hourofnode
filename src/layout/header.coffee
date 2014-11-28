{my} = require '../my'
{make} = require '../render/make'

exports.header = (level_dict) ->
  track = (event, key) ->
    dict = { _LABEL: key, _EXPORTS: [event], name: (world) -> world.get(key) }
    dict[key] = 0
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
      "#{level_dict.goal[key]}"
    ]
  make.rows 'header', [
    make.columns 'progress', [
      "Level"
      "#{parseInt level_dict.level_index}"
      "of"
      "#{level_dict.level_count}"
    ]
    make.columns 'stats', [
      metric 'click'
      metric 'brick'
      metric 'tick'
    ]
  ]
