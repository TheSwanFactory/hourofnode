{god} = require('../god')

exports.test_god = (test) ->
  test 'basic math', (t) ->
    t.equal 2, 2
    t.pass()
    t.end()
    