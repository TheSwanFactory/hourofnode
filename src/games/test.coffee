# The game used in the test suite

me = {
  kind: 'turtle'
  name: 'me'
  p: [1,1], v:[1, 0]
  fill: "limegreen"
  programs: {default: ['forward']}
}

yu = {
  kind: 'turtle'
  name: 'yu'
  p: [3,3], v:[-1, 0]
  fill: "darkgreen"
  programs: {default: ['back']}
}

exit = {
  kind: 'gate'
  name: 'yu'
  p: [6,6]
  fill: "maroon"
  programs: {turtle: ['victory']}
}

exports.game = {
  defs: {
    turtle: {path: ""}
    gate: {path: ""}
  }
  levels: [
    {config: {}, sprites: [me, yu, exit]}
  ]
}
