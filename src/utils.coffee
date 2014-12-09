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

  no_css_transforms: ->
    @ie_version() || @iOS_version() && iOS_version() < 6

  # http://stackoverflow.com/a/14223920
  iOS_version: ->
    return false unless /iP(hone|od|ad)/.test(navigator.platform)
    # supports iOS 2.0 and later: <http://bit.ly/TJjs1V>
    v = (navigator.appVersion).match(/OS (\d+)_(\d+)_?(\d+)?/)
    [
      parseInt(v[1], 10)
      parseInt(v[2], 10)
      parseInt(v[3] or 0, 10)
    ]

  ie_version: ->
    ua = window.navigator.userAgent
    msie = ua.indexOf("MSIE ")
    if msie > 0 or !!navigator.userAgent.match(/Trident.*rv\:11\./) # If Internet Explorer, return version number
      return parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)))
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
