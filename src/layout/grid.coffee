{my} = require '../my'
{sprites} = require './sprites'
{law} = require './mixins/law'

exports.grid = () -> {
  _LABEL: "grid"
  height: (world) -> world.get('grid_size')
  width: (world) -> world.get('grid_size')

  _EXPORTS: ['edit', 'save']
  edit: (world, button) ->
    button.put 'name', 'save'
    world.put 'editing', true
  save: (world, button) ->
    button.put 'name', 'edit'
    world.put 'editing', false
  click: (world, event) ->
    return unless is_editing = world.get 'editing'
    scale = world.get('cell_size')
    x = event.offsetX / scale
    y = event.offsetY / scale
    position = [Math.floor(x), Math.floor(y)]
    console.log 'click', world.label(), position, is_editing
    world.send 'make_sprite', {kind: "wall", position: position}

  paths: []
  obstruction: true
  _CHILDREN: [
    {
      _LABEL: "background"
      fill: my.color.grid
      stroke: "black"
      paths: (world) ->
        size = world.get('grid_size')
        ["M0,0 h#{size} v#{size} h-#{size} v#{-size}"]
    }
    {
      _LABEL: "gridlines"
      stroke: my.color.gridline
      paths: (world) ->
        size = world.get('grid_size')
        cell = world.get('cell_size')
        path = ""
        for n in [cell..size-1] by cell
          path  += "M#{n},1 V#{size - 1} M1,#{n} H#{size - 1} "
        [path]
    }
    sprites
    law
  ]
}
