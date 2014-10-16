test = require 'tape'

# Test Modules

{test_god} = require('./test/test_god')

run_tests = (rx) ->
  test_god(test, rx) 

exports.test = (rx) ->
  console.log "Running tests..."
  run_tests(rx)
  console.log "...done!"
