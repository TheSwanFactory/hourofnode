exports.game = {
  name: "Tutorial Game"
  assume: 'baseline'
  comment: "The world's first NodeScript program"
  author: {name: 'David Huffman', email: 'david@theswanfactory.com'}
  license: 'Creative Commons'

  levels: [
    {
      name: 'One of Everything'
      sprites: [
        {kind: 'gate'}
        {kind: 'wall'}
         {
          kind: 'turtle'
          position: [0,0]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [0,2]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [2,2]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [2,1]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [2,0]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [2,5]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [1,5]
          actions: { first: ['forward'] }
        }

         {
          kind: 'wall'
          position: [3,5]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [4,5]
          actions: { first: ['forward'] }
        }
         {
          kind: 'wall'
          position: [5,5]
          actions: { first: ['forward'] }
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
