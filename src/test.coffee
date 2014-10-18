test = require 'tape'

# Test Modules

{test_god} = require('./test/test_god')
{test_world} = require('./test/test_world')
{test_config} = require('./test/test_config')

run_tests = (rx) ->
  #test_god(test, rx)
  #test_world(test, rx)
  test_config(test, rx)

exports.test = (rx) ->
  console.log "Running tests..."
  run_tests(rx)
  console.log "...done!"
