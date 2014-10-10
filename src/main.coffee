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

{draw_grid} = require('./draw_grid')
grid_size = 640
grid_split = 8

main = ->

  $('body').append(
    T.h1 "Rohan's Teenage Robot Turtles"
    T.p "world: #{world.get('size')} pixels in #{ world.get('split')} chunks"
    #draw(SVG, world)
    SVG.svg {
      xmlns: "http://www.w3.org/2000/svg"
      "xmlns:xlink": "http://www.w3.org/1999/xlink"
      class: 'svg_grid'
      width: grid_size  
      height: grid_size  
    }, bind -> _.flatten [
      draw_grid(SVG, grid_size, grid_split)
    ]
    T.p {class: "text"}, "This is a post-SVG Element"
  )

# Instantiate our main view
$(main)
