{my} = require '../my'

SCALE = my.cell_width
RADIUS = 0.9 * SCALE
OFFSET = SCALE / 6
INSET = 2 * RADIUS

exports.game = {
  name: "Kinds"
  assume: 'geometry'

  kinds: {
    turtle: {
      name: 'me'
      running: 'run'
      editing: 'run'
      editable: true
      obstruction: true
      position: [0,0]
      fill: 'lime'
      actions: {interrupt: ['reverse']}
      direction: [1,0]
      paths: [
        "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
        "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
      ]
    }
    log: {
      name: 'log'
      editable: false
      obstruction: true
      position: [7,0]
      fill: 'brown'
      paths: [
        "M#{OFFSET+ INSET/2},#{OFFSET} h#{INSET/2} v#{INSET} h-#{INSET/2} v-#{INSET}"
      ]
    }
    egg: {
      name: 'egg'
      editable: true
      obstruction: false
      position: [0,7]
      fill: 'yellow'
      paths: [
        "M#{OFFSET},#{RADIUS+OFFSET}
         a#{RADIUS},#{RADIUS} 0 1,1 #{INSET},0
         a#{RADIUS},#{RADIUS} 0 1,1 -#{INSET},0"
      ]
    }
    gate: {
      name: 'exit'
      editable: false
      obstruction: false
      position: [7,7]
      fill: 'green'
      actions: {interrupt: ['_victory']}
      paths: [
        "M0,#{SCALE} l#{SCALE},#{SCALE} l#{SCALE},-#{SCALE} l-#{SCALE},-#{SCALE} Z"
      ]

    }
  }

}
