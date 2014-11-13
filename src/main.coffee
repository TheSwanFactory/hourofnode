# Preamble
_.mixin(_.str.exports())
#rx =  require('../../reactive-coffee/src/reactive')
rx = require 'reactive-coffee'

# Dependencies

{my} = require('./my')
{god} = require('./god')
{config} = require('./config')
{test} = require('./test') if my.test

# game_dict = game({name: 'example', level: 1})
# config = layout(game_dict)

world = god(rx, config)
main = ->
  $('body').append(
    world.send('render')
  )
  
# Instantiate our main view
$(main)
# Run Tests
test(rx) if my.test
