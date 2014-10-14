exports.control = (T, world) ->
  me = world.get("turtles").get("children").get("ME")
  size = world.get("size")

  draw_buttons = (label, world) ->
    T.div {class: [label, "buttons"]}, world.map (key, value) ->
      T.button {
        class: [key, value]
        click: -> me.call(key, {dir: value})
      }, label

  draw_caller = (key, dir) ->
    label = key[0].toUpperCase() + key[1..-1].toLowerCase()
    if dir?
      label += if dir == -1 then ' Right' else ' Left'
    T.button {
      class: ["control", key, label]
      click: -> me.call(key, {dir: dir})
    }, label
  T.div {
    class: "controls"
    style: "margin-top: -#{size}px; margin-left: #{size}px;"
  }, [
    T.div {class: "instructions relative"}, [
      draw_caller('turn',  1)
      draw_caller('go', 0)
      draw_caller('turn', -1)
    ]
    T.div {class: "instructions declarative"}, [
      world.get('controls').get('children').map draw_buttons
    ]
    T.p "More coming soon..."
  ]
