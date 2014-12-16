#
# test.coffee
#
# Role: Ensure the code does what we think it does
#
# Responsibility: 
# * load and run test modules
# * turn screen green if succesful, red if failed, yellow if not run

global._      = require 'underscore'
global.$      = global.jQuery = require 'jquery'
_.str         = require 'underscore.string'
_.mixin(_.str.exports())
global.rx     = require 'reactive-coffee'
global.assert = require 'assert'

assert.notOk = (falsey, message) ->
  assert.equal !!falsey, false, message

assert.true = (trueey, message) ->
  assert.ok trueey, message

assert.false = assert.notOk

{test_god} = require './test_god'
{test_world} = require './test_world'
{test_render} = require './test_render'
{test_game} = require './test_game'
{test_layout} = require './test_layout'

test_god()
test_world()
test_render()
test_game()
test_layout()
