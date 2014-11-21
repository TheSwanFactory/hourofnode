{my} = require '../my'
{vector} = require '../god/vector'

SCALE = my.cell_width

exports.game = {
  name: "The Hour of Node"

  # Geometry
  screen: my.page_dimensions
  width: my.page_dimensions[vector.size.width]
  fill: 'white'
  name_style: {font_size: 36}
  
  grid_size: my.column_1_width
  cell_count: 8
  cell_size: (world) -> world.get('grid_size') / world.get('cell_count')
  goal: {
    clicks: 0
    ticks: 0
    bricks: 0
  }

  behavior: {
    # String of operation, key, number
    forward: ['call', 'go', vector.to.front].join " "
    reverse: ['call', 'go', vector.to.back].join " "
    left:    ['call', 'turn', vector.to.left ].join " "
    right:   ['call', 'turn', vector.to.right].join " "
    idle:    ['call', 'go', 0].join " "
  }

  shapes: {
    turtle: [
      "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
      "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
    ]
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
