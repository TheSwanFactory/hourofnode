{my} = require '../my'
{sprites} = require './sprites'
{law} = require './mixins/law'

exports.grid = () -> {
  _LABEL: "grid"
  height: (world) -> world.get('grid_size')
  width: (world) -> world.get('grid_size')

  _EXPORTS: ['edit', 'save']
  # TODO: make button name dyammic based on 'editing' property
  edit: (world, button) ->
    button.put 'name', 'save'
  save: (world, button) ->
    button.put 'name', 'edit'
  click: (world, event) ->
    return unless is_editing = world.get 'editing'
    scale = world.get('cell_size')
    x = event.offsetX / scale
    y = event.offsetY / scale
    position = [Math.floor(x), Math.floor(y)]
    world.send 'click'
    world.send 'make_sprite', {kind: 'log', position: position}

  paths: []
  obstruction: true
  _CHILDREN: [
    {
      _LABEL: "background"
      color: my.color.grid
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
