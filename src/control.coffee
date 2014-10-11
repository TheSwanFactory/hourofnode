
exports.control = (T, world) ->
  me = world.get("ME")
  draw_button = (label, dir, delta) ->
    T.button {
      class: ["control", "dir", label]
      click: -> me.put(dir, me.get(dir) + delta)
    }, label
  T.div {class: "controls"}, [
    T.div {class: "controls"}, [
      draw_button("West", "i", -1)
      draw_button("North", "j", -1)
      draw_button("South", "j", 1)
      draw_button("East", "i", 1)
    ]
    T.p "More coming soon..."
  ]
