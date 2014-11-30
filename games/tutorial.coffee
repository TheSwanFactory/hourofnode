{my} = require '../my'
{vector} = require '../god/vector'

me = {
  name: 'me'
  kind: 'turtle'
  position: [1,1]
  stroke: 'black'
  fill: 'blue'
  actions: { first: ['left', 'forward'], interrupt: ['reverse', 'right'] }
}

yu = my.dup me, {
  name: 'yu'
  position: [3,1]
  fill: 'green'
  actions: { first: ['forward', 'forward', 'right', 'forward', 'forward'], interrupt: ['right']}
}

exit = {
  name: 'exit'
  kind: 'gate'
  position: [5,1]
  stroke: 'maroon'
  fill: 'red'
  actions: {interrupt: ['_victory']}
}   
 
exports.game = {
  name: "Tutorial Game"
  assume: 'baseline'
  comment: "For testing purposes only"

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
    {
      name: 'Double Time'
      sprites: [exit, me, yu]
      goal: {
        clicks: 10
        ticks: 8
        bricks: 6
      }
    }
  ]
}
