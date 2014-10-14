exports.draw_controls = {
  common: "value"
  _children: {
    instructions: {
      click: (world, args) ->
        turtle = args.get 'turtle'
        key = args.get 'key'
        value = args.get 'value'
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
