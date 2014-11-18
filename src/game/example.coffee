{my} = require '../my'
{vector} = require '../god/vector'

# TODO: Normalize to 100 or 1.00
SCALE = 30

me = {
  name: 'me'
  shape: 'turtle'
  position: [1,1]
  color: 'blue'
  behavior: {first: [], repeat: ['forward']}
  editable: true
}

exit = {
  name: 'exit'
  shape: 'diamond'
  position: [1,4]
  color: 'red'
  behavior: {turtle: ['victory']}
}  

me2 = my.extend me, {position: [2,2]}

exports.game = {
  name: "Example Game"
  based_on: 'baseline'
  comment: "For testing purposes only"

  language: {
    # Array of Operation, key, argument
    victory: ['.send', 'done',  1]
    failure: ['.send', 'done', -1]
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
      sprites: [me, me2, exit]
      goal: {
        clicks: 10
        ticks: 8
        bricks: 6
      }
    }
  ]
}
