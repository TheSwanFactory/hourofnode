test = require 'tape'

mock_rx = {
  map: ->
    {_label: 'map'}
  rxt: {
    tags: {}
    svg_tags: {}
  }
}

# Test Modules

{test_god} = require('./test/test_god')

run_tests = ->
  test_god(test, mock_rx) 

exports.test = () ->
  console.log "Running tests..."
  run_tests()
  console.log "...done!"
