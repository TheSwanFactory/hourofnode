#
# render.coffee
# Role: generate HTML or SVG from a world 
# Responsibility: 
# * nest elements
# * switch between HTML and SVG
# * add clickability
#

{my} = require './my'
{render_html} = require './render/render_html'
{render_svg} = require './render/render_svg'

normalize = (paths) ->
  return [] unless paths
  paths = paths.all() unless _.isArray(paths) 
  paths

add_behavior = (attrs, world) ->
  clicker = world.get_raw 'click'
  if clicker? and !world.has_children()
    attrs['click'] = -> clicker(world) 
    attrs['touchend'] = -> clicker(world)
  attrs

create_attrs = (world, style) ->
  labels = world.labels()
  attrs = {
    id: "#{labels.length}_#{labels.join '_'}"
    class: labels 
    style: world.bind() -> style
  }
  add_behavior(attrs, world)
  
text_attrs = (world) -> {
  class: ['name', 'text', world.get 'selected']
  style: world.get 'name_style'
}

render_children = (world, dict) ->
  #console.log "render_children #{world}", dict
  paths = normalize dict.path_tags
  if world.get_local('name')?
    tag = dict.name_tag text_attrs(world), world.bind() -> world.get('name')
    paths.push tag 
  children = world.map_children (child) -> render_world(child)
  paths = paths.concat children if children
  #console.log "render_children paths", paths if paths
  paths

render_world = (world) ->
  is_svg = world.get('paths')?
  dict = if is_svg then render_svg(world) else render_html(world)
  attrs = create_attrs(world, dict.style)
  dict.tag attrs, world.bind() -> render_children(world, dict)
        
exports.render = (root) ->
  root.T().div {id: 'root'}, render_world(root)
