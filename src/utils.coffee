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
      if dict.edit_mode() then 'input' else 'span'
    dict.init = (world, element) ->
      return unless dict.edit_mode()

      $(element).on 'change', -> world.put('value', $(@).val())
    dict.save = (world) ->
      value = world.get 'value'

      return if !value? or value == world.get('name') # no change

      world.put 'name', value
      dict.after_save(world, value) if dict.after_save?
    dict

  add_offset_to_event: (world, event) ->
    return if event.offsetX?

    element = $ world.element
    offset  = element.offset()
    event.offsetX = event.pageX - offset.left
    event.offsetY = event.pageY - offset.top

  supports_html5_storage: ->
    try
      'localStorage' of window && window['localStorage']?
    catch e
      false

  store: (key, value) ->
    return unless @supports_html5_storage()

    return @store_many(key) if typeof key == 'object'

    localStorage[key] = value

  store_many: (properties) ->
    for key, value of properties
      @store key, value

  fetch: (key) ->
    return unless @supports_html5_storage()

    return @fetch_many(key) if _.isArray key

    value = localStorage[key]

    return null unless value?

    switch
      when value == 'true'         then true
      when value == 'false'        then false
      when value.match /^\d+$/     then parseInt value, 10
      when value.match /^[\d\.]+$/ then parseFloat value, 10
      else value

  fetch_many: (keys) ->
    values = []
    for key in keys
      values.push @fetch(key)
    values

  fetch_object: (keys) ->
    values = {}
    for key in keys
      values[key] = @fetch key
    values

# IE fix for location.origin
unless window.location.origin?
  window.location.origin = window.location.protocol + "//" + window.location.hostname + (if window.location.port then ':' + window.location.port else '')
