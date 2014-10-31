# Preamble
_.mixin(_.str.exports())
#rx =  require('../../reactive-coffee/src/reactive')
rx = require 'reactive-coffee'

# Dependencies

{my} = require('./my')
{god} = require('./god')
{config} = require('./config')
{draw} = require('./draw')
{test} = require('./test') if my.test

world = god(rx, config)

main = ->
  $('body').append(
    draw world.find_child('layout')
  )
  
# Instantiate our main view
$(main)
# Run Tests
test(rx) if my.test
