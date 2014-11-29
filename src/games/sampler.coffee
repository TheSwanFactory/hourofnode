{my} = require '../my'
{vector} = require '../god/vector'

me = {
  name: 'me'
  shape: 'turtle'
  editable: true
}

exports.game = {
  name: "Sampler Levels"
  assume: 'baseline'
  comment: "Showcase"

  levels: [
    {
      name: 'One of Everything'
      sprites: [me]
      bricks: 7
      goal: {
        clicks: 1
        ticks: 4
        bricks: 1
      }
    }
  ]
}