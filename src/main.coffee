# Preamble
_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')
assert = require 'assert'

# Dependencies

{god} = require('./god')
{config} = require('./config')
{draw} = require('./draw')

{test} = require('./test')

world = god(rx, config)
assert turtles = world.find_child('turtles'), "can not find turtles"
#assert layout = world.find_child('layout'), "can not find layout"
assert sprites = world.find_path('layout.sprites'), "can not find sprites"
current = turtles.find_child()
world.put('current', current)
turtles.map_children (turtle) ->
  sprite = sprites.call('NewFromTurtle', turtle)

main = ->
  $('body').append(
    draw(world)
  )
  
# Instantiate our main view
$(main)
# Run Tests
test(rx)
