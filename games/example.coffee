me = {
  name: 'me'
  kind: 'turtle'
  position: [1,1]
  stroke: 'black'
  fill: 'blue'
  actions: { run: ['left', 'forward'], bump: ['reverse'] }
}

yu = _.extend {}, me, {
  name: 'yu'
  position: [3,1]
  fill: 'green'
  actions: { run: ['forward', 'forward', 'right', 'forward', 'forward'], bump: ['right']}
}

exit = {
  name: 'exit'
  kind: 'gate'
  position: [5,1]
  stroke: 'maroon'
  fill: 'red'
  actions: {bump: ['_victory']}
}

wall = {
  name: 'log',
  kind: 'log'
}

exports.game = {
  name: "Example Game"
  assume: 'baseline'
  comment: "For testing purposes only"

  levels: [
    {
      name: 'Move the Turtle to the Exit'
      sprites: [exit, me, wall]
      bricks: 7
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
