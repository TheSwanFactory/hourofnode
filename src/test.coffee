#
# test.coffee
#
# Role: Ensure the code does what we think it does
#
# Responsibility: 
# * load and run test modules
# * turn screen green if succesful, red if failed, yellow if not run

test     = require 'tape'
global._ = require 'underscore'
global.$ = global.jQuery = require 'jquery'
_.str    = require 'underscore.string'
_.mixin(_.str.exports())
rx       = require 'reactive-coffee'
global.assert   = require 'assert'
# test.createStream().pipe(process.stdout)
# undo()
# Test Modules

describe 'This', ->
  describe 'that', ->
    it 'is cool', ->
      assert.equal 1, 1

{test_god} = require './god/test_god'
{test_world} = require './god/test_world'
{test_render} = require './render/test_render'
{test_game} = require './load/test_game'
{test_layout} = require './layout/test_layout'

run_tests = (rx) ->
  test_god(test, rx)
  test_world(test, rx)
  test_render(test, rx)
  test_game(test, rx)
  test_layout(test, rx)

console.log "Running tests..."
run_tests(rx)
console.log "...done!"
