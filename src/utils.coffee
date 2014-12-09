rx = require 'reactive-coffee'

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
    dict._EXPORTS = ['save']
    dict.tag_name = ->
      if dict.editing() then 'input' else 'span'
    dict.init = (world, element) ->
      return unless dict.editing()

      $(element).on 'change', -> world.put('value', $(@).val())
    dict.save = (world) ->
      value = world.get 'value'

      return if !value? or value == world.get('name') # no change

      world.put 'name', value
      dict.after_save(world, value) if dict.after_save?
    dict
