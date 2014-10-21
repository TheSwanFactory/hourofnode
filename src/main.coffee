# Preamble

_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')

# Dependencies

{god} = require('./god')
{config} = require('./config')
{draw} = require('./draw')

{test} = require('./test')

world = god(rx, config)

main = ->
  $('body').append(
    draw(world)
  )
  
# Run Tests
test(rx)
# Instantiate our main view
$(main)
