exports.controls = {
  _LABEL: "controls"
  stroke: "black"
  fill: "lightgrey"
  transform: (world, args) ->
    console.log "controls transform #{world} #{args}"
    console.log world
    size = world.get('size')
    scale = world.get('scale')
    x = size + scale*(world.get('i')+0.5)
    y = scale*(world.get('j')+0.5)
    console.log "translate(#{x},#{y})"
    "translate(#{x},#{y})"
  path: (world, args) ->
    scale = world.get('scale') / 2
    "M0,0 h#{scale} v#{scale} h-#{scale } v#{-scale}"
  _CHILDREN: [
    {i: 0, j:0}
  ]
}
