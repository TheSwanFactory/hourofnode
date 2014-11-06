# The game used in the test suite

me = {
  kind: 'turtle'
  name: 'me'
  p: [1,1], v:[1, 0]
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

exit = (n) -> {
  kind: 'exit'
  name: 'exit'
  p: [6,n]
  fill: "maroon"
}

exports.game = {
  name: 'Test Game'
  kinds: {
    # paths center on 0, x,y = +-10
    turtle: {paths: []}
    exit: {
      paths: ["M-10,0 l10,10 l10,-10 l-10,-10 Z"]
      programs: {turtle: ['victory']}
    }
  }
  levels: [
    {name: 'End of the Line', sprites: [me, exit(1)]}
    {name: 'Diagonal Thinking', sprites: [me, exit(6)]}
    {name: 'Avoid Obstacle', sprites: [me, yu(), exit(6)]}
    {name: 'Avoid Sentry', sprites: [me, sentry, exit(6)]}
  ]
}
