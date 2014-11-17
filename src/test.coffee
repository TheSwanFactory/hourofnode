#
# test.coffee
# Role: Ensure the code does what we think it does
# Responsibility: 
# * load and run test modules
# * turn screen green if succesful, red if failed, yellow if not run

test = require 'tape'
undo = require('tap-browser-color')()
# test.createStream().pipe(process.stdout)
# undo()
# Test Modules

{test_god} = require './god/test_god'
{test_world} = require './god/test_world'
{test_game} = require './game/test_game'
{test_layout} = require './layout/test_layout'
{test_render} = require './render/test_render'

run_tests = (rx) ->
  test_god(test, rx)
  test_world(test, rx)
  test_game(test, rx)
  test_layout(test, rx)
  test_render(test, rx)

exports.test = (rx) ->
  console.log "Running tests..."
  run_tests(rx)
  console.log "...done!"
