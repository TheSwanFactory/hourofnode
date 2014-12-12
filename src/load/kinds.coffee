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
      color: 'lime'
      actions: {bump: ['reverse']}
      direction: [1,0]
      paths: [
        "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
        "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
      ]
    }
    log: {
      name: 'log'
      running: 'run'
      editing: 'run'
      editable: false
      obstruction: true
      position: [7,0]
      color: 'burlywood'
      paths: [
        "M#{OFFSET+ INSET/4},#{OFFSET} h#{INSET/2} v#{INSET} h-#{INSET/2} v-#{INSET}"
      ]
    }
    egg: {
      name: 'egg'
      editable: true
      obstruction: false
      position: [0,7]
      color: 'yellow'
      paths: [
        "M#{OFFSET},#{RADIUS+OFFSET}
         a#{RADIUS},#{RADIUS} 0 1,1 #{INSET},0
         a#{RADIUS},#{RADIUS} 0 1,1 -#{INSET},0"
      ]
    }
    pad: {
      name: 'exit'
      running: 'run'
      editing:  'run'
      editable: false
      obstruction: false
      position: [7,7]
      color: 'green'
      actions: {bump: ['_victory']}
      paths: [
        # audrey's raw source
        #"M220 268 c0 -8 5 -19 12 -26 16 -16 3 -15 -33 3 -16 9 -34 13 -39 10 -11 -7 -13 -45 -4 -70 10 -26 74 -53 116 -48 99 13 85 117 -19 138 -25 5 -33 3 -33 -7z"
        # my version using http://editor.method.ac/
        "m25, 57 c0,-3.288612 1.517857,-7.810452 3.642857,-10.687984c4.857143,-6.577221 0.910717,-6.166142 -10.017857,1.233227c-4.857143,3.699688 -10.321428,5.343994 -11.839285,4.110764c-3.339286,-2.877537 -3.946429,-18.498428 -1.214286,-28.775337c3.035714,-10.687981 22.464286,-21.78704 35.214284,-19.731659c30.053574,5.343991 25.803574,48.095921 -5.767857,56.728523c-7.589283,2.055374 -10.017857,1.233231 -10.017857,-2.877533z"
        # old diamond source
        #"M0,#{SCALE} l#{SCALE},#{SCALE} l#{SCALE},-#{SCALE} l-#{SCALE},-#{SCALE} Z"
      ]

    }
  }

}
