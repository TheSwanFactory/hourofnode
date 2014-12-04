{my} = require '../my'

exports.game = {
  _LABEL: 'page_title'
  name: "The Hour of Node"
  assume: 'actions'

  _AUTHORITY: {
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
          actions: {run: []}
          editable: true
        }
      ]
    }
  ]
}
