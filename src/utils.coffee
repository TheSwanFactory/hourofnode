exports.utils =
  prefix_style: (style) ->
    if style.transform?
      style["-webkit-transform"] = style.transform
      style["-moz-transform"]    = style.transform
    if style.transform_origin
      style["-webkit-transform-origin"] = style.transform_origin
      style["-moz-transform-origin"]    = style.transform_origin
    style

  is_ie: ->
    ua = window.navigator.userAgent
    msie = ua.indexOf("MSIE ")
    if msie > 0 or !!navigator.userAgent.match(/Trident.*rv\:11\./) # If Internet Explorer, return version number
      return true
      # parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)))
    false

  editable_field: (dict) ->
    dict._EXPORTS = ['edit', 'save']
    dict.edit = (world) ->
      world.put '_tag_name', world.get('tag_name')
      world.put 'tag_name', 'input'
      dict.after_edit(world) if dict.after_edit?
    dict.save = (world) ->
      value = $(world.element).val()
      world.put 'tag_name', world.get('_tag_name')

      return unless world.element?

      world.put 'name', value
      dict.after_save(world, value) if dict.after_save?
    dict
