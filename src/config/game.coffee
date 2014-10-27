exports.game = {
  _LABEL: "game"
  interval: 500
  speed: 0
  _EXPORTS: ["run", "stop"]
  run: (world, args) ->
    world.put('speed', 1)
    step_and_repeat = (self) ->
      speed = world.get('speed')
      if speed > 0
        delay = world.get('interval') / speed 
        world.send(".turtles", "step")
        setTimeout((-> self(self)), delay)
    step_and_repeat(step_and_repeat)
  stop: (world, args) ->
    world.put('speed', 0)
}