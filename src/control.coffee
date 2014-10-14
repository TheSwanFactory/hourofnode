exports.control = (T, world) ->
  me = world.getChildren("turtles").get("ME")
  size = world.get("size")

  draw_buttons = (label, args) ->
    T.span {class: [label, "buttons"]}, args.map (key, value) ->
      T.button {
        class: [key, value]
        click: args.call('click', {turtle: me, key: key, value: value})
      }, label

  controls = world.getChildren('controls')
  T.div {
    class: "controls"
    style: "margin-top: -#{size}px; margin-left: #{size}px;"
  }, controls.map (label, section) ->
    children = section.getChildren()
    T.div {class: label}, section.bind -> _.flatten [
      console.log "section: #{section}"
      console.log section
      children.map draw_buttons
    ]
