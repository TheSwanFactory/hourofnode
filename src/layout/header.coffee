{vector} = require '../god/vector'

big_button = ""

exports.header = {
  going: vector.axis.down
  _CHILDREN: [
    {name: "Game Title", name_style: "24pt"}
    {name: "Level Title", name_style: "18pt"}
    {
      going: vector.axis.across
      _CHILDREN: [
        {name: "ticks: 0"}
        {name: "clicks: 0"}
        {name: "bricks: 0"}
      ]
    }
  ]
}