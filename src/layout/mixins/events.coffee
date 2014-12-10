# http://stackoverflow.com/questions/879152/ how-do-i-make-javascript-beep
# http://jsfiddle.net/55Kfu/
#

{my}        = require '../../my'
{beep}      = require './beep'
done_dialog = require './done_dialog'

finished = false

exports.events = {
  _LABEL: "events"
  interval: my.duration.step
  speed: 0
  _EXPORTS: ['reload', 'step', 'stop', 'run', 'error', 'done']

  reload: (world, button) ->
    location.reload()

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

    world.send 'rewind'
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
    beep()
    alert "Uh-oh! #{message}"

  done: (world, args) ->
    success = args > 0
    world.send 'stop'
    finished = true
    if success
      world.up.add_child done_dialog.world(world)
      $('.done_dialog').dialog
        modal: true
        title: 'Level Complete'
        open:  done_dialog.share_dialog
        width: 400
    # Add retry, next level, select levels, select game
    # And maybe share, find out more, sign up, etc.

}
