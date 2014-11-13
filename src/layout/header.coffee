{my} = require '../my'
{make} = require '../render/make'

exports.header = (level_dict) ->
  metric = (key) ->
    make.columns 'key', [
      "#{key}: "
      {_LABEL: key, name: (world) -> world.get(key) or 0}
      "/"
      "#{level_dict.goal[key]}"
    ]
  make.rows 'header', [
    {_LABEL: 'game', name: level_dict.game, name_style: {font_size: 36}}
    {_LABEL: 'level', name: level_dict.name, name_style: {font_size: 24}}
    make.columns 'progress', [
      "#{level_dict.level_index}"
      "of"
      "#{level_dict.level_count}"
    ]
    make.columns 'stats', [
      metric 'ticks'
      metric 'clicks'
      metric 'bricks'
    ]
  ]
