# Preamble
_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')
T = rx.rxt.tags

{test_god} = require('./test/test_god')

tape = require 'tape'
test = (arg, f) ->
  tape arg, f
  
main = ->
  $('body').append(
    T.h2 "Running tests..."
    test_god(test)
    T.h2 "...done."
  )

# Instantiate our main view
$(main)
