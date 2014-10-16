# Preamble

_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')
T = rx.rxt.tags
SVG = rx.rxt.svg_tags

# Dependencies

{god} = require('./god')
{config} = require('./config')
{draw} = require('./draw')
{control} = require('./control')

#world = god(rx, config)

{test} = require('./test')

main = ->
  $('body').append(
    T.h1 "Rohan's Teenage Robot Turtles"
    T.p "world: #{world.get('size')} pixels in #{ world.get('split')} chunks"
    draw(SVG, world)
    control(T, world)
  )
  
# Run Tests
  console.log "Running tests..."
test()
# Instantiate our main view
#$(main)
