exports.control = (T, world) ->
  me = world.getChildren("turtles").get("ME")
  size = world.get("size")
  controls = world.getChildren('controls')
  queue = controls.getChildren('activity')

  draw_buttons = (label, args) ->
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
    T.div {
      class: label
    }, section.getChildren().map(draw_buttons)
  #T.div {class: 'debug'}, T.p controls
  #world.bind -> 