{my} = require '../my'
{vector} = require '../god/vector'

exports.game = {
  name: "Words"
  assume: 'shapes'
  # TODO: rename as behavior
  # have sprite behavior extend this
  # bind actions at run-time
  actions: {
    # String of operation, key, number
    forward: ['call', 'go', vector.to.front].join " "
    reverse: ['call', 'go', vector.to.back].join " "
    left:    ['call', 'turn', vector.to.left ].join " "
    right:   ['call', 'turn', vector.to.right].join " "
    idle:    "call go 0"
  }
  
}