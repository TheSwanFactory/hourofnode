
exports.control = (T, world) ->
  me = world.get("turtles").get("children").get("ME")
  size = world.get("size")
  draw_button = (label, dir, delta) ->
    T.button {
      class: ["control", "dir", label]
      click: ->
        me.reset(dir, delta)
    }, label
  T.div {
    class: "controls"
    style: "margin-top: -#{size}px; margin-left: #{size}px;"
  }, [
    T.div {class: "instructions"}, [
      draw_button("West", "i", -1)
      draw_button("North", "j", -1)
      draw_button("South", "j", 1)
      draw_button("East", "i", 1)
    ]
    T.p "More coming soon..."
  ]
