{rows, cols} = require './group'

exports.header =
  rows 'header', [
    {_LABEL: 'game', name: "Example Game", name_style: "24pt"}
    {_LABEL: 'level', name: "Move the Turtle to the Exit", name_style: "18pt"}
    {_LABEL: 'progress', name: "1 of 2"}
    cols 'status', [
      {_LABEL: 'ticks', name: "ticks: 0"}
      {_LABEL: 'clicks', name: "clicks: 0"}
      {_LABEL: 'bricks', name: "bricks: 0"}
    ]
  ]
