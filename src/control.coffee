exports.control = (T, world) ->
  me = world.getChildren("turtles").get("ME")
  size = world.get("size")
  controls = world.getChildren('controls')

  draw_buttons = (label, args) ->
    queue = world.bind -> controls.getChildren('activity')
    T.span {class: [label, "buttons"]}, args.map (key, value) ->
      dict = {turtle: me, label: label, key: key, value: value, queue: queue}
      T.button {
        class: [key, value]
        click: args.call('click', dict)
      }, label

  T.div {
    class: "controls"
    style: "margin-top: -#{size}px; margin-left: #{size}px;"
  }, controls.map (label, section) ->
    console.log("section: #{label}")
    console.log section
    console.log("children: #{label}")
    console.log section.getChildren()
    console.log section.getChildren().doc
    console.log section.getChildren().doc.x
    T.div {
      class: label
    }, section.getChildren().map(draw_buttons)
  #world.bind -> 