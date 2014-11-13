# Preamble
_.mixin(_.str.exports())
#rx =  require('../../reactive-coffee/src/reactive')
rx = require 'reactive-coffee'

# Dependencies

{my} = require './my'
{god} = require './god'
{game} = require './game'
{layout} = require './layout'
# {config} = require('./config')

game_dict = game({name: 'example', level: 1})
config = layout(game_dict)
world = god(rx, config)

main = ->
  $('body').append(
    # world.call('render')
  )
  
# Instantiate our main view
# $(main)
# Run Tests
{test} = require('./test') if my.test
test(rx) if my.test
