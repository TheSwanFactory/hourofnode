exports.draw_controls = {
  queue: {}
  _children: {
    instructions: {
      click: (world, {turtle, key, value}) ->
        queue = world.get('queue')
        -> turtle.call(key, {dir: value})
        # activity.create(key, {dir: value})
      _children: {
        Left: {turn: 1}
        Go: {go: 0}
        Right: {turn: -1}    
      }
    }
    activity: {
      click: (world, {turtle, key, value}) ->
        -> turtle.call(key, {dir: value})
      _children: {
      }
    }
  }
}
