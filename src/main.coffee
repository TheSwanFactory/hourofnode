# Preamble

_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')
bind = rx.bind
T = rx.rxt.tags
S = rx.rxt.svg_tags

# Dependencies

# {items} = require('./model')
# {editor} = require('./editor')
{draw_grid} = require('./draw_grid')
grid_size = 640
grid_split = 8

main = ->

  $('body').append(
    T.h1 "Rohan's Teenage Robot Turtles"
    S.svg {
      xmlns: "http://www.w3.org/2000/svg"
      "xmlns:xlink": "http://www.w3.org/1999/xlink"
      class: 'svg_grid'
      width: grid_size  
      height: grid_size  
    }, bind -> _.flatten [
      draw_grid(S, grid_size, grid_split)
    ]
    T.p {class: "text"}, "This is a post-SVG Element"
  )

# Instantiate our main view
$(main)
