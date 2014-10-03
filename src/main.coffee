# Preamble

_.mixin(_.str.exports())
bind = rx.bind
T = rxt.tags

# Dependencies

{items} = require('./model')
{editor} = require('./editor')

# Import SVG Tags for reactive-coffee 1.2.2; should be upstreamed in 1.2.4 or so

tags = ['svg','g','rect', 'circle', 'ellipse', 'line', 'polyline', 'polygon', 'path', 'marker', 'text', 'tspan', 'tref', 'textpath', 'switch', 'image', 'a', 'defs', 'symbol', 'use', 'animateTransform', 'stop', 'linearGradient', 'radialGradient', 'pattern', 'clipPath', 'mask', 'filter', 'feMerge', 'feOffset', 'feGaussianBlur', 'feMergeNode']
S = _.object([tag, rxt.mktag(tag)] for tag in tags)

# Define our main view

main = ->

  $('body').append(
    T.h1 "Rohan's Teenage Robot Turtles"
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
  )

# Instantiate our main view
$(main)
