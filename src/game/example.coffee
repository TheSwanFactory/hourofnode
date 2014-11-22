{my} = require '../my'
{vector} = require '../god/vector'

# TODO: Normalize to 100 or 1.00
SCALE = 30

me = {
  name: 'me'
  shape: 'turtle'
  position: [1,1]
  stroke: 'black'
  fill: 'blue'
  behavior: { first: ['left', 'forward'], repeat: ['forward', 'forward', 'right'], interrupt: ['reverse', 'right'] }
  editable: true
}

yu = my.dup me, {
  name: 'yu'
  position: [3,1]
  fill: 'green'
  behavior: { first: [], repeat: ['forward', 'forward', 'right', 'forward', 'forward'], interrupt: ['right']}
}

exit = {
  name: 'exit'
  shape: 'diamond'
  position: [5,1]
  stroke: 'maroon'
  fill: 'red'
  behavior: {interrupt: ['victory']}
  obstruction: false
}  

exports.game = {
  name: "Example Game"
  based_on: 'baseline'
  comment: "For testing purposes only"

  language: {
    # Admin commands have '_'
    # TODO: hide Admin commands if not in design mode
    _victory: ['.send', 'done',  1]
    _failure: ['.send', 'done', -1]
  }

  shapes: {
    diamond: [
      "M0,#{SCALE} l#{SCALE},#{SCALE} l#{SCALE},-#{SCALE} l-#{SCALE},-#{SCALE} Z"
    ]
  }

  levels: [
    {
      name: 'Move the Turtle to the Exit'
      sprites: [me, exit]
      goal: {
        clicks: 1
        ticks: 4
        bricks: 1
      }
    }
    {
      name: 'Double Time'
      sprites: [exit, me, yu]
      goal: {
        clicks: 10
        ticks: 8
        bricks: 6
      }
    }
  ]
}
