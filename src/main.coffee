#
# main.coffee
#
# Role: start the app
#
# Responsibility:
# * load top-level modules
# * initalize game based on query string
# * render and append to body of HTML
# * run tests if local
#

# Preamble
_.mixin(_.str.exports())
#rx =  require('../../reactive-coffee/src/reactive')
rx = require 'reactive-coffee'
sys = require 'sys'

# Dependencies

{my} = require './my'
{god} = require './god'
{game} = require './game'
{layout} = require './layout'
{render} = require './render'
# {config} = require('./config')

game_dict = game({name: 'example', level: 1})
config = layout(game_dict)
world = god(rx, config)
console.log "root world", sys.inspect(world.doc.x)
main = ->
  $('body').append(
    # render(world)
  )
  
# Instantiate our main view
$(main)
# Run Tests
{test} = require('./test') if my.test
test(rx) if my.test
