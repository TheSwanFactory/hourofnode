{my} = require '../my'
{make} = require '../render/make'

exports.header = (level_dict) ->
  report = (event, key) ->
    dict = { _LABEL: key, _EXPORTS: [event], name: (world) -> world.get(key) }
    dict[key] = 0
    dict[event] = (world, args) ->
      console.log "log event #{event}", world.get(key)
      world.put key, world.get(key) + 1
    dict
  metric = (event) ->
    key = "#{event}s"
    make.columns key, [
      _.capitalize "#{key}: "
      report(event, key)
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
