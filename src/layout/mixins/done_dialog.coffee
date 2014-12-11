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
        description: text + "\n\nClick: " + encodeURIComponent(changelog.url())

star = { fill: "", empty: "" }
metrics = ['clicks','bricks','ticks']

module.exports.world = (level) ->
  goals = level.get 'goal'

  dialogAction = (world) ->
    switch world.get('name')
      when 'Retry' then retry(world)
      when 'Next'  then next(world)
      else ''

  retry = (world) -> window.location.reload()

  next = (world) -> window.open world.get('next_url'), '_self'

  star_for = (key) ->
    return star.empty if level.get(key) > goals[key]
    star.fill

  star_string = ->
    result = metrics.map (key) -> star_for(key)
    result.join ' '

  buttons = make.buttons 'dialog', [
    'Retry',
    'Next'
  ], {}, dialogAction


  share_message = "I programmed a turtle to solve this level on the Hour of NODE. Can you?"

  hint = 'Hint: Use fewer clicks, bricks, or ticks to improve your score'
  messages = [
    { class: 'stars', name: star_string() }
    { class: 'metrics', name: metrics.join ' | ' }
    { class: 'message', name: level.get('message') }
    { class: 'share-button', name: share_message }
    { class: 'hint', hint }
  ]

  if level.get('completion', false)? && level.get('last_level')
    messages.push
      class: 'completion'
      name:  level.rx().rxt.rawHtml("<p>#{level.get 'completion', false}</p>")

  {
    class: 'done_dialog',
    _CHILDREN: [make.rows '', [].concat(messages, buttons)]
    width: ''
  }
