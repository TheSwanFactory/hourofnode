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
  kind: 'gate'
  name: 'yu'
  p: [6,n]
  fill: "maroon"
  programs: {turtle: ['victory']}
}

exports.game = {
  name: 'Test Game'
  kinds: {
    # Assume drawin in a 10x10 box
    turtle: {path: ""}
    gate: {path: ""}
  }
  levels: [
    {name: 'End of the Line', sprites: [me, exit(1)]}
    {name: 'Diagonal Thinking', sprites: [me, exit(6)]}
    {name: 'Avoid Obstacle', sprites: [me, yu(), exit(6)]}
    {name: 'Avoid Sentry', sprites: [me, sentry, exit(6)]}
  ]
}
