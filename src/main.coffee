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

main = ->
  $('body').append(
    draw world.find_child('layout')
  )
  
# Instantiate our main view
$(main)
# Run Tests
test(rx)
