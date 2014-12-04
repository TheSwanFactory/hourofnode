# http://stackoverflow.com/questions/879152/ how-do-i-make-javascript-beep
# http://jsfiddle.net/55Kfu/
#

{my} = require '../../my'

beep = do ->
  context = new(window.audioContext || window.webkitAudioContext)
  (duration, type, on_end) ->
    duration = +duration
    type = (type % 5) || 0 # Only 0-4 are valid types.
    on_end = () -> "beep" unless _.isFunction on_end

    speaker = context.createOscillator()
    speaker.type = type
    speaker.connect context.destination
    speaker.noteOn 0
    turn_off = -> speaker.noteOff(0); on_end();
    setTimeout turn_off, duration

exports.events = {
  _LABEL: "events"
  interval: my.duration.step
  speed: 0
  _EXPORTS: ['step', 'stop', 'play', 'error', 'done']

  step: (world, button) ->
    console.log 'stepping'
    world.send 'tick'
    world.send 'fetch'
    world.send 'execute'
    world.send 'prefetch'

  stop: (world, button) ->
    if button
      button.put 'name',       'play'
      button.put my.key.label, 'play'
    world.put 'speed', 0

  play: (world, button) ->
    button.put 'name',       'stop'
    button.put my.key.label, 'stop'
    world.put 'speed', 1
    step_and_repeat = (self) ->
      speed = world.get('speed')
      if speed > 0
        delay = world.get('interval') / speed
        world.send 'step'
        setTimeout((-> self(self)), delay)
    step_and_repeat(step_and_repeat)

  error: (world, message) ->
    console.error message
    beep(my.duration.tone, 1)

  done: (world, args) ->
    success = args > 0
    message = if success then 'victory' else 'failure'
    world.send 'stop'
    alert message
    window.open world.get('next_url'), '_self'
    # TODO: Make this a full-fledged dialog
    # Add retry, next level, select levels, select game
    # And maybe share, find out more, sign up, etc.

}
