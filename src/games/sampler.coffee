{my} = require '../my'
{vector} = require '../god/vector'

exports.game = {
  name: "Sampler Levels"
  assume: 'baseline'
  comment: "Showcase"

  levels: [
    {
      name: 'One of Everything'
      sprites: [
        {kind: 'gate'}
        {kind: 'egg'}
        {kind: 'wall'}
        {kind: 'turtle',actions: {first: ['forward']} }
      ]
      goal: {
        clicks: 1
        ticks: 4
        bricks: 1
      }
    }
  ]
}
