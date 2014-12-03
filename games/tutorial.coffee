exports.game = {
  name: 'The Hour of Node'
  assume: 'baseline'
  comment: "The world's first NodeScript program"
  author: {name: 'David Huffman', url: 'mailto:david@theswanfactory.com'}
  license: {
    name: 'Creative Commons Attribution 4.0 International'
    url: 'http://creativecommons.org/licenses/by/4.0/'
  }

  levels: [
    {
      name: 'Use "Run" to Move Turtle to Exit'
      goal: { clicks: 1, ticks: 5, bricks: 1 }
      sprites: [
        { kind: 'gate', position: [4,0] }
        { kind: 'turtle', position: [0,0], actions: {run: ['forward']} }
      ]
    }
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
        {kind: 'wall', position: [0,2]}
        {kind: 'wall', position: [2,2]}
        {kind: 'wall', position: [2,1]}
        {kind: 'wall', position: [2,0]}
        {kind: 'wall', position: [2,5]}
        {kind: 'wall', position: [1,5]}
        {kind: 'wall', position: [3,5]}
        {kind: 'wall', position: [4,5]}
        {kind: 'wall', position: [5,5]}
        {
          kind: 'turtle'
          position: [0,0]
          actions: { run: ['forward'], interrupt: ['right'] }
        }
      ]
    }
  ]
}
