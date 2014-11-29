# http://stackoverflow.com/questions/879152/ how-do-i-make-javascript-beep
# http://jsfiddle.net/55Kfu/
# 

{my} = require '../../my'

beep = ->
  context = new(window.audioContext || window.webkitAudioContext)
  return (duration, type, on_end) ->
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
  _EXPORTS: ['step', 'stop', 'run', 'error', 'done']
  
  step: (world, args) ->
    console.log 'stepping'
    world.send 'tick'
    world.send 'decide'
    
  stop: (world, args) -> world.put('speed', 0)
  
  run: (world, args) ->
    world.put('speed', 1)
    step_and_repeat = (self) ->
      speed = world.get_plain('speed')
      if speed > 0
        delay = world.get_plain('interval') / speed
        world.send 'step'
        setTimeout((-> self(self)), delay)
    step_and_repeat(step_and_repeat)
    
  error: (world, message) ->
    console.error message
    beep(my.duration.tone, 2)

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
