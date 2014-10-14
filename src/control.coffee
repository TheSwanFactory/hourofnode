exports.control = (T, world) ->
  me = world.getChildren("turtles").get("ME")
  size = world.get("size")

  draw_buttons = (label, world) ->
    T.span {class: [label, "buttons"]}, world.map (key, value) ->
      T.button {
        class: [key, value]
        click: -> me.call(key, {dir: value})
      }, label

  T.div {
    class: "controls"
    style: "margin-top: -#{size}px; margin-left: #{size}px;"
  }, [
    T.div {class: "instructions declarative"}, world.bind -> _.flatten [
      world.getChildren('controls').map draw_buttons
    ]
    T.p "More coming soon..."
  ]
