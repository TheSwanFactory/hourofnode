#
# render.coffee
# Role: display the world and its children on a web page
# Responsibility: 
# * nest elements
# * switch between HTML and SVG
# * add clickability
#

{my} = require '../my'
{render_html} = require './render_html'
{render_svg} = require './render_svg'

add_behavior = (attrs, world) ->
  clicker = world.get_raw 'click'
  if clicker? and !world.has_children()
    attrs['click'] = -> clicker(world) 
    attrs['touchend'] = -> clicker(world)
  attrs

create_attrs = (world, style) ->
  labels = world.labels [world.label()]
  attrs = {
    id: "#{labels.length}_#{labels.join '_'}"
    class: labels 
    style: world.bind() -> style
  }
  add_behavior(attrs, world)
  
text_attrs = (world) -> {
  class: ['name', 'text', world.get 'selected']
  style: world.get('name_style')
}

render_children = (world, dict) ->
  array = world.map_children (child) -> render_world(child)
  name = dict.name_tag text_attrs(world), world.bind() -> world.get('name')
  array.push name if world.get_local('name')?
  array

render_world = (world) ->
  is_svg = false # world.get('path')
  dict = if is_svg then render_svg(world) else render_html(world)
  attrs = create_attrs(world, dict.style)
  dict.tag attrs, world.bind() -> render_children(world, dict)
        
exports.render = (root) ->
  root.T().div {id: 'root'}, render_world(root)
