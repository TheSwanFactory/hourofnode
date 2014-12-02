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
        {
          kind: 'turtle'
          position: [1,1]
          actions: { run: ['forward'] }
        }
      ]
      goal: {
        clicks: 1
        ticks: 4
        bricks: 1
      }
    }
  ]
}
