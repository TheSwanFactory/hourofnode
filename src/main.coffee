# Preamble

_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')
bind = rx.bind
T = rx.rxt.tags
SVG = rx.rxt.svg_tags

# Dependencies

{god} = require('./god')
{config} = require('./config')
{draw} = require('./draw')

world = god(rx, config)

main = ->

  $('body').append(
    T.h1 "Rohan's Teenage Robot Turtles"
    T.p "world: #{world.get('size')} pixels in #{ world.get('split')} chunks"
    draw(SVG, world)
    T.p {class: "text"}, "This is a post-SVG Element"
  )

# Instantiate our main view
$(main)
