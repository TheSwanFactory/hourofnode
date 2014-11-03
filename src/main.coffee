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

div = rx.rxt.tags.div
main = ->
  $('body').append(
    div {id: "controls"}
    div {id: "grid"}
    div {id: "inspector"}
    draw world.find_child('layout')
    #render world.find_child('ui')
  )
  
# Instantiate our main view
$(main)
# Run Tests
test(rx) if my.test
