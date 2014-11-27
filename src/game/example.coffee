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
  behavior: {interrupt: ['_victory']}
  obstruction: false
}  

exports.game = {
  name: "Example Game"
  assume: 'baseline'
  comment: "For testing purposes only"

  actions: {
    # Admin commands have '_'
    # TODO: hide Admin commands if not in design mode
    _victory: ['send', 'done',  1].join ' '
    _failure: ['send', 'done', -1].join ' '
  }

  levels: [
    {
      name: 'Move the Turtle to the Exit'
      sprites: [exit, me]
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
