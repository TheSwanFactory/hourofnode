# Preamble

_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')
bind = rx.bind
T = rx.rxt.tags
S = rx.rxt.svg_tags


# Dependencies

# {items} = require('./model')
{editor} = require('./editor')

# Define our main view
cell_count = 8
cell_size = 90
map_size = cell_count * cell_size 

lines = [1,2,3]
draw_xgrid = (x) ->
  S.line {
    x1: x
    y1: 1
    x2: x
    y2: map_size-1
    stroke: "#ffffff"
  }

main = ->

  $('body').append(
    T.h1 "Rohan's Teenage Robot Turtles"
    S.svg {
      xmlns: "http://www.w3.org/2000/svg"
      "xmlns:xlink": "http://www.w3.org/1999/xlink"
      class: 'map'
      width: map_size 
      height: map_size 
    }, bind ->[
      S.rect {
        height: map_size 
        width: map_size 
        fill: "#ccffcc"
        stroke: "black"
      }
      # lines.map (x) -> 
      S.g {class: "grid-lines"},[
        draw_xgrid(90)
        draw_xgrid(180)
      ]
    ]
    T.p {class: "text"}, "This is a post-SVG Element"
  )

# Instantiate our main view
$(main)
