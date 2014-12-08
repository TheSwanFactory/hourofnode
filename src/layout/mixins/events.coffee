# http://stackoverflow.com/questions/879152/ how-do-i-make-javascript-beep
# http://jsfiddle.net/55Kfu/
#

{my} = require '../../my'

beep = do ->
  context = window.audioContext || window.webkitAudioContext
  return ((duration, type, on_end) -> on_end()) unless context

  context = new context
  (duration, type, on_end) ->
    duration = +duration
    type = (type % 5) || 0 # Only 0-4 are valid types.
    on_end = (-> "beep") unless _.isFunction on_end

    speaker = context.createOscillator()
    speaker.type = 'custom'
    speaker.frequency.value = 540
    speaker.connect context.destination
    speaker.noteOn 0
    turn_off = ->
      speaker.noteOff 0
      on_end()
    setTimeout turn_off, duration

share_dialog = ->
  share = '.share-button'
  text  = $(share).text()
  new Share share,
    description: text
    networks:
      facebook:
        app_id:  1510955112514265
      email:
        description: text + "\n\nCheck it out here!: " + document.location.href

finished = false

exports.events = {
  _LABEL: "events"
  interval: my.duration.step
  speed: 0
  _EXPORTS: ['step', 'stop', 'run', 'error', 'done']

  step: (world, button) ->
    world.send 'tick'
    world.send 'fetch'
    return if finished
    world.send 'execute'
    world.send 'prefetch'

  stop: (world, button) ->
    if button
      button.put 'name',       'run'
      button.put my.key.label, 'run'
    world.put 'running', false

  run: (world, button) ->
    button.put 'name',       'stop'
    button.put my.key.label, 'stop'

    has_run_before = world.get('running')?

    world.send 'reset'
    world.put 'running', true
    speed = my.speed
    delay = world.get('interval') / speed

    step_and_repeat = ->
      running = world.get('running')
      return unless running
      world.send 'step'
      setTimeout step_and_repeat, delay

    setTimeout(step_and_repeat, if has_run_before then delay * 1.5 else 0)

  error: (world, message) ->
    beep my.duration.tone, 3, -> alert("Oops! #{message}")

  done: (world, args) ->
    success = args > 0
    world.send 'stop'
    finished = true
    if success
      $('.done_dialog').dialog
        modal: true
        title: 'Level Complete'
        open:  share_dialog
    # Add retry, next level, select levels, select game
    # And maybe share, find out more, sign up, etc.

}
