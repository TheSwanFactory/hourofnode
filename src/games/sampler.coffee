{my} = require '../my'
{vector} = require '../god/vector'

me = {
  kind: 'turtle'
}

exports.game = {
  name: "Sampler Levels"
  assume: 'baseline'
  comment: "Showcase"

  levels: [
    {
      name: 'One of Everything'
      sprites: [
        {kind: 'turtle'}
        {kind: 'wall'}
        {kind: 'egg'}
        {kind: 'gate'}
      ]
      bricks: 7
      goal: {
        clicks: 1
        ticks: 4
        bricks: 1
      }
    }
  ]
}
