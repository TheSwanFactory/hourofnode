{make}      = require '../../render/make'
{my}        = require '../../my'
{beep}      = require './beep'
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

  star_count = ->
    metrics
      .map((key) -> level.get(key) <= goals[key])
      .filter((key) -> key == true)
      .length

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

  publish = make.button 'Publish', ((world) ->
    $element = $ world.element
    $.ajax(
      url: "#{my.level_server}/levels"
      type: 'POST'
      data:
        url: changelog.url()
    ).success(->
      $element.removeClass('loading').addClass('success')
    ).error(->
      $element.removeClass('loading').addClass('error')
      beep()
      alert 'Uh-oh! There was an error. Please click on "Get Help" at the bottom of the page and report it'
    )

    $element.addClass('changed').addClass('loading').attr('disabled', 'disabled')
  ), { class: 'publish' }

  share_message = "I programmed a turtle to solve this level on the Hour of NODE. Can you?"

  messages = [
    { class: 'stars', name: star_string() }
    { class: 'metrics', name: metrics.join ' | ' }
    { class: 'message', name: level.get('message') }
    { class: 'share-button', name: share_message }
    publish
  ]

  if star_count() < metrics.length
    hint = 'Hint: Use fewer clicks, bricks, or ticks to improve your score'
    messages.push class: 'hint', name: hint

  if level.get('completion', false)? && level.get('last_level')
    messages.push
      class: 'completion'
      name:  level.rx().rxt.rawHtml("<p>#{level.get 'completion', false}</p>")

  {
    class: 'done_dialog',
    _CHILDREN: [make.rows '', [].concat(messages, buttons)]
    width: ''
  }
