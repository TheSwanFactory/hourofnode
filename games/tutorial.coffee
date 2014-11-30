exports.game = {
  name: 'Tutorial Level'
  assume: 'baseline'
  comment: "The world's first NodeScript program"
  author: {name: 'David Huffman', url: 'mailto:david@theswanfactory.com'}
  license: {
    name: 'Creative Commons Attribution 4.0 International'
    url: 'http://creativecommons.org/licenses/by/4.0/'
  }

  levels: [
    {
      name: 'A Complex Maze'
      goal: {
        clicks: 6
        ticks: 20
        bricks: 6
      }
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
    }
  ]
}
