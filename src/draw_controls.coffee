exports.draw_controls = {
  _children: {
    instructions: {
      click: (world, args) ->
        {label, key, value, queue} = args
        dict = {}
        dict[key] = value
        -> 
          console.log "queue.putChild(#{label}, #{dict})"
          queue.putChild(label, dict)
          console.log queue.doc
      _children: {
        Left: {turn: 1}
        Go: {go: 0}
        Right: {turn: -1}    
      }
    }
    activity: {
      click: (world, {turtle, key, value}) ->
        -> turtle.call(key, {dir: value})
      _children: {}
    }
  }
}
