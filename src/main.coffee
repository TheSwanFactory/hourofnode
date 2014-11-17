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
# TODO: server-side include underscore, underscore.string, jquery

{my} = require './my'
if my.online
  _.mixin(_.str.exports())
  if my.reactive_debug
    rx = require '../../reactive-coffee/src/reactive'
    console.log "WARNING: Loading local copy of reactive-coffee"
  else
    rx = require 'reactive-coffee'
else
  rx = require './test/rx_mock'
sys = require 'sys'

# Dependencies

{god} = require './god'
{game} = require './game'
{layout} = require './layout'
{render} = require './render'

game_dict = game({name: 'example', level: 1})
config = layout(game_dict)
world = god(rx, config)
#console.log "root world", my.inspect(world)

main = ->
  $('body').append(
    render(world) if my.online
  )

# Instantiate our main view
$(main)
# Run Tests
{test} = require('./test') if my.test
test(rx) if my.test
