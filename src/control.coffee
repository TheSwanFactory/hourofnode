
exports.control = (T, world) ->
  me = world.get("turtles").get("children").get("ME")
  size = world.get("size")
  draw_button = (label, dir, delta) ->
    T.button {
      class: ["control", dir, label]
      click: -> me.reset(dir, delta)
    }, label
  draw_caller = (key) ->
    label = key[0].toUpperCase() + key[1..-1].toLowerCase()
    T.button {
      class: ["control", key, label]
      click: -> me.call(key)
    }, label
  T.div {
    class: "controls"
    style: "margin-top: -#{size}px; margin-left: #{size}px;"
  }, [
    T.div {class: "instructions absolute"}, [
      draw_button("West", "i", -1)
      draw_button("North", "j", -1)
      draw_button("South", "j", 1)
      draw_button("East", "i", 1)
    ]
    T.div {class: "instructions relative"}, [
      draw_caller('go')
      draw_caller('left')
      draw_caller('right')
    ]
    T.p "More coming soon..."
  ]
