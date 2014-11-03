# Preamble
_.mixin(_.str.exports())
#rx =  require('../../reactive-coffee/src/reactive')
rx = require 'reactive-coffee'

# Dependencies

{my} = require('./my')
{god} = require('./god')
{config} = require('./config')
{test} = require('./test') if my.test

world = god(rx, config)
layout = world.find_child('layout')

div = rx.rxt.tags.div
main = ->
  $('body').append(
    layout.call('render')
    #render world.find_child('ui')
  )
  
# Instantiate our main view
$(main)
# Run Tests
test(rx) if my.test
