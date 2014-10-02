# Create rxv Versions
 
ObsCell = rx.ObsCell
ObsArray = rx.ObsArray
 
rxv = {}
 
# Set Events and Attributes
 
events = ["click", "mousedown", "mouseup"]
 
specialAttrs = rxv.specialAttrs = {
  init: (elt, fn) -> fn.call(elt)
}
 
for ev in events
  do (ev) ->
    specialAttrs[ev] = (elt, fn) -> elt.addEventListener ev, fn
 
 
setProp = (elt, prop, val) ->
  elt.setAttribute prop, val
 
# Make Tag Function
 
rxv.mktag = mktag = (tag) -> 
  (arg1, arg2) ->
    # arguments are either (), (attrs: Object), (contents: non-Object), or
    # (attrs: Object, contents: non-Object)
    [attrs, contents] =
      if not arg1? and not arg2?
        [{}, null]
      else if arg2?
        [arg1, arg2]
      else if _.isString(arg1) or arg1 instanceof SVGElement or _.isArray(arg1) or arg1 instanceof ObsCell or arg1 instanceof ObsArray
          [{}, arg1]
      else
        [arg1, null]
 
    elt = document.createElementNS('http://www.w3.org/2000/svg', tag)
    for name, value of _.omit(attrs, _.keys(specialAttrs))
        if value instanceof ObsCell
          do (name) -> 
            value.onSet.sub ([old, val]) -> setProp(elt, name, val)
        else
          setProp(elt, name, value)
 
    if contents?
      toNodes = (contents) ->
        for child in contents
          if _.isString(child)
            document.createTextNode(child)
          else if child instanceof SVGElement
            child
          else
            throw 'Unknown element type in array: ' + child.constructor.name #TODO: auto-create tags?
 
      updateContents = (contents) ->
        (elt.removeChild elt.firstChild) while elt.firstChild
        if _.isArray(contents)
          (elt.appendChild node) for node in toNodes(contents)
        else if _.isString(contents)
            updateContents([contents])
          else
              throw 'Unknown type for contents: ' + contents.constructor.name
 
      if contents instanceof ObsArray
        contents.onChange.sub ([index, removed, added]) -> 
          (elt.removeChild elt.childNodes[index]) for i in [0...removed.length]
          toAdd = toNodes(added)
          if index == elt.childNodes.length
            (elt.appendChild node) for node in toAdd
          else 
            (elt.childNodes[index].insertBefore node) for node in toAdd
          
      
      else if contents instanceof ObsCell
        contents.onSet.sub(([old, val]) -> updateContents(val))
      
      else
        updateContents(contents)
 
    for key of attrs when key of specialAttrs
      specialAttrs[key](elt, attrs[key], attrs, contents)
    elt
 
# Create the most common SVG tags (not comprehensive)
# See http://www.w3.org/TR/SVG/
 
tags = ['svg','g','rect', 'circle', 'ellipse', 'line', 'polyline', 'polygon', 'path', 'marker', 'text', 'tspan', 'tref', 'textpath', 'switch', 'image', 'a', 'defs', 'symbol', 'use', 'animateTransform', 'stop', 'linearGradient', 'radialGradient', 'pattern', 'clipPath', 'mask', 'filter', 'feMerge', 'feOffset', 'feGaussianBlur', 'feMergeNode']
rxv.tags = _.object([tag, rxv.mktag(tag)] for tag in tags)
rxv.importTags = (x) => _(x ? this).extend(rxv.tags)

exports.rxv = rxv
