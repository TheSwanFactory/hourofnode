{make}      = require '../../render/make'
{changelog} = require '../changelog'

module.exports.share_dialog = ->
  selector = '.share-button'
  text = $(selector).text()
  new Share selector, #External Library included from the web page
    description: text
    url:         changelog.url()
    networks:
      facebook:
        app_id:  1510955112514265
      email:
        description: text + "\n\nCheck it out here!: " + changelog.url()

module.exports.world = (level) ->
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

  star_count = ->
    ticks_diff  = level.get('ticks')  - goals.ticks
    clicks_diff = level.get('clicks') - goals.clicks
    bricks_diff = level.get('bricks') - goals.bricks

    # calculate total score with a minimum for each being 0
    extra_moves = [ticks_diff, clicks_diff, bricks_diff].reduce (sum, diff) ->
      sum + if diff < 0 then 0 else diff

    if extra_moves <= 0
      3
    else if extra_moves <= 3
      2
    else
      1

  star_string = ->
    stars = star_count()

    empty_stars = 3 - stars
    star_string = Array(stars + 1).join("") + Array(empty_stars + 1).join("")

    star_string

  buttons = make.buttons 'dialog', [
    'Retry',
    'Next'
  ], {}, dialogAction

  # TODO: refactor messages into an explicit array with conditional elements?
  messages = []

  messages.push
    class: 'stars'
    name:   star_string

  if level.get('message')?
    messages.push
      class: 'message'
      name:   level.get('message')

  messages.push
    class: 'share-button'
    name:   -> "I got #{star_count()} stars on the Hour of Node. See if you can beat my score!"

  messages.push
    class: 'hint'
    name:   'Hint: Use fewer clicks, bricks, or ticks to improve your score'

  {
    class: 'done_dialog',
    _CHILDREN: [make.rows '', [].concat(messages, buttons)]
    width: ''
  }
