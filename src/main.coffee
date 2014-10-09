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
      S.ellipse {
        cx:60
        cy:50
        rx: 10
        ry: 30
        fill:"red"
        stroke:"blue"
      }
      S.line {
        x1:10
        y1:10
        x2: 100
        y2: 300
        stroke:"blue"
      }
      S.text {
        x: 100
        y: 20
        transform: "rotate(30 20,40)"
      }, "Test Text"
      S.text {
        id: "multi-line"
        x: 100
        y: 200
      }, [
        S.tspan "Multiple Text"
        S.tspan {dy: 20}, "More Text"
      ]
    ]
    T.p {class: "text"}, "This is a non-SVG Element"
  )

# Instantiate our main view
$(main)
