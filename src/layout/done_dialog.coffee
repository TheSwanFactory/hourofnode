{make} = require '../render/make'

exports.done_dialog = (level) ->
  goals = level.get 'goal'

  dialogAction = (world) ->
    switch world.get('name')
      when 'Retry' then retry(world)
      when 'Next'  then next(world)
      else ''

  retry = (world) ->
    window.location.reload()

  next = (world) ->
    window.open world.get('next_url'), '_self'

  score = ->
    ticks_diff  = level.get('ticks')  - goals.ticks
    clicks_diff = level.get('clicks') - goals.clicks
    bricks_diff = level.get('bricks') - goals.bricks

    # calculate total score with a minimum for each being 0
    extra_moves = [ticks_diff, clicks_diff, bricks_diff].reduce (sum, diff) ->
      sum + if diff < 0 then 0 else diff

    stars = if extra_moves == 0
      3
    else if extra_moves <= 3
      2
    else
      1

    "Stars: #{stars}"

  buttons = make.buttons 'dialog', [
    'Retry',
    'Next'
  ], {}, dialogAction

  messages = [
    #{ name: -> "Ticks: #{level.get('ticks')} / #{goals.ticks}" }
    #{ name: -> "Clicks: #{level.get('clicks')} / #{goals.clicks}" }
    #{ name: -> "Bricks: #{level.get('bricks')} / #{goals.bricks}" }
    { name: score }
    'Use fewer clicks, bricks, or ticks to improve your score'
  ]

  if level.get('message')?
    messages.push level.get('message')

  {
    _LABEL: 'done_dialog',
    _CHILDREN: [make.rows '', [].concat(messages, buttons)]
  }
