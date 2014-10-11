exports.control = (T, world) ->
  T.div {class: "controls"}, [
    T.div {class: "controls"}, [
      T.button "West"
      T.button "North"
      T.button "South"
      T.button "East"
    ]
    T.p "Goodbye"
  ]
