# TODO: Normalize to 100 or 1.00
SCALE = 30

me = {
  name: 'me'
  shape: 'turtle'
  position: [0,0]
  color: 'blue'
  programs: {first: [], repeat: ['forward']}
  editable: true
}

exit = {
  name: 'exit'
  shape: 'diamond'
  position: [0,4]
  color: 'red'
  programs: {turtle: ['victory']}
}  

me2 = $.extend me, {position: [2,2]}

exports.game = {
  name: "Example Game"
  comment: "For testing purposes only"

  goal: {
    clicks: 1
    ticks: 4
    bricks: 1
  }

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
    }
    {
      name: 'Double Time'
      sprites: [me, me2, exit]
    }
  ]
}
