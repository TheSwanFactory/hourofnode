# The game used in the test suite

me = {
  kind: 'turtle'
  name: 'me'
  p: [1,3], v:[1, 0]
  fill: "limegreen"
  programs: {default: ['forward']}
}

yu = (prog=[]) -> {
  kind: 'turtle'
  name: 'yu'
  p: [3,3], v:[-1, 0]
  fill: "darkgreen"
  programs: {default: prog}
}

sentry = yu ['forward', 'forward', 'reverse', 'reverse']

diamond = (n) -> "M-#{n},0 l#{n},#{n} l#{n},-#{n} l-#{n},-#{n} Z"
exit = (col) -> {
  path: [diamond(30)]
  name: 'exit'
  p: [6,col]
  fill: "maroon"
  programs: {turtle: ['victory']}
}

exports.game = {
  name: 'Test Game'
  kinds: {
    # paths center on 0, x,y = +-10
    turtle: {
      path: [
        "m7,0 l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
        "m-14,0 a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
      ]
    }
  }
  levels: [
    {name: 'End of the Line', sprites: [me, exit(1)]}
    {name: 'Diagonal Thinking', sprites: [me, exit(6)]}
    {name: 'Avoid Obstacle', sprites: [me, yu(), exit(6)]}
    {name: 'Avoid Sentry', sprites: [me, sentry, exit(6)]}
  ]
}
