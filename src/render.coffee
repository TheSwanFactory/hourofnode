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

clicker = (world) ->
  action = world.get_raw 'click'
  return (event) -> action(world, event) if action? and !world.has_children()

class_attrs = (world) ->
  labels = world.labels()
  label = labels[0]
  level_label = "#{labels.length}_#{label}"
  klass = [label, level_label]
  klass.push world.get_local('class') ? ''
  klass.push world.get_local(my.key.kind) ? ''
  klass.push 'selected' if world.get 'selected'
  klass.push 'editable' if world.get 'editable'
  klass

create_attrs = (world, style) ->
  attrs = {
    id: "#{world.label()}_#{world.uid}"
    class: world.bind() -> class_attrs(world)
    style: world.bind() -> style
    click: clicker(world)
    # TODO: add touch events that do not mess up mutation
    # touchend: clicker(world)
  }

text_attrs = (world) ->
  style = world.get 'name_style'
  attrs = my.dup style
  attrs['class'] = ['name', 'text', world.get 'selected']
  attrs['style'] = style
  attrs

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
