#
# geometry.coffee
#
# Role: define default geometry of games
#

{my} = require '../my'
{vector} = require '../god/vector'

width = my.page_dimensions[vector.size.width]

exports.game = {
  name: "iPad Geometry"

  # Geometry
  screen: my.page_dimensions
  width: width
  column_width: width / 2
  fill: 'white'
  
  grid_size: my.column_1_width
  cell_count: 8
  cell_size: (world) -> world.get('grid_size') / world.get('cell_count')

  margin: my.margin
  outer_width: (world) -> world.get('width') + 2 * world.get('padding')
  inner_width: (world) -> world.get('width') - 2 * world.get('margin')

  available_width: (world) ->
    world.up.get('inner_width') - 2 * world.get('padding')
  set_outer_width: (world, outer_width) ->
    world.put 'width', outer_width - 2 * world.get('padding')

  offset: (world) -> world.index * world.get('outer_width')
}
