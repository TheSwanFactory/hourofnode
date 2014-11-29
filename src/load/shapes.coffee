{my} = require '../my'

SCALE = my.cell_width
RADIUS = 0.9 * SCALE
OFFSET = SCALE / 6
INSET = 2 * RADIUS

exports.game = {
  name: "Shapes"
  assume: 'kinds'
  
  shapes: {
    turtle: [
      "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
      "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
    ]
    diamond: [
      "M0,#{SCALE} l#{SCALE},#{SCALE} l#{SCALE},-#{SCALE} l-#{SCALE},-#{SCALE} Z"
    ]
    square: [
      "M#{OFFSET},#{OFFSET} h#{INSET} v#{INSET} h-#{INSET} v-#{INSET}"
    ]
    circle: [
      "M#{OFFSET},#{RADIUS+OFFSET}
       a#{RADIUS},#{RADIUS} 0 1,1 #{INSET},0
       a#{RADIUS},#{RADIUS} 0 1,1 -#{INSET},0
       "
    ]
  }
  
}