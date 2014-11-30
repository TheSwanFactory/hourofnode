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
queryString = require 'query-string'

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

{load} = require './load'
{render} = require './render'

default_query = {game: 'example', level: 1}
parsed_query = queryString.parse(location.search)

world = load rx, my.extend(default_query, parsed_query)

main = ->
  $('body').append(
    render(world) if my.online
  )

# Instantiate our main view
$(main)
# Run Tests
{test} = require('./test') if my.test
test(rx) if my.test
