{my} = require '../my'

exports.game = {
  name: "The Hour of Node"
  assume: 'actions'

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

  levels: [
    {
      name: 'Move the Turtle to the Exit'
      sprites: [
        {
          name: 'me'
          shape: 'turtle'
          position: [0,0]
          color: 'limegreen'
          actions: {first: []}
          editable: true
        }
      ]
    }
  ]
}
