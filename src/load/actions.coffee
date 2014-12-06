{my} = require '../my'
{vector} = require '../god/vector'

exports.game = {
  name: "Words"
  assume: 'shapes'
  actions: {
    # String of operation, key, parameter
    wait:    ""
    forward: "call go #{vector.to.front}"
    reverse: "call go #{vector.to.back}"
    left:    "call turn #{vector.to.left}"
    right:   "call turn #{vector.to.right}"
    # color: "call drop dir"
    _victory: "send done 1"
    _failure: "send done -1"
    run: []
    interrupt: []
  }
}
