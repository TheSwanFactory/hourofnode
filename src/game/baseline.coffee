{my} = require '../my'
{vector} = require '../god/vector'

exports.game = {
  name: "The Hour of Node"
  assume: 'words'

  name_style: {font_size: 24}
  _AUTHORITY: {
    name_style: {font_size: 18}
    width: (world) -> world.get('column_width')
    _AUTHORITY: {width: 'auto'}
  }
  
  goal: {
    clicks: 0
    ticks: 0
    bricks: 0
  }

  # TODO: rename as behavior
  # have sprite behavior extend this
  # bind words at run-time
  words: {
    # String of operation, key, number
    forward: ['call', 'go', vector.to.front].join " "
    reverse: ['call', 'go', vector.to.back].join " "
    left:    ['call', 'turn', vector.to.left ].join " "
    right:   ['call', 'turn', vector.to.right].join " "
    idle:    "call go 0"
  }

  levels: [
    {
      name: 'Move the Turtle to the Exit'
      sprites: [
        {
          name: 'me'
          shape: 'turtle'
          position: [0,0]
          color: 'limegreen'
          behavior: {first: [], repeat: ['forward']}
          editable: true
        }
      ]
    }
  ]
}
