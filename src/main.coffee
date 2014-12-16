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
global._     = require 'underscore'
global.$     = global.jQuery = require 'jquery'
_.str        = require 'underscore.string'

require 'jquery-ui'

_.mixin(_.str.exports())

{my}         = require './my'
sys          = require 'sys'
queryString  = require 'query-string'
package_json = require '../package.json'
rx = require 'reactive-coffee'
###
    rx = require '../../reactive-coffee/src/reactive'
    console.warn "Loading local copy of reactive-coffee"
###

# Dependencies

{my}     = require './my'
{load}   = require './load'
{render} = require './render'

# default_query = {game: 'sampler', level: 1}
default_query = {game: 'tutorial', level: 1}
parsed_query = queryString.parse(location.search)

world = load rx, _.extend(default_query, parsed_query)

main = ->
  $('#contents').css(height: my.page_dimensions[1]).append(
    render(world) if my.online
  )
  $('#version').append package_json.version

# Instantiate our main view
$(main)
