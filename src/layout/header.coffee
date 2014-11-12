{vector} = require '../god/vector'

exports.header = {
  going: vector.axis.down
  _CHILDREN: [
    {name: "Example Game", name_style: "24pt"}
    {name: "Move the Turtle", name_style: "18pt"}
    {name: "1 of 2"}
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