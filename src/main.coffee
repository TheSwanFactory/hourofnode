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

_.mixin(_.str.exports())
rx = require 'reactive-coffee'
###
    rx = require '../../reactive-coffee/src/reactive'
    console.log "WARNING: Loading local copy of reactive-coffee"
###
        
# Dependencies

{load} = require './load'
{render} = require './render'

# default_query = {game: 'sampler', level: 1}
default_query = {game: 'tutorial', level: 1}
parsed_query = queryString.parse(location.search)

world = load rx, _.extend(default_query, parsed_query)

main = ->
  $('body').append(
    render(world) if my.online
  )

# Instantiate our main view
$(main)
# Run Tests
{test} = require('./test') if my.test
test(rx) if my.test
