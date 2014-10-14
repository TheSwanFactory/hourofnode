exports.control = (T, world) ->
  me = world.getChildren("turtles").get("ME")
  size = world.get("size")

  draw_buttons = (label, args) ->
    T.span {class: [label, "buttons"]}, args.map (key, value) ->
      T.button {
        class: [key, value]
        click: -> me.call(key, {dir: value})
      }, label

  controls = world.getChildren('controls')
  T.div {
    class: "controls"
    style: "margin-top: -#{size}px; margin-left: #{size}px;"
  }, controls.map (label, section) ->
    T.div {class: label}, section.bind -> _.flatten [
      section.get('_children').map draw_buttons
    ]
