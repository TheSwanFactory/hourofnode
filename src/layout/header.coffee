{my} = require '../my'
{make} = require '../render/make'

exports.header = (level_dict) ->
  metric = (key) ->
    make.columns key, [
      _.capitalize "#{key}: "
      {_LABEL: key, name: (world) -> world.get(key) or 0}
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
      metric 'ticks'
      metric 'clicks'
      metric 'bricks'
    ]
  ]
