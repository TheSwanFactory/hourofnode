{god} = require('../god')
test = require 'tape'

exports.test_god = (rx) ->
  T = rx.rxt.tags
  
  test 'basic math', (t) ->
    t.equal 2, 2
    t.fail()
    t.end()

  T.h3 "Loaded test_god"
    