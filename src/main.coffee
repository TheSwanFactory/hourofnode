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
turtles = world.find_child('turtles')
assert turtles, "should be one turtles object"
current = turtles.find_child()
world.put('current', current)

main = ->
  $('body').append(
    draw(world)
  )
  
# Instantiate our main view
$(main)
# Run Tests
test(rx)
