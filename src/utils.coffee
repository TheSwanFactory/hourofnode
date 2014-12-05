exports.utils =
  prefix_style: (style) ->
    if style.transform?
      style["-webkit-transform"] = style.transform
      style["-moz-transform"]    = style.transform
      style["-ms-transform"]     = style.transform
    if style.transform_origin
      style["-webkit-transform-origin"] = style.transform_origin
      style["-moz-transform-origin"]    = style.transform_origin
      style["-ms-transform-origin"]     = style.transform_origin
    style
