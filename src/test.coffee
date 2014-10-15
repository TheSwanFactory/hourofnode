# Preamble

_.mixin(_.str.exports())
rx =  require('../../reactive-coffee/src/reactive')
T = rx.rxt.tags
SVG = rx.rxt.svg_tags

test = ->
  $('body').prepend(
    T.h1 "The Hour of Node Test Suite"
  )

# Instantiate our main view
$(test)
