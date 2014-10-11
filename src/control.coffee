exports.control = (T, world) ->
  me = world.get("ME")
  T.div {class: "controls"}, [
    T.div {class: "controls"}, [
      T.button {
        init: -> @click =>
          console.log(me.get("j"))
          me.put("j", me.get("j") - 1)
          console.log(me.get("j"))
      }, "West"
      T.button "North"
      T.button "South"
      T.button "East"
    ]
    T.p "Goodbye"
  ]
