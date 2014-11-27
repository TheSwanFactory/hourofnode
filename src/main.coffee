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
sys = require 'sys'

if not my.online
  rx = require './render/rx_mock'
else
  _.mixin(_.str.exports())
  if my.reactive_debug
    rx = require '../../reactive-coffee/src/reactive'
    console.log "WARNING: Loading local copy of reactive-coffee"
  else
    rx = require 'reactive-coffee'

# Dependencies

{game} = require './game'
{render} = require './render'

world = game(rx, {file: 'example', level: 0})

main = ->
  $('body').append(
    render(world) if my.online
  )

# Instantiate our main view
$(main)
# Run Tests
{test} = require('./test') if my.test
test(rx) if my.test
