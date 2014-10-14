exports.draw_controls = {
  common: "value"
  _children: {
    instructions: {
      click: (world, args) ->
        console.log ("click #{world} #{args}")
        {turtle, key, value} = args
        -> turtle.call(key, {dir: value})
      _children: {
        Left: {turn: 1}
        Go: {go: 0}
        Right: {turn: -1}    
      }
    }
    activity: {}    
  }
}
