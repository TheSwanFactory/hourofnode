# Preamble

_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')

# Dependencies

{god} = require('./god')
{config} = require('./config')
{draw} = require('./draw')
# {control} = require('./control')

{test} = require('./test')

world = god(rx, config)

main = ->
  $('body').append(
    draw(world)
    #control(T, world)
  )
  
# Run Tests
  console.log "Running tests..."
test(rx)
# Instantiate our main view
$(main)
