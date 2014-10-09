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
    T.h1 "Rohan's Teenage Robot Turtles v4"
    S.svg {class: 'graphics'}, bind ->[
      S.rect {x:10, y:20, height:100, width:100, fill:"blue", stroke:"red"}, bind -> [
        S.animatetransform {
          attributeName: "transform"
          begin: "0s"
          dur: "20s"
          type: "rotate"
          from: "0 60 60"
          to: "360 60 60"
          repeatCount: "indefinite" 
        }
      ] 
    ]
    T.p "Why is this not working at #{(new Date()).toString()}"
  )

# Instantiate our main view
$(main)
