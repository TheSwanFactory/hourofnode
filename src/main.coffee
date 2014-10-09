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

main = ->

  $('body').append(
    T.h1 "Rohan's Teenage Robot Turtles"
    S.svg {class: 'graphics', width: 500, height: 300}, bind ->[
      S.rect {
        x:10
        y:20
        height:100
        width:100
        fill:"green"
        stroke:"blue"
        rx: 10
        ry: 10
      }
      S.circle {
        cx:100
        cy:150
        r:20
        fill:"red"
        stroke:"blue"
      }
    ]
    T.p "Why is this not animating at #{(new Date()).toString()}"
  )

# Instantiate our main view
$(main)
